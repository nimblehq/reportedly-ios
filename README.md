# Nimble Reportedly iOS

Welcome guys! This is a quick guide to help you get started.

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Introduction

This project is an iOS mobile application written in Swift which is for replacing our normal Standuply report via Slack app. Users can register/log in our Nimble server, set/update notification alarms during standup time and provide standup answers via iOS phone. After provided all answers, they will be listed directly in a default Slack standup report channel for tracking purpose. This app is integrated with OAuth 2 API providing GraphQL endpoints. 

In near future, users will be able to do more stuffs like chapter subscriptions for only receiving reports from people in specified chapters,notifications filtering, etc.

## Project Setup

### Prerequisites

It's dangerous to go alone, make sure you have these! Follow the links to find out how to download and install them.

* [Xcode](https://itunes.apple.com/sg/app/xcode/id497799835?mt=12)
* [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#toc_3)
* [Xcode Command Line Tools and Fastlane](https://docs.fastlane.tools/getting-started/ios/setup/) (Just follow the **Installing fastlane** section)

### Installation

In your local machine, navigate to a folder you want to work from. Personally, I use `~/Documents/apps/`. So for example, I would do:

```
$ mkdir ~/Documents/apps/
$ cd ~/Documents/apps/
```

Then do a `git clone`. Remember that this command creates a folder called `reportedly_ios` so you **don't** have to create the folder first.

```
(apps) $ git clone git@github.com:nimblehq/reportedly_ios.git reportedly_ios
```

While you wait for the project to download, go make yourself a cup of coffee. You deserve it ;)

### Install Pods

Run the command to install the latest pods:

```
$ cd reportedly_ios/
(reportedly_ios) git:(develop) $ pod install
```

After you run this command, open the project. To do this, navigate into your `reportedly_ios` folder and open the `.xcworkspace` file.

**IMPORTANT!** You need to open `Reportedly.workspace`, **not** `Reportedly.xcodeproj`.

Alternatively, you can startup from the command line like this:

```
$ cd reportedly_ios/
(reportedly_ios) git:(develop) $ open Reportedly.xcworkspace/
```

## Development

Once Xcode starts up, check the status bar at the top of Xcode. It should say something like

`Reportedly | Build Reportedly: Succeeded | Today at 4:58 PM`

By default, your scheme will be **Reportedly**. This is for the future production version and you should not build it for now. Change the scheme to **Reportedly Staging** instead. You can also select a Simulator here if you're not building on a real iPhone.

If all's well and good, you should be able to just launch the Reportedly app on your simulator by pressing the Play button at the top left corner (it looks like a Play button), or by hitting `CMD + r`.

Give it some time to build and launch; the simulator should startup and launch the app automatically.

#### Troubleshooting (click to expand)

<details>
<summary><strong>Error: Team is Unknown</strong></summary>
This means you haven't signed in Xcode with an AppleID yet.

To fix this, in Xcode, open preferences by pressing `CMD + ,` or going to **Xcode > Preferences**.

Click on the **Accounts** tab.

Click the `+` at the bottom left, make sure **Apple ID** is selected and click **Continue**.

Enter `your apple id account` for the Apple ID and click **Next**.

Then enter `your default password` and click **Next**.

This should sign in with your account Personal Team and resolve the Unknown Team issue.
</details>

## Test

To run tests on a selected scheme on Xcode, just hit `CMD + u` and wait. Tests are stored in the `UnitTests` folder. We have a `UITests` folder but it's not in use as at the time of writing this README.

To run all tests in all available schemes using Fastlane, enter this command in Terminal:

```
$ (develop) bundle exec fastlane ios allTests
```

Protip: If `bundle exec` doesn't work, you can still just run
```
$ (develop) fastlane ios allTests
```

Fastlane just recommends that you use `bundle exec` to execute fastlane commands.

If everything works out, you should see an output like this:
```
[13:58:24]: Cruising back to lane 'ios allTests' 🚘

+------+-----------------------------------+-------------+
|                    fastlane summary                    |
+------+-----------------------------------+-------------+
| Step | Action                            | Time (in s) |
+------+-----------------------------------+-------------+
| 1    | default_platform                  | 0           |
| 2    | Switch to ios testProduction lane | 0           |
| 3    | run_tests                         | 50          |
| 4    | Switch to ios testStaging lane    | 0           |
| 5    | run_tests                         | 49          |
| 6    | Switch to ios testUat lane        | 0           |
| 7    | run_tests                         | 89          |
+------+-----------------------------------+-------------+

[13:58:24]: fastlane.tools finished successfully 🎉
```

## Final Note

If you still have issues setting up your environment to build and run the application, contact me for help over Slack. My name is Mikey on Slack ^^

## License

This project is Copyright (c) 2014-2020 Nimble. It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
