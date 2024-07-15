FROM cgr.dev/chainguard/go@sha256:2aab312eba021f07c6adf80abe4cb3c34bace048157e3271a2e41991658562ce AS builder

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
