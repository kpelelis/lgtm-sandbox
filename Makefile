#!make

include .env
export

TEMPLATES = $(wildcard ./configs/*.tpl) $(wildcard ./configs/*/*.tpl)
CONFIGS = $(TEMPLATES:.tpl=)
SSL_SUBJECT="/C=US/ST=NY/O=Grafana/Local/localityName=Grafana/Local/commonName=*.$DOMAIN/organizationalUnitName=Grafana/Local/emailAddress=me@grafana.com"

%: %.tpl
	@echo 'Generating configs'
	envsubst < $< > $@

all: clean configs

configs: $(CONFIGS)

OSFLAG := $(shell uname -s)

%.key:
	mkdir -p certs
	openssl genrsa -out certs/$@ 2048

%.csr: %.key
	openssl req -new -subj "$(SSL_SUBJECT)" -key certs/$< -out certs/$@

%.crt: %.csr
	openssl x509 -req -days 3650 -in certs/$< -signkey certs/$(<:.csr=.key) -out certs/$@
	rm -f certs/$(<:.key=.csr)

install-certificates: $(DOMAIN).crt
ifeq ($(OSFLAG), Linux)
	mkdir -p /usr/share/ca-certificates/$(DOMAIN)
	cp certs/$< /usr/share/ca-certificates/$(DOMAIN)/
	apt-get install ca-certificates
else ifeq ($(OSFLAG), Darwin)
	security add-trusted-cert -d -r trustRoot /Library/Keychains/System.keychain certs/$<
endif

clean:
	rm -f $(CONFIGS)
	rm -f certs/*

.PHONY: all clean
