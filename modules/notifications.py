
import requests
import os

SLACK_WEBHOOK_URL = os.getenv("SLACK_WEBHOOK_URL", "https://hooks.slack.com/services/YOUR/WEBHOOK/URL")

def send_slack_notification(message):
    payload = {"text": message}
    response = requests.post(SLACK_WEBHOOK_URL, json=payload)
    if response.status_code == 200:
        print("✅ Slack notification sent")
    else:
        print(f"❌ Failed to send Slack notification: {response.text}")
