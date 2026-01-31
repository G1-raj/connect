import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from app.core.config import (
    EMAIL_HOST,
    EMAIL_PORT, 
    EMAIL_USERNAME,
    EMAIL_PASSWORD,
    EMAIL_FROM
)

def send_mail(to_email: str, subject: str, body: str):
    msg = MIMEMultipart()

    msg["From"] = EMAIL_FROM
    msg["To"] = to_email
    msg["Subject"] = subject

    msg.attach(MIMEText(body, 'html'))

    with smtplib.SMTP(EMAIL_HOST, EMAIL_PORT) as server:
        server.starttls()
        server.login(EMAIL_USERNAME, EMAIL_PASSWORD)
        server.send_message(msg)