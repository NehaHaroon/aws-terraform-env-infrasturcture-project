# Stage 1: Build
FROM node:20-alpine AS build
WORKDIR /app
COPY ./frontend ./frontend
COPY ./backend ./backend
# Build backend
WORKDIR /app/backend
RUN npm install && npm run build
# Build frontend
WORKDIR /app/frontend
RUN npm install && npm run build

# Stage 2: Run
FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/backend/dist ./backend
COPY --from=build /app/frontend/build ./frontend
# Install a simple static server for frontend
RUN npm install -g serve
# Start both services via PM2 or concurrently
RUN npm install -g pm2
CMD ["pm2-runtime", "start", "ecosystem.config.js"]