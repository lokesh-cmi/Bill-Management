FROM golang:1.20-alpine AS build-env

RUN mkdir /app
WORKDIR /app

COPY . .
RUN go mod tidy && go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o invoicemanagement

EXPOSE 9020

FROM scratch
COPY ./ ./
COPY --from=build-env /app/invoicemanagement invoicemanagement
CMD ["./invoicemanagement"]