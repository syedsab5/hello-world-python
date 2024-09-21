# Use a base Python image
FROM python:3.9-slim

# Set environment variables to prevent .pyc files and buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create a new user
RUN addgroup --system appgroup && adduser --system --group appuser

# Set the working directory
WORKDIR /app

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt /app/

# Install required dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the code
COPY . /app

# Change ownership of the app folder to the non-root user
RUN chown -R appuser:appgroup /app

# Expose the port your app will be running on
EXPOSE 8080

# Switch to the non-root user
USER appuser

# Run the Python application
ENTRYPOINT ["python3", "app.py"]
