FROM golang:1.17.3-bullseye

# protobuf のバージョン
ARG PB_VER=3.19.1

# M1 mac の場合は aarch_64 にする
ARG CPU_ARCHITECTURE=x86_64

RUN apt-get update && \
    apt-get install -y curl unzip clang-format

RUN cd /tmp \
    && curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v${PB_VER}/protoc-${PB_VER}-linux-${CPU_ARCHITECTURE}.zip \
    && unzip protoc-${PB_VER}-linux-${CPU_ARCHITECTURE}.zip \
    && mv bin/ /usr/local/ \
    && mv include/ /usr/local/ \
    && rm -f *

RUN go install golang.org/x/tools/cmd/goimports@v0.1.7 \
    && go install github.com/kisielk/errcheck@v1.6.0 \
    && go install golang.org/x/lint/golint@latest \
    && go install github.com/client9/misspell/cmd/misspell@v0.3.4 \
    && go install github.com/cosmtrek/air@v1.27.3 \
    && go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26 \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1

WORKDIR "/go/src/github.com/taka521/chat"

COPY go.mod go.sum ./
RUN go mod download
