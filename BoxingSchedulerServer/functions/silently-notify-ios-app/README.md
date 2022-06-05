# Silently Notify iOS App

## Prerequisites

### Google Cloud Scheduler

This project requires the `gcloud` command, pointed at a Google Cloud project
with a Google Cloud Pub/Sub topic `cron-topic` and a Google Cloud Scheduler job
targeting that topic (running every e.g. 10 minutes). Follow the steps from the
following Google tutorials.

- https://cloud.google.com/scheduler/docs/schedule-run-cron-job
- https://cloud.google.com/scheduler/docs/tut-pub-sub

### Environment Variables

Export the following environment variables (perhaps via
[direnv](https://direnv.net/)).

- `FIREBASE_CLOUD_MANAGER_SERVER_KEY` from
  [the Firebase console](https://console.firebase.google.com/) > Project
  settings > Cloud Messaging tab > Cloud Messaging API (Legacy)
- `FIREBASE_CLOUD_MANAGER_TOKEN` printed in the iOS app by implementing a
  delegate method. See
  [this tutorial](https://swiftsenpai.com/testing/send-silent-push-notifications/).

## Install

```zsh
pip install -r requirements.txt
```

## Running

```zsh
python main.py
```

## Deploy

```zsh
./deploy-secrets
./deploy-function
```

To force the remote function to run, to verify the deployment before its next
scheduled run:

```zsh
gcloud functions call "${PWD##*/}" --data='{}'
```
