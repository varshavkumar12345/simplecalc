# Use Node.js for frontend if required
FROM node:18 AS frontend

WORKDIR /app

# Copy and install frontend dependencies
COPY package.json ./
RUN npm install

# Copy rest of the frontend files
COPY . .

# Build frontend (adjust as needed)
RUN npm run build

# Backend
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=frontend /app /app

EXPOSE 5000

CMD ["python", "app.py"]
