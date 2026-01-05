# Use the official Node.js 18 image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your code (contracts, tests, config)
COPY . .

# Compile the contracts to ensure everything is valid
RUN npx hardhat compile

# Set the default command to run the test suite
CMD ["npx", "hardhat", "test"]
