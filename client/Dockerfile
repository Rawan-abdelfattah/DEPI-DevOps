# Dockerfile for React frontend
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project files
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the build using Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose the Nginx port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
