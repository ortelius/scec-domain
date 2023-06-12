FROM cgr.dev/chainguard/go@sha256:5d5471aaa4fb82d34b054c97b56343b9d394d50e10da5f2841f8f6b66ffa634c AS builder

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
