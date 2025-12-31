FROM node:25-trixie AS build

# create a staging area for assets
WORKDIR /opt/distroless-assets

# copy node binary with parent structure
RUN cp --parents /usr/local/bin/node .

# copy libatomic with parent structure using wildcard to support multi-arch
# e.g. /usr/lib/x86_64-linux-gnu/libatomic.so.1 or /usr/lib/aarch64-linux-gnu/...
RUN cp --parents /usr/lib/*/libatomic.so.1 .

# final stage
FROM gcr.io/distroless/cc-debian13

# copy all staged assets to root
COPY --from=build /opt/distroless-assets /

ENTRYPOINT ["/usr/local/bin/node"]
