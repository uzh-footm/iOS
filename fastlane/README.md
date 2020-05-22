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
### ios pr_release
```
fastlane ios pr_release
```
Create GitHub PR from release to master
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
Build and upload a new build of Betterpick Mock TF to TestFlight

This action will also bump the build number
### ios deploy_beta_mocks
```
fastlane ios deploy_beta_mocks
```
Deploy a new testflight version while committing the results.
### ios deploy_screenshots
```
fastlane ios deploy_screenshots
```
Create and deploy a new set of screenshots.

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
