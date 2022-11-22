FROM python:3.9-slim

# Create working directory and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

# Copy the app service to the container
COPY service/ ./service/

# Create and switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080","--log-level=info", "service:app"]