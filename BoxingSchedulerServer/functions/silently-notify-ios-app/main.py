"""A Google Cloud function to send a silent notification to an iOS app, waking
it up to perform work on the client."""

import os

import requests

FIREBASE_CLOUD_MANAGER_SERVER_KEY = os.environ["FIREBASE_CLOUD_MANAGER_SERVER_KEY"]
FIREBASE_CLOUD_MANAGER_TOKEN = os.environ["FIREBASE_CLOUD_MANAGER_TOKEN"]


def main(_event, _context):
    """Triggered from a message on a Cloud Pub/Sub topic.
    Args:
         event (dict): Event payload.
         context (google.cloud.functions.Context): Metadata for the event.
    """

    resp = requests.post(
        "https://fcm.googleapis.com/fcm/send",
        headers={
            "Authorization": f"key={FIREBASE_CLOUD_MANAGER_SERVER_KEY}",
        },
        json={
            "to": FIREBASE_CLOUD_MANAGER_TOKEN,
            "content_available": True,
            "apns-priority": 5,
            "data": {"some-key": "some-value"},
        },
    )

    print(resp)


if __name__ == "__main__":
    main(None, None)
