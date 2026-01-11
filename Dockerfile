# syntax=docker/dockerfile:1
# FROM --platform=$BUILDPLATFORM ruby:3.4.2-slim-bookworm
FROM ruby:3.4.2-slim-bookworm
# ARG TARGETPLATFORM
# ARG BUILDPLATFORM

WORKDIR /app

# RUN echo "$BUILDPLATFORM $TARGETPLATFORM"

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
      apt-get install --no-install-recommends -y \
      ca-certificates \
      curl gpg \
      git \
      curl \
      gpg gpg-agent \
      build-essential \
      zip \
      jq \
      gawk \
      unzip libreadline-dev libsasl2-dev libssl-dev zlib1g-dev libyaml-dev

COPY Gemfile Gemfile.lock .
RUN bundle install
COPY . .

CMD ["bin/dev"]
