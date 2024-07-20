# Boxing Scheduler

This app scrapes HTML calendar data from a gym's website to make it easier to sign up for popular classes as they become available.

- [License](#license)

## Introduction

This is a personal project built to solve a problem for myself: my boxing gym doesn’t offer a waitlist for classes. I got tired of checking their website and constantly refreshing to see if my favorite classes had any openings. Though the scheduling company that my gym uses does have an official API, I was not able to get the gym’s permission to use their API key.

Instead, I use `URLSession` to fetch the raw HTML from the scheduling site and then parse it into Swift objects with `SwiftSoup`. The user can select the classes they want to “watch” for openings and get a notification when someone drops the class so they can sign up for it.

