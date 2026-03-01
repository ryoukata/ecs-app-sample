FROM golang:1.22-alpine AS builder

WORKDIR /app

ARG TARGETOS=linux
ARG TARGETARCH=amd64

# Leverage layer cache for dependencies.
COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Build a statically linked binary for the target platform.
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -trimpath -ldflags="-s -w" -o /out/app ./main.go

FROM gcr.io/distroless/static-debian12:nonroot

WORKDIR /
COPY --from=builder /out/app /app

EXPOSE 8080

ENTRYPOINT ["/app"]
