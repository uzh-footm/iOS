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
Build and upload a new build of Betterpick Mock TF to TestFlight

This action will also bump the build number
### ios pr_release
```
fastlane ios pr_release
```
Create a new Release Pull Request on GitHub.

Increments the build number and creates a new release branch from develop.

Release branch name is dependent on the app version and build number.
### ios deploy_screenshots
```
fastlane ios deploy_screenshots
```
Create and deploy a new set of screenshots.
### ios generate_and_commit_documentation
```
fastlane ios generate_and_commit_documentation
```
Generate and commit new documentation
### ios tag_release
```
fastlane ios tag_release
```
Create tag for a new Release

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
