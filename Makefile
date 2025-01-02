.PHONY: help
help: ## print make targets 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run:
	@templ generate
	@go run cmd/main.go

.PHONY: go-install-air
go-install-air: ## Installs the air build reload system using 'go install'
	go install github.com/air-verse/air@latest

.PHONY: go-install-templ
go-install-templ: ## Installs the templ Templating system for Go
	go install github.com/a-h/templ/cmd/templ@latest