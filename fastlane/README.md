fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios allTests
```
fastlane ios allTests
```
Run all the tests
### ios testProduction
```
fastlane ios testProduction
```
Run tests for Production scheme
### ios testStaging
```
fastlane ios testStaging
```
Run tests for Staging scheme
### ios testUat
```
fastlane ios testUat
```
Run tests for UAT scheme

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
