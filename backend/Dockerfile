#Base image
FROM python:3.11-slim

#Working directory
WORKDIR /app

#Environment Variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

#Install system dependencies
RUN apt-get update \
    && apt-get Install -y gcc libpq-dev \
    && rm -rf /var/lib/apt/lists/*

#Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#Copy project file
COPY . .

#Expose Port
EXPOSE 8000

#RUN FASTAPI
CMD [ "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000" ]