# Variables
BINARY_NAME=system-stats-backend
GO=go
BUILD_DIR=build
MAIN_FILE=main.go

.PHONY: all build clean run test help dev

# Default target
all: clean build

# Build the application
build:
	@echo "Building..."cd
	@mkdir -p $(BUILD_DIR)
	@$(GO) build -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_FILE)
	@echo "Build complete! Binary available at: $(BUILD_DIR)/$(BINARY_NAME)"

# Clean build artifacts
clean:
	@echo "Cleaning..."
	@rm -rf $(BUILD_DIR)
	@rm -rf docs/docs.go docs/swagger.json docs/swagger.yaml
	@go clean
	@echo "Clean complete!"

# Run the application
run:
	@$(GO) run $(MAIN_FILE)

# Run tests
test:
	@echo "Running tests..."
	@$(GO) test -v ./...

# Install dependencies
deps:
	@echo "Installing dependencies..."
	@$(GO) mod tidy
	@$(GO) mod download
	@echo "Dependencies installed!"

# Install development tools
dev-deps:
	@echo "Installing development dependencies..."
	@go install github.com/swaggo/swag/cmd/swag@latest
	@echo "Development dependencies installed!"

# Show help
help:
	@echo "Available targets:"
	@echo "  make          - Clean and build the application"
	@echo "  make build    - Build the application"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make run      - Run the application"
	@echo "  make test     - Run tests"
	@echo "  make deps     - Install project dependencies"
	@echo "  make dev-deps - Install development tools"
	@echo "  make help     - Show this help message"

dev:
	air

build:
	go build -o ./tmp/main .

clean:
	rm -rf ./tmp
