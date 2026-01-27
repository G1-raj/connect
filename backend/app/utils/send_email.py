import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# def send_mail(to_email: str, subject: str, body: str):
#     msg = MIMEMultipart()

#     msg["From"] = EMAIL_FROM
#     msg["To"] = to_email
#     msg["Subject"] = subject

#     msg.attach(MIMEText(body, 'html'))