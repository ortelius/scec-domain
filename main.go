package main

import (
	"context"
	"fmt"
	"log"
	"net/http"

	"github.com/arangodb/go-driver"
	"github.com/gofiber/fiber/v2"
	"github.com/ortelius/scec-commons/database"
	"github.com/ortelius/scec-commons/model"
)

var dbconn = database.InitializeDB()

func GetDomains(c *fiber.Ctx) error {

	parameters := map[string]interface{}{}

	aql := `FOR domain in books
			RETURN domain`

	ctx := driver.WithQueryCount(context.Background())
	cursor, err := dbconn.Database.Query(ctx, aql, parameters)

	if err != nil {
		log.Fatalf("Failed to run query: %v", err)
	}

	defer cursor.Close()

	var domains []model.Domain

	for {
		var domain model.Domain
		meta, err := cursor.ReadDocument(ctx, &domain)
		if driver.IsNoMoreDocuments(err) {
			break
		} else if err != nil {
			log.Fatalf("Failed to read document: %v", err)
		}
		domains = append(domains, domain)
		fmt.Printf("Got doc with key '%s' from query\n", meta.Key)
	}

	return c.JSON(domains)
}

func GetDomain(c *fiber.Ctx) error {

	key := c.Params("key")
	parameters := map[string]interface{}{
		"key": key,
	}

	aql := `FOR domain in books
			FILTER (domain.name == @key or domain._key == @key)
			RETURN domain`

	ctx := driver.WithQueryCount(context.Background())
	cursor, err := dbconn.Database.Query(ctx, aql, parameters)

	if err != nil {
		log.Fatalf("Failed to run query: %v", err)
	}

	defer cursor.Close()

	var domain model.Domain

	if cursor.Count() == 0 { // not found so get from NFT Storage
		key, cid2json := database.FetchFromLTS(key)
		domain.Key = key
		domain.UnmarshalNFT(cid2json)
	} else {
		for {
			meta, err := cursor.ReadDocument(ctx, &domain)
			if driver.IsNoMoreDocuments(err) {
				break
			} else if err != nil {
				log.Fatalf("Failed to read document: %v", err)
			}
			fmt.Printf("Got doc with key '%s' from query\n", meta.Key)
		}
	}
	return c.JSON(domain)
}

func NewDomain(c *fiber.Ctx) error {

	var err error
	var meta driver.DocumentMeta

	domain := new(model.Domain)
	if err = c.BodyParser(domain); err != nil {
		return c.Status(503).Send([]byte(err.Error()))
	}

	cid2json := make(map[string]string, 0)

	nft := domain.MarshalNFT(cid2json)

	fmt.Printf("%+v\n", nft)

	meta, err = dbconn.Collection.CreateDocument(dbconn.Context, domain)

	if err != nil && !driver.IsConflict(err) {
		log.Fatalf("Failed to create document: %v", err)
	}
	fmt.Printf("Created document in collection '%s' in db '%s' key='%s'\n", dbconn.Collection.Name(), dbconn.Database.Name(), meta.Key)

	database.PersistOnLTS(cid2json)

	return c.JSON(domain)
}

func DeleteDomain(c *fiber.Ctx) error {
	return c.Status(http.StatusForbidden).SendString("Deleting objects is not allowed")
}

func setupRoutes(app *fiber.App) {

	app.Get("/msapi/domain", GetDomains)
	app.Get("/msapi/domain/:key", GetDomain)
	app.Post("/msapi/domain", NewDomain)
	app.Delete("/msapi/domain/:key", DeleteDomain)
}

func main() {
	app := fiber.New()
	setupRoutes(app)
	app.Listen(":3000")
}
