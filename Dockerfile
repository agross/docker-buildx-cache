FROM alpine:latest

RUN --mount=type=cache,target=/root/bin,sharing=locked \
    printf '#!/usr/bin/env sh\necho hello\n' > /root/bin/foo && \
    chmod +x /root/bin/foo

# Force the next layer to never be cached.
COPY random /

RUN --mount=type=cache,target=/root/bin,sharing=locked \
    ls -la /root/bin && \
    /root/bin/foo
