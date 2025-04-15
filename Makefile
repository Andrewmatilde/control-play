# Variables
BINARY_NAME=k8s-app
IMAGE_NAME=uhub.service.ucloud.cn/andrew/k8s-app
VERSION=$(shell git describe --tags --always --dirty)
GOOS=linux
GOARCH=amd64

.PHONY: all build clean docker-build docker-push help

# Default target
all: build

# Help target
help:
	@echo "Available targets:"
	@echo "  build         - Build the binary"
	@echo "  clean         - Clean build artifacts"
	@echo "  docker-build  - Build Docker image (requires build first)"
	@echo "  docker-push   - Push Docker image to registry"
	@echo "  help          - Show this help message"

# Build the binary
build:
	CGO_ENABLED=0 GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(BINARY_NAME) \
		-ldflags "-X main.Version=$(VERSION)"

# Clean build artifacts
clean:
	rm -f $(BINARY_NAME)
	go clean

# Build Docker image (requires local binary)
docker-build: build
	docker build -t $(IMAGE_NAME):$(VERSION) .
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest

# Push Docker image
docker-push:
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest

# Run tests
test:
	go test -v ./... 