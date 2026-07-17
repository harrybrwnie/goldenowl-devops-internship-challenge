FROM node:22.23.1-trixie-slim@sha256:e6d9a389d34ff9678438af985c9913fbd1eb6ed36e80fea56644f4b4f6dd70ba AS production-dependencies

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev && npm cache clean --force

FROM gcr.io/distroless/nodejs22-debian13:nonroot@sha256:a2723a2817c5b01b8e7b98d567bc8b5a6b0e713e25bfb0a82b6ade4b9db06f50 AS runtime

ENV NODE_ENV=production \
    PORT=3000

WORKDIR /app

COPY --from=production-dependencies --chown=nonroot:nonroot /app/node_modules ./node_modules
COPY --chown=nonroot:nonroot index.js healthcheck.js ./
COPY --chown=nonroot:nonroot routes ./routes
COPY --chown=nonroot:nonroot server ./server

USER nonroot:nonroot

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD ["/nodejs/bin/node", "/app/healthcheck.js"]

CMD ["index.js"]
