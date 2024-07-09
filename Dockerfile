FROM cgr.dev/chainguard/go@sha256:0b3fbcaec43485c31b38ecd25d1ad28221f44453d8f66e56103ebc63b3d21c19 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:642cea2e3a79b6c8e0192270581245acd013ae2e1d4571945a4fc38ef430a9da

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
