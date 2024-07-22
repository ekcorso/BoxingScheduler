# Boxing Scheduler

This app scrapes HTML calendar data from a gym's website to make it easier to sign up for popular classes as they become available, similar to a wait list.

- [License](#license)

## Introduction

This is a personal project built to solve a problem for myself: my boxing gym doesn't offer a wait list for classes. I got tired of checking their website and constantly refreshing to see if my favorite classes had any openings. Though the scheduling company that my gym uses does have an official API, I was not able to get the gym’s permission to use their API key.

Instead, I use `URLSession` to fetch the raw HTML from the gym's scheduling site and then parse it into Swift objects with `SwiftSoup`. The user can select the classes they want to “watch” for openings and get a notification when someone drops the class so they can sign up for it.

## Technical Features

- Scrapes HTML data from the gym's website.
- Parses HTML into Swift objects using `SwiftSoup`.
- Shows a list of all classes, when they occur, and their available openings.
- Allows user to select classes to watch.
- Sends notification to the user when a "watched" class becomes available.
- Allows user to schedule classes by opening a `WebView` of the gym's site from the app.
- Utilizes Google Cloud Scheduler and silent push notifications in lieu of a server. [Learn more about the backend here.](./BoxingSchedulerServer/functions/silently-notify-ios-app/README.md) 

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ekcorso/BoxingScheduler 
   ```
2. Open the project in Xcode.  
3. Run the project on your device or simulator.

## Usage

1. Open the app and navigate to the class schedule.
2. Add classes you want to watch for openings to your "Watched Classes" list.
3. Allow notifications to receive alerts when a class opens up.
4. If you receive a notification, tap the notification or open the app to see which class has an opening.
5. Tap "Schedule Now" in the "Available Classes" tab to open a web browser showing the gym's scheduling page. 

## How It Works

The app leverages several technologies and services to function:

- **HTML Scraping**: Uses `URLSession` to fetch raw HTML and `SwiftSoup` to parse the HTML data into Swift objects.
- **Background Processing**: A Google Cloud Scheduler job runs every hour, posting a message to a Pub/Sub topic.
- **Serverless Function**: A Python function deployed on Google Cloud listens for messages on the Pub/Sub topic. When triggered, it sends a silent push notification to the app.
- **Client-side Processing**: The app wakes up, makes a network request, processes the data, and sends a local push notification if a class is available.

## Limitations

- **Background Execution**: Apple restricts background execution time, possibly allowing only about 30 seconds when the app wakes up. [Learn more about background execution](https://developer.apple.com/documentation/uikit/app_and_environment/scenes/preparing_your_ui_to_run_in_the_background).
- **Notification Reliability**: Apple does not guarantee the delivery of notifications, which could prevent the app from waking up to do the necessary processing. [Read more about notification delivery](https://developer.apple.com/documentation/usernotifications/).

## Screenshots

Coming soon...

## License

This project is licensed under the BDS 3-Clause License. See the [LICENSE](./LICENSE.txt) file for details.

## Contact

For any inquiries or questions, please contact me at https://www.emilykcorso.com/contact.
