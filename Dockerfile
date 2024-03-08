FROM cgr.dev/chainguard/go@sha256:f7c4f59793fce0de9fedd5901ad724c8bb872c428ff23f59cc6eb112dc9a74c2 AS builder

WORKDIR /app
COPY . /app

RUN go install github.com/swaggo/swag/cmd/swag@latest; \
    /root/go/bin/swag init; \
    go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:0cc5960c42000ac15e08e4e0e77e34412019a122c5d74e066cadbb2d3c65a6b9

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/docs docs

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
