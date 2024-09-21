# Use a base Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt /app/

# Install required dependencies with the flag to ignore root warnings
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Copy the rest of the code
COPY . /app

# Expose the port your app will be running on
EXPOSE 8080

# Run the Python application
ENTRYPOINT ["python3", "app.py"]
