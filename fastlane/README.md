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
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios tests_mocks
```
fastlane ios tests_mocks
```
Runs tests for the target that uses BetterpickAPIManagerMock
### ios tests
```
fastlane ios tests
```
Runs tests
### ios generate_docs
```
fastlane ios generate_docs
```
Documentation generation via Jazzy
### ios beta_mocks
```
fastlane ios beta_mocks
```
Testflight Beta mocks

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
