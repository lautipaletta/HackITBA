# Use an official Node runtime as a parent image
FROM node:18.15

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY back-end/package*.json .

# Install any needed dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY back-end/ .

# Set the environment variables
ENV NODE_ENV=production
ENV MONGODB_URI=mongodb://mongo:27017/crowdfunding
ENV PORT=3000

# Expose the port the app will run on
EXPOSE $PORT

# Start the app
CMD ["npm", "start"]
