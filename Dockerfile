# Stage 1: Build
FROM node:18-alpine AS build

WORKDIR /app

# Copy file package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all
COPY . .

# Build project
RUN npm run build

# Stage 2: Serve
FROM nginx:stable-alpine

# Copy build to nginx
# COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=build /app/dist /usr/share/nginx/html/vue-cvgenerator

# Copy nginx config custom (opsional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
