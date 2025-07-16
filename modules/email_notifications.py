import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os

EMAIL_HOST = os.getenv("EMAIL_HOST", "smtp.example.com")
EMAIL_PORT = int(os.getenv("EMAIL_PORT", 587))
EMAIL_USER = os.getenv("EMAIL_USER", "alert@example.com")
EMAIL_PASS = os.getenv("EMAIL_PASS", "yourpassword")
EMAIL_FROM = os.getenv("EMAIL_FROM", "alert@example.com")
EMAIL_TO = os.getenv("EMAIL_TO", "admin@example.com")

def send_email_notification(subject, body):
    msg = MIMEMultipart()
    msg["From"] = EMAIL_FROM
    msg["To"] = EMAIL_TO
    msg["Subject"] = subject

    msg.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP(EMAIL_HOST, EMAIL_PORT)
        server.starttls()
        server.login(EMAIL_USER, EMAIL_PASS)
        server.send_message(msg)
        server.quit()
        print("✅ Email alert sent")
    except Exception as e:
        print(f"❌ Failed to send email: {e}")
