# MOHUD
A simple HUD to indicate activity, success, and failure.


#Description
MOHUD is a smilpe HUD written in swift using storyboard for its Views.
#Demo
[![Demo Doccou alpha](https://j.gifs.com/y580lQ.gif)](https://youtu.be/02KHdUj7AMA)


#Installation
Just Drag-drop the MOHUD folder into your project.
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


#license

MIT
