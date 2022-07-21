# Grafana Stack Docker Compose Sandbox

This is a very primitive docker compose playground that spins up
Grafana stack services (Loki, Prometheus, Tempo). The aim of this
is to simulate as close as possible a cloud stack.

Note: This project is still under testing and is due to failures

## Requirements

* Docker with compose. [Installation](https://docs.docker.com/engine/install/)

## Setup

### Hostnames

This project is using Traefik as its gateway, and thus we can use
FQDNs to address the services directly. To achieve that we need to
add the following lines to `/etc/hosts` file

```
127.0.0.1 loki.grafana-sandbox.local
127.0.0.1 prom.grafana-sandbox.local
127.0.0.1 tempo.grafana-sandbox.local
127.0.0.1 grafana.grafana-sandbox.local
```

Or you can replace `grafana-sandbox.local` with the domain of your
choosing.

One other (not recommended) way would be to have a public DNS
(like cloudflare), resolve the wildcard hostname into your local
network IP.

Note: In case you are using a different hostname, you also need to
update the `./configs/grafana/datasources.yml` file to match that

### Generate env file

You need to generate the env file

```
$ cp .env.example .env
```

And then replace the variables to your needs

```
DOMAIN: The domain/hostname used throughout the Installation
DNSMASQ_IMAGE: Image to use for dnsmasq. This should be 
  jcowey/dnsmasq-arm for ARM based machines
  strm/dnsmasq for others
```

### Run the compose

To run all the services do

```
$ docker compose --env-file .env -p grafana-sandbox u
```

You can watch the status of the containers with

```
$ docker compose ps
```

That's it really.

## Accessing the services

All services are accessible under `{grafana,prom,loki,tempo}.${domain}`

For example you can access grafana through your browser if you navigate
at grafana.grafana-sandbox.com

## Roadmap

- [] HTTPS support
- [] Fix tempo
- [] Simplify setup with a Makefile
- [] Config generators
- [] Multi tenancy
