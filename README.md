# MOHUD
A simple HUD to indicate activity, success, and failure.


#Description
MOHUD is a smilpe HUD written in swift using storyboard for its Views.

<iframe src="http://gifs.com/embed/y580lQ" frameborder="0" scrolling="no" width='152' height='270' style="-webkit-backface-visibility: hidden;-webkit-transform: scale(1);" ></iframe>

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
