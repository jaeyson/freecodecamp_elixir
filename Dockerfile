FROM elixir:alpine

ARG USER_ID
ARG GROUP_ID
ARG USERNAME
ARG WORKDIR

RUN addgroup -S -g ${GROUP_ID} ${USERNAME} && \
    adduser -S -u ${USER_ID} -G ${USERNAME} ${USERNAME}

USER ${USERNAME}

WORKDIR $WORKDIR

# COPY --chown=${USERNAME}:${USERNAME} . $WORKDIR

RUN mix local.hex --force && \
    mix local.rebar --force
