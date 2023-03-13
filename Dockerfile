# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Install app dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy the source code into the container
COPY . .

# Build the app
RUN yarn build

# Lint the code
RUN yarn lint

# Check formatting
RUN yarn format:check

# Run unit tests and generate coverage report
RUN yarn test:cov

# Run end-to-end tests
RUN yarn test:e2e

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run the app in production mode
CMD ["node", "dist/main.js"]
