.PHONY: help
help: ## print make targets 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#####################
## Installation

.PHONY: install-air
install-air: ## Installs the air build reload system using 'go install'
	go install github.com/air-verse/air@latest

.PHONY: go-install-templ
install-templ: ## Installs the templ Templating system for Go
	go install github.com/a-h/templ/cmd/templ@latest

.PHONY: install-lib
install-lib: ## Installs libraries
	go get -u github.com/a-h/templ
	go get github.com/labstack/echo/v4
	go get github.com/haatos/goshipit

.PHONY: install-tailwindcss
install-tailwindcss: ## Installs the tailwindcss cli
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
	chmod +x tailwindcss-linux-x64
	mv tailwindcss-linux-x64 tailwindcss
	npm i -D daisyui@latest

.PHONY: install-tailwindcss-mac
install-tailwindcss-mac: ## Installs the tailwindcss CLI for macOS
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-macos-x64
	chmod +x tailwindcss-macos-x64
	mv tailwindcss-macos-x64 tailwindcss
	npm i -D daisyui@latest

#####################
### Run!

.PHONY: build
build: ## same than 'air' command to execute the app (just to know what is executing air)
	./tailwindcss -i ./static/css/custom.css -o ./static/css/style.css
	templ fmt .
	templ generate
	go build -o tmp/main ./cmd
	go run cmd/main.go

#####################
### Force clean up

.PHONY: reload
reload: ## force clean and build
	kill -9 $(lsof -ti:3001) || true
	templ generate
	go build -o tmp/main ./cmd
	go run cmd/main.go

.PHONY: fullreload
fullreload: ## force clean and build
	pkill -9 air || true
	kill -9 $(lsof -ti:3001) || true
	find . -type f -name '*_templ.go' -exec rm {} \;
	rm -rf tmp
	go clean -cache
	templ generate
	templ fmt .
	go build -o tmp/main ./cmd
	echo "Refresh page using [Cmd + Shift + R]"


