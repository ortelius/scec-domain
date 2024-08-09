FROM cgr.dev/chainguard/go@sha256:d1dd86fbdfd50c231dc0f8fd9768fbbc31df25baed17e25aab76d24a503a7d44 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:7cbd1cd7a6a1ca37de8d242ade7e65253323d1991611ebcb20b15347a95b8ebf

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
