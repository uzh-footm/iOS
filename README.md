# Betterpick for iOS [![Build Status](https://travis-ci.com/uzh-footm/iOS.svg?branch=develop)](https://travis-ci.com/uzh-footm/iOS)

Welcome to the open source iOS application that lets you browse players and clubs from FIFA19.

## Getting Started

1. Install [Xcode](https://developer.apple.com/xcode/downloads/) from Apple.
2. Install [cocoapods](https://guides.cocoapods.org/using/getting-started.html).
3. Install dependencies (run this in the root folder of the repo)
```
pod install
```
4. Open `Betterpick.xcworkspace`
5. Take a look at the `AppDelegate.application(application:didFinishLaunchingWithOptions:)` func where things kick off :)
6. (Optional) build and run `Betterpick Mock` target to preview the app with hardcoded mock data.


## Project Info

| iOS Deployment Target | Architecture | Autolayout | UnitTests | UITests |
| :---: | :---: | :---: | :---: | :---: |
| 11.0+ | MVVM-C | Code (no storyboards) ✅ | ✅ | ❌ |

### Features

- [x] Browse FIFA Clubs from all competitions (leagues).
- [x] Browse between FIFA players with various filtering options (OVR range, nationality, position...)
- [x] Show player and team details
- [x] Search players / clubs by name
- [ ] Create custom teams

### Project Structure

```bash
├── Betterpick
│   ├── AppDelegate.swift                # App entrypoint
│   ├── Discover                         # constructs related to the Discover screen
│   │   ├── Class
│   │   ├── Coordinator
│   │   ├── Extensions
│   │   ├── Model
│   │   ├── Protocol
│   │   ├── View
│   │   ├── ViewController
│   │   └── ViewModel
│   ├── MyTeams
│   ├── Player
│   ├── Settings
│   ├── Supporting Files                 # configs, .plist, Xcode assets
│   ├── TabBar                           # The root ViewControllers and TabBar related stuff
│   ├── Team
│   └── common                           # constructs that are reused across multiple screens
├── assets
│   └── screenshots                      # the screenshots
├── docs
│   └── src                              # generated HTML docs by Jazzy
└── fastlane
    ├── Appfile
    ├── Fastfile                         # Main fastlane setup file
    ├── Matchfile
    ├── Snapfile
    └── actions                          # custom fastlane actions
```

### Documentation

Documentation is available via [GitHub Pages](https://uzh-footm.github.io/iOS/). Updated on each new app release.

### Tools and 3rd party software

* [fastlane.tools](https://fastlane.tools) 🚀 - responsible for automating common tasks, such as:
  * testing - starts the UI and Unit tests on the main target
  ```bash 
  $ bundle exec fastlane tests
  ```
  * creating new releases
  ```bash
  $ bundle exec fastlane pr_release 
  ```
* [Jazzy](https://github.com/realm/jazzy) 🎺 - generates the project documentation
* [SwiftLint](https://github.com/realm/SwiftLint)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage) 
* [Travis-CI](http://travis-ci.com) 🤖 for continuous integration (running time-consuming lanes such as deployment to the App Store / TestFlight) 

## Screenshots

<table>
  <tr>
    <td>Discover Teams</td>
    <td>Team Detail</td>
    <td>Player Detail</td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/en-US/iPhone 11 Pro-01DiscoverTeamsScreen.png" width=270 height=584></td>
    <td><img src="assets/screenshots/en-US/iPhone 11 Pro-02TeamScreen.png" width=270 height=584></td>
    <td><img src="assets/screenshots/en-US/iPhone 11 Pro-03PlayerDetailScreen.png" width=270 height=584></td>
  </tr>
 </table>

## Contributing

This project is intended to be an educational resource for either our team and also anyone looking for a small-sized iOS project with:

* MVVM-C architecture
* Autolayout done without storyboards and any autolayout DSL. Pure UIKit.
* Custom UI components (e.g [`TappableLabel`](Betterpick/TabBar/View/TabBarStackView.swift), [`TabBarStackView`](Betterpick/common/View/TappableLabel.swift), ...)
* Fastlane scripts that work on/with Travis

Please use issues and pull requests accordingly. Generally speaking, you would want to make a pull request from and to the develop branch. 

TestFlight invites are open.

## LICENSE

MIT

Finally, if you made it here and this project has helped you in any way, please let me know via [Twitter](http://twitter.com/dvdblk1337). 🙂