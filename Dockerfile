FROM php:8.2-cli

# Install dependencies
RUN apt-get update && apt-get install -y unzip git libprotobuf-dev protobuf-compiler

# Install build tools (if using Debian/Ubuntu base)
RUN apt-get update && apt-get install -y \
    git build-essential autoconf libtool pkg-config \
    unzip cmake

# Install gRPC PHP extension
RUN pecl install grpc && docker-php-ext-enable grpc

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

RUN composer require grpc/grpc google/protobuf

EXPOSE 50051

