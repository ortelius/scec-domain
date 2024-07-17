FROM cgr.dev/chainguard/go@sha256:80ebff2d788e242fa5c03a0788f7cf0660d4ab470df95839b3eeb6ced45b3108 AS builder

WORKDIR /app
COPY . /app

RUN go mod tidy; \
    go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:5567380ef73d947c834960aa127784eef821c69596366dd48caf77736e854bc2

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
