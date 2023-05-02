FROM cgr.dev/chainguard/go:latest AS builder

WORKDIR /app
COPY . /app

RUN go build -o main .

FROM cgr.dev/chainguard/static:latest

WORKDIR /app
COPY --from=builder /app/main /app/main

USER nonroot
ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1

ENTRYPOINT ["/app/main" ]
