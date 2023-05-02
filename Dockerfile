FROM cgr.dev/chainguard/go@sha256:598027417e0a039dc326c958feb5a088447bec198ad74207d854558106b3318f AS builder

WORKDIR /app
COPY . /app

RUN go build -o main .

FROM cgr.dev/chainguard/glibc-dynamic@sha256:5232dc864c3aec8b87e6eee9a6f52237ab8aeede886d3bbd0b30467524bf0d54

WORKDIR /app
COPY --from=builder /app/main .

ENV ARANGO_HOST localhost
ENV ARANGO_USER root
ENV ARANGO_PASS rootpassword
ENV ARANGO_PORT 8529
ENV MS_PORT 8080

EXPOSE 8080

ENTRYPOINT [ "/app/main" ]
