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
`pod 'MOHUD', '~> 0.2' `
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
