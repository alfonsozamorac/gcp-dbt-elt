# Use the official Python base image
FROM python:3.12-slim

# Set environment variables to ensure Python output is sent straight to terminal (e.g., logs)
ENV PYTHONUNBUFFERED=1

# Create and set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . /app/

# Expose any necessary ports
EXPOSE 8080

# Define the default command to run the dbt CLI
CMD ["dbt", "run"]
