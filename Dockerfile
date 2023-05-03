FROM cgr.dev/chainguard/go@sha256:598027417e0a039dc326c958feb5a088447bec198ad74207d854558106b3318f AS builder

WORKDIR /app
COPY . /app

RUN go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:d71ef5ebe6f4b6e5fb621e5bb187affd1b6a105aa16f88b0a9115a73dd16ddf4

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
