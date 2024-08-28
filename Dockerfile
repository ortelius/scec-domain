FROM cgr.dev/chainguard/go@sha256:2b57ddeaed404116df06ae4d45a1cd218cc80496c76afb64c9c0ef55a18fd777 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:0ff0755007e9f495d27af37bd8defff5856875fa65ed9b60a77388b332bdc773

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
