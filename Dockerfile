FROM golang:1.21 as builder
WORKDIR /workspace
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download
COPY main.go main.go
WORKDIR /workspace
RUN CGO_ENABLED=0 GOOS=linux go build -a -o app main.go

FROM ubuntu
WORKDIR /
COPY --from=builder /workspace/app .
RUN apt update && apt install -yqq ca-certificates iproute2 netcat tcpdump curl lsof
ENTRYPOINT ["/app"]
