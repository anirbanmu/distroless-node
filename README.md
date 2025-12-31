# distroless-node

distroless images for node.js current (non-LTS) versions, starting with node 25.
based on `gcr.io/distroless/cc-debian13` (trixie).

**architecture**: `amd64`, `arm64` (apple silicon compatible).

## what's inside
- node.js (v25)
- `libatomic.so.1`
- **no shell, no npm/yarn/pnpm.**

## usage

use multi-stage builds. build with a standard image, run with this one.

```dockerfile
# build stage
FROM node:25-trixie AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

# runtime
FROM ghcr.io/anirbanmu/distroless-node:25
WORKDIR /app
COPY --from=build /app /app
CMD ["/app/index.js"]
```

## dev

build locally:
```bash
docker build --build-arg NODE_VERSION=25 -t my-node-image .
```
