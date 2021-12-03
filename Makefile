.PHONY: build proto

# 出力先のディレクトリ
BINDIR:=bin

# リビジョン
REVISION:=$(shell git rev-parse --short HEAD)

# ルートパッケージ名の取得
ROOT_PACKAGE:=$(shell go list ./...)

# コマンドとして書き出されるパッケージ名の取得
COMMAND_PACKAGES:=$(shell go list ./cmd/...)

# 出力先バイナリファイル名(bin/server など)
BINARIES:=$(COMMAND_PACKAGES:/cmd/%=$(BINDIR)/%)

# ビルド時にチェックする .go ファイル
GO_FILES:=$(shell find . -type f -name '*.go' -print)

# ビルドタスク
bin/%: cmd/%/main.go
	@go build -o $@ $<

proto:
	@protoc \
		-I ./adapter/grpc/proto \
		-I ./adapter/grpc/proto/service \
		-I ./adapter/grpc/proto/model \
		--go_out=./adapter/grpc/pb --go_opt=paths=source_relative \
		--go-grpc_out=./adapter/grpc/pb --go-grpc_opt=paths=source_relative \
		./adapter/grpc/proto/**/*.proto
