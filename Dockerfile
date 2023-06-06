FROM cgr.dev/chainguard/go@sha256:8454bbbb4061bd8fed6ce0b6de0d08c0a6037fe33e136b3f16dba31a68b9b3b6 AS builder

WORKDIR /app
COPY . /app

RUN go install github.com/swaggo/swag/cmd/swag@latest; \
    swag init; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:dd034b12e2dfa3f451fab9d31de5c47a05f78f09f88d662334194e2fa9d98610

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
