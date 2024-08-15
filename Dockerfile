FROM cgr.dev/chainguard/go@sha256:e26da2b5a90fc6acee2ae81e5014ce26197a864da92f933e751f7d2b5abe6822 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:a76418d2b76f678fba9e8b29b8545bd35b3ca1e69827e532db175b0143337c1a

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
