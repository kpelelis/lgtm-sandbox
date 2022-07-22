apiVersion: 1

datasources:
- name: Prometheus
  type: prometheus
  access: proxy
  orgId: 1
  url: http://prom.${DOMAIN}
  isDefault: false
  version: 1
  editable: true
- name: Tempo
  type: tempo
  access: proxy
  orgId: 1
  url: http://tempo.${DOMAIN}
  isDefault: true
  version: 1
  editable: true
  apiVersion: 1
  uid: tempo
- name: Loki
  type: loki
  access: proxy
  orgId: 1
  url: http://loki.${DOMAIN}
  isDefault: false
  version: 1
  editable: true
  apiVersion: 1
  jsonData:
    derivedFields:
      - datasourceUid: tempo
        matcherRegex: (?:traceID|trace_id)=(\w+)
        name: TraceID
        url: $${__value.raw}
