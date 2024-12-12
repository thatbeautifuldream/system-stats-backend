FROM golang:latest AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y gcc libc6-dev

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=1 GOOS=linux go build -o main .

# Final stage
FROM debian:stable-slim

WORKDIR /app

# Install runtime dependencies
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy binary from builder
COPY --from=builder /app/main .

# Expose port
EXPOSE 3000

CMD ["./main"] 