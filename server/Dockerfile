# Dockerfile for Node.js backend
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project files
COPY . .

# Expose the backend port (change if necessary)
EXPOSE 5000

# Start the Node.js server
CMD ["node", "server.js"]
