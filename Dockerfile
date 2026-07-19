FROM ubuntu:20.04 AS builder
LABEL description="Container image to test building the AVR32 cross-compiler"

# Install cross-compiler prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -f tzdata
RUN apt-get install --no-install-recommends -y \
    curl \
    flex \
    bison \
    libgmp3-dev \
    libmpfr-dev \
    autoconf \
    build-essential \
    libncurses5-dev \
    libmpc-dev \
    unzip \
    git \
    ca-certificates \
    autotools-dev

# Build cross-compiler
WORKDIR /cross/avr32-toolchain

COPY Makefile .
COPY downloads downloads 
COPY patches patches

ENV PREFIX=/avr32-tools 
CMD [ "make", "install-cross" ]
