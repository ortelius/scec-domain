FROM cgr.dev/chainguard/go@sha256:88ab4eee6f27ec2b29169fdda045618b61c056c13e483afdca936a51344db0a1 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:7fa43737be034509a394129d6966fbb7fbb6cbc01f34ec03486f4acd5d657edc

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
