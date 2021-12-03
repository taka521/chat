.PHONY: build proto

# リビジョン
REVISION:=$(shell git rev-parse --short HEAD)

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
