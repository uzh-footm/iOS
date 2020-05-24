# Betterpick for iOS [![Build Status](https://travis-ci.com/uzh-footm/iOS.svg?branch=develop)](https://travis-ci.com/uzh-footm/iOS)

Welcome to the open source iOS app that lets you browse players and clubs from FIFA.

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

## Getting Started

1. Install [Xcode](https://developer.apple.com/xcode/downloads/) from Apple.
2. Install [cocoapods](https://guides.cocoapods.org/using/getting-started.html).
3. Install dependencies (run this in the root folder of the repo)
```
pod install
```
4. Open `Betterpick.xcworkspace`
5. (Optional) build and run `Betterpick Mock` target to preview the app with hardcoded mock data.

## Features

- [x] Browse FIFA Clubs from all competitions (leagues).
- [x] Browse between FIFA players with various filtering options (OVR range, nationality, position...)
- [x] Show player and team details
- [x] Search players / clubs by name
- [ ] Create custom teams

## Documentation

Documentation is available via [GitHub Pages](https://uzh-footm.github.io/iOS/). Updated on each new app release via Travis CI 🤖.

## LICENSE

MIT