# Use official Python image as base
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the app package and package-lock.json file
COPY package*.json ./

# Copy local directories to the current local directory of our docker image (/app)
COPY ./app /app
COPY ./requirements /requirements


# Install node packages, install serve, build the app, and remove dependencies at the end
RUN npm install \
    && npm install -g serve \
    && npm run build \
    && rm -fr node_modules

EXPOSE 3000

# Define the command to run the application
CMD ["python", "app.py"]
