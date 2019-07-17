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
### ios certificates_ci
```
fastlane ios certificates_ci
```
Sync the keys, certificates and profiles for all targets
### ios tests
```
fastlane ios tests
```
tests
### ios screenshots
```
fastlane ios screenshots
```
screenshots
### ios beta
```
fastlane ios beta
```
beta
### ios build_appstore
```
fastlane ios build_appstore
```
build app store
### ios upload_testflight
```
fastlane ios upload_testflight
```
upload testflight
### ios clean
```
fastlane ios clean
```
clean

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
