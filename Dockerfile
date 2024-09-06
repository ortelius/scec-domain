FROM cgr.dev/chainguard/go@sha256:1b27d8f2f9bb49434e38fbb7456cb8b72b6652235bb07e2ee002d06f44821c29 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:b1620a369a98f45856657820fb8203adbc8b823ba7019c3bd84185ce45f7b395

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
