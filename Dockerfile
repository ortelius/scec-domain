FROM cgr.dev/chainguard/go@sha256:842c603ac2f4e441cb05ce8cc8ebd708eecffa20d3e6963551e78cee81ae2022 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:5915b6b2c9ff77916fc534d9c0676eaaf776964f674e4a6aeb6b43426c7db79a

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
