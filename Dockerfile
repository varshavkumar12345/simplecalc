# Stage 1: Build with Node.js
FROM node:18 AS builder
WORKDIR /app

# Ensure package.json is copied correctly
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json  # If using npm v7+

RUN npm install && npm install -g serve && npm run build

# Stage 2: Use Python as the final base image
FROM python:3.9

WORKDIR /app

# Copy built frontend from the Node.js stage
COPY --from=builder /app/build ./build

# Copy Python application files
COPY app /app.py
COPY requirements /requirements.txt

# Install Python dependencies
RUN pip install -r /requirements.txt

CMD ["python", "/app.py"]
