#!make

include .env
export

TEMPLATES = $(wildcard ./configs/*.tpl) $(wildcard ./configs/*/*.tpl)
CONFIGS = $(TEMPLATES:.tpl=)

%: %.tpl
	@echo 'Generating configs'
	envsubst < $< > $@

all: clean configs

configs: $(CONFIGS)

clean:
	rm -f $(CONFIGS)

.PHONY: all clean
