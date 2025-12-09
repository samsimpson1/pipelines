FROM alpine:3.23 AS builder

RUN apk add --no-cache go && \
  GOBIN=/go go install github.com/hetznercloud/cli/cmd/hcloud@latest

FROM alpine:3.23

RUN apk add --no-cache jq bash curl

COPY --from=builder /go/hcloud /usr/local/bin/hcloud
COPY storage-box-metrics.sh /usr/local/bin/storage-box-metrics

RUN chmod 755 /usr/local/bin/storage-box-metrics

ENTRYPOINT [ "/usr/local/bin/storage-box-metrics" ]

LABEL org.opencontainers.image.source="https://github.com/samsimpson1/pipelines"