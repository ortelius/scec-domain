FROM cgr.dev/chainguard/go@sha256:18244328dd66983f5736d0c0c8b6221d26531bbc7274e3765b6f22905ec4d397 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:09c74721beb055d94e49515381cc5118d85bae208e7ddefe1d28f6b355a1a6f5

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
