ARG PYTHON_BASE_VERSION=3.13


# Build stage
FROM python:${PYTHON_BASE_VERSION}-slim AS build

ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

COPY . .

# Run stage
FROM python:${PYTHON_BASE_VERSION}-slim
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY --from=build /app /app

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
