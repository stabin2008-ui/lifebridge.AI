# Multi-stage production build for LifeBridge AI
# Stage 1: Build Frontend and Backend
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json ./
COPY client/package*.json ./client/
COPY server/package*.json ./server/

RUN npm --prefix client install
RUN npm --prefix server install

COPY client ./client
COPY server ./server

RUN npm --prefix client run build
RUN npm --prefix server run build

# Stage 2: Production Runtime
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080

COPY package.json ./
COPY server/package*.json ./server/

RUN npm --prefix server install --omit=dev

COPY --from=builder /app/client/dist ./client/dist
COPY --from=builder /app/server/dist ./server/dist

EXPOSE 8080

CMD ["node", "server/dist/index.js"]
