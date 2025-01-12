.PHONY: help
help: ## print make targets 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#####################
## Installation

.PHONY: _install-air
_install-air: ## Installs the air build reload system using 'go install'
	go install github.com/air-verse/air@latest

.PHONY: _install-templ
_install-templ: ## Installs the templ Templating system for Go
	go install github.com/a-h/templ/cmd/templ@latest

.PHONY: _install-lib
_install-lib: ## Installs libraries
	go get -u github.com/a-h/templ
	go get github.com/labstack/echo/v4

.PHONY: _install-tailwindcss
_install-tailwindcss: ## Installs the tailwindcss cli
	curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
	chmod +x tailwindcss-linux-x64
	mv tailwindcss-linux-x64 tailwindcss
	npm i -D daisyui@latest

.PHONY: _install-tailwindcss-mac
_install-tailwindcss-mac: ## Installs the tailwindcss CLI for macOS
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

.PHONY: cleanup
cleanup: # clean up live process in same socket
	@pkill -9 "air" || echo "No process found for air"
	@lsof -ti:3001 | xargs -r kill -9 || echo "No process found on port 3001"

.PHONY: reload
reload: cleanup ## clean and compile
	@templ generate && templ fmt .
	./tailwindcss -i ./static/css/custom.css -o ./static/css/style.css
	go build -o tmp/main ./cmd
	air

.PHONY: air
air: cleanup ## clean and air execution
	air

.PHONY: fullreload
fullreload: cleanup ## force clean and build
	find . -type f -name '*_templ.go' -exec rm {} \;
	rm -rf tmp
	go clean -cache
	@templ generate
	./tailwindcss -i ./static/css/custom.css -o ./static/css/style.css
	templ fmt .
	go build -o tmp/main ./cmd
	echo "Refresh page using [Cmd + Shift + R]"