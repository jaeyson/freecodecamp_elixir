FROM elixir:alpine

ENV HOMEDIR /home/elixiruser/app

RUN addgroup -S -g 1001 elixiruser && \
    adduser -S -u 1000 -G elixiruser elixiruser

RUN mkdir -p $HOMEDIR
WORKDIR $HOMEDIR

USER elixiruser

RUN mix local.hex --force
RUN mix local.rebar --force
