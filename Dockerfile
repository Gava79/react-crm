# Use the official Node.js image from the Docker Hub
FROM node:18

ARG APP_NAME

# Validate the APP_NAME argument
RUN test -n "$APP_NAME"

# Install system packages
RUN apt-get update -y && \
    apt-get install -y \
    vim \
    wget \
    curl \
    net-tools \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Setup application directory
WORKDIR /home/node/"$APP_NAME"/"$APP_NAME"

# Copy application files
COPY --chown=node:node . .

# Copy the .env file if it exists
COPY .env ./

# Install npm dependencies
RUN npm install

# Install specific packages including type definitions
RUN npm install @react-oauth/google@latest react-app-rewired --save-dev \
    && npm install @types/react @types/react-dom @types/node --save-dev

# Update Browserslist database
RUN npx browserslist@latest --update-db

# Expose the port (if necessary, e.g., for a React app)
EXPOSE 3000

# Command to run the application using react-app-rewired instead of react-scripts
CMD ["npm", "start"]
