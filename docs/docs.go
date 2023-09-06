// Code generated by swaggo/swag. DO NOT EDIT.

package docs

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "termsOfService": "http://swagger.io/terms/",
        "contact": {
            "name": "Ortelius Google Group",
            "email": "ortelius-dev@googlegroups.com"
        },
        "license": {
            "name": "Apache 2.0",
            "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
        },
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/msapi/domain": {
            "get": {
                "description": "Get a list of domains for the user.",
                "consumes": [
                    "*/*"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "domain"
                ],
                "summary": "Get a List of Domains",
                "responses": {
                    "200": {
                        "description": "OK"
                    }
                }
            },
            "post": {
                "description": "Create a new Domain and persist it",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "domain"
                ],
                "summary": "Create a Domain",
                "responses": {
                    "200": {
                        "description": "OK"
                    }
                }
            }
        },
        "/msapi/domain/:key": {
            "get": {
                "description": "Get a domain based on the _key or name.",
                "consumes": [
                    "*/*"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "domain"
                ],
                "summary": "Get a Domain",
                "responses": {
                    "200": {
                        "description": "OK"
                    }
                }
            }
        }
    }
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "11.0.0",
	Host:             "localhost:3000",
	BasePath:         "/msapi/domain",
	Schemes:          []string{},
	Title:            "Ortelius v11 Domain Microservice",
	Description:      "RestAPI for the Domain Object\n![Release](https://img.shields.io/github/v/release/ortelius/domain?sort=semver)\n![license](https://img.shields.io/github/license/ortelius/domain)\n\n![Build](https://img.shields.io/github/actions/workflow/status/ortelius/domain/build-push-chart.yml)\n[![MegaLinter](https://github.com/ortelius/domain/workflows/MegaLinter/badge.svg?branch=main)](https://github.com/ortelius/domain/actions?query=workflow%3AMegaLinter+branch%3Amain)\n![CodeQL](https://github.com/ortelius/domain/workflows/CodeQL/badge.svg)\n[![OpenSSF-Scorecard](https://api.securityscorecards.dev/projects/github.com/ortelius/domain/badge)](https://api.securityscorecards.dev/projects/github.com/ortelius/domain)\n\n![Discord](https://img.shields.io/discord/722468819091849316)",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}
