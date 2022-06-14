# Silently Notify iOS App

## Prerequisites

- `gcloud`
- Export the following environment variables (perhaps via
  [direnv](https://direnv.net/)).
  - `FIREBASE_CLOUD_MANAGER_SERVER_KEY`, from
    [the Firebase console](https://console.firebase.google.com/) > Project
    settings > Cloud Messaging tab > Cloud Messaging API (Legacy).
  - `FIREBASE_CLOUD_MANAGER_TOKEN`, printed in the iOS app, by implementing a
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

### Upsert schedule changes

```zsh
./deploy-setup
```

### Upsert function source code changes

```zsh
./deploy-function
```

### Testing

To verify the deployment before its next scheduled run, you may want to force
the remote function to run. You should see an `OK` response.

```zsh
(export name="${PWD##*/}"; gcloud functions call "$name" --data='{}')
```

## Further Reading

- https://cloud.google.com/scheduler/docs/schedule-run-cron-job
- https://cloud.google.com/scheduler/docs/tut-pub-sub
