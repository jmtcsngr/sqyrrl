VERSION := $(shell git describe --always --tags --dirty)
ldflags := "-X sqyrrl/server.Version=${VERSION}"
build_args := -a -v -ldflags ${ldflags}


.PHONY: build build-linux build-darwin build-windows check clean coverage install lint test

all: build

build: build-linux build-darwin build-windows

build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build ${build_args} -o sqyrrl-linux-amd64 ./cmd/sqyrrl.go

build-darwin:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build ${build_args} -o sqyrrl-darwin-amd64 ./cmd/sqyrrl.go

build-windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build ${build_args} -o sqyrrl-windows-amd64.exe ./cmd/sqyrrl.go

install:
	go install -ldflags ${ldflags}

lint:
	golangci-lint run ./...

check: test

test:
	ginkgo -r --race

coverage:
	ginkgo -r --cover -coverprofile=coverage.out

clean:
	go clean
	$(RM) sqyrrl-*
