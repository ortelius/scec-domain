FROM cgr.dev/chainguard/go@sha256:da9f3e9fabb8fca3003cebbc2bff177e919b949307f5278efaaa26dd0639bcc3 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:4b457cbb96641fbe5d6056dee0a5ee840ec97a74bac448461b804ddffc858c73

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
