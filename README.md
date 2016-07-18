[![Coverage Status](https://coveralls.io/repos/github/MoathOthman/MOHUD/badge.svg?branch=master)](https://coveralls.io/github/MoathOthman/MOHUD?branch=master)
[![Build Status](https://travis-ci.org/MoathOthman/MOHUD.svg?branch=master)](https://travis-ci.org/MoathOthman/MOHUD)
[![CocoaPods](https://img.shields.io/cocoapods/v/MOHUD.svg?maxAge=2592000?style=flat-square)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/MOHUD.svg?maxAge=2592000?style=plastic)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/MOHUD.svg?maxAge=2592000?style=plastic)]()
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/MOHUD.svg?maxAge=2592000?style=plastic)]()
[![codebeat badge](https://codebeat.co/badges/798c46ce-3d17-4118-8d1b-3c69c3d6a9c9)](https://codebeat.co/projects/github-com-moathothman-mohud)

# MOHUD
A simple HUD to indicate activity, success, and failure.


#Description
MOHUD is a smilpe HUD written in swift using storyboard for its Views.
 
MOHUD adds continue and cancel buttons the loader HUD optionally.

#Demo
[![Demo Doccou alpha](https://j.gifs.com/y580lQ.gif)](https://youtu.be/02KHdUj7AMA)


#Installation
##MANUAL
Just Drag-drop the MOHUD folder into your project.
##CocoaPods
`pod 'MOHUD' `
#How to Use
For Showing the HUD 

`
MOHUD.show()
`

For dismiss 

`MOHUD.dismiss()`

Show with custom status 

`MOHUD.show("Processing")`

Subtitle

` MOHUD.showSubtitle(title: "Connection", subtitle: "Please Wait", period: 3)`

Failure

`MOHUD.showWithError("Failed :(")`

Success

` MOHUD.showSuccess("You Made it")`

Showing HUD with Cancel buttons 

````
MOHUD.show(periodOfTime: 10, withCancelAndContinue: true)
MOHUD.setBlurStyle(.Dark)
MOHUD.onCancel = {
   debugPrint("User Canceled")
}
MOHUD.onContinoue = {
   debugPrint("User want to contniue without the progress indicator ")
}
````
#license

MIT
