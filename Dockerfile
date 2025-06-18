FROM golang:1.24.4-alpine3.21 as builder

WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM alpine:3.21

WORKDIR /root/
COPY --from=builder /app/app .

CMD ["./app"]