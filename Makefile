.PHONY: clean proto

# コマンドの定義
GO          = go
GO_BUILD    = $(GO) build
GO_FORMAT   = $(GO) fmt
GO_LIST     = $(GO) list
GO_TEST     = $(GO) test -v
GOARCH      = amd64
GOOS        = linux

# パラメータ
BINDIR       := bin
GO_PKGROOT   := ./...
GO_PACKAGES  := $(shell $(GO_LIST) $(GO_PKGROOT) | grep -v vendor)
CMD_PACKAGES := $(shell $(GO_LIST) ./cmd/...)
GO_FILES     := $(shell find . -type f -name '*.go' -print)
REVISION     := $(shell git rev-parse --short HEAD)

### ルール ###

# remove build artifacts
clean:
	@rm -rf ./bin/*

proto:
	@protoc \
		-I ./adapter/grpc/proto \
		-I ./adapter/grpc/proto/service \
		-I ./adapter/grpc/proto/model \
		--go_out=./adapter/grpc/pb --go_opt=paths=source_relative \
		--go-grpc_out=./adapter/grpc/pb --go-grpc_opt=paths=source_relative \
		./adapter/grpc/proto/**/*.proto

# 実ビルドタスク
bin/app: $(GO_FILES)
	@env GOOS=$(GOOS) go build -o $@ ./cmd/app/main.go
