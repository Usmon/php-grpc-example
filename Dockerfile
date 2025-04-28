FROM php:8.2-cli

# Install dependencies
RUN apt-get update && apt-get install -y unzip git libprotobuf-dev protobuf-compiler

# Install build tools (if using Debian/Ubuntu base)
RUN apt-get update && apt-get install -y \
    git build-essential autoconf libtool pkg-config \
    unzip cmake

# Clone and build grpc_php_plugin
RUN git clone -b v1.62.0 https://github.com/grpc/grpc /tmp/grpc && \
    cd /tmp/grpc && \
    git submodule update --init && \
    make grpc_php_plugin && \
    cp bins/opt/grpc_php_plugin /usr/local/bin/


# Install gRPC PHP extension
RUN pecl install grpc && docker-php-ext-enable grpc

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

RUN composer require grpc/grpc google/protobuf

EXPOSE 50051

