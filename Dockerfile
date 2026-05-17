FROM oven/bun:1 AS build
WORKDIR /app

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY . .
RUN bun run build

FROM pierrezemb/gostatic
COPY --from=build /app/dist /srv/http/
CMD ["-port", "8080", "-enable-logging"]
