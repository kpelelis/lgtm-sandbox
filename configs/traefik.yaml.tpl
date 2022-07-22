providers:
  docker:
    network: grafana-sandbox

api:
  dashboard: true

entryPoints:
  http:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: https
          scheme: https
  https:
    address: ":443"

log:
  level: DEBUG

tls:
  certificates:
    - certFile: /etc/tls/certs/${DOMAIN}.cert
    - keyFile: /etc/tls/certs/${DOMAIN}.key
