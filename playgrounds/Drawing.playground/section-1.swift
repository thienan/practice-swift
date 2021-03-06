// Playground: Drawing with Swift
// Source: http://goo.gl/MYRQJl

import Cocoa
import XCPlayground

/**
==== Create a Rectangle ====
*/
var x = 0
var y = 0
var width = 300
var height = 300
var frameRect = NSRect(x: x,y: y,width: width, height: height)

/**
==== Image View ====
*/
var view = NSImageView(frame: frameRect)
var dogPictureUrl = NSURL(string: "https://openclipart.org/image/300px/svg_to_png/190758/lemmling_Cartoon_dog_Laughing.png")

// Get the picture
var dogPicture = NSImage(contentsOfURL: dogPictureUrl)

// Tell the view which image to display
view.image = dogPicture

/**
==== Show the picture in playground ====
*/
XCPShowView("DoG", view)


/**
==== Create an empty image ===
*/
var size = NSMakeSize(300, 300)
var img = NSImage(size: size)

/**
==== Draw a new image ====
*/
// Lock an image
img.lockFocus() // We want to draw in this image

NSRectFill(NSMakeRect(20, 30, 100, 50))

// Unlock an image
img.unlockFocus()

/**
==== Draw a line ====
*/
var img2 = NSImage(size: size)
img2.lockFocus()

/**
==== Create  a path ====
*/
var path = NSBezierPath()
// Move the path to the start point
path.move(to: NSPoint(x:0, y:0))
// End point
path.line(to: NSPoint(x: 100, y:500))
// Draw the pixels
path.stroke()

img2.unlockFocus()

/**
==== Draw a parabola ====
*/
var img3 = NSImage(size:size)

var shift = 0
while shift <= 200 {

    img3.lockFocus()
    var path2 = NSBezierPath()
    path2.move(to: NSPoint(x:shift, y:300))
    path2.line(to: NSPoint(x:0, y:shift))
    path2.stroke()
    img3.unlockFocus()

    shift += 5
}

var view3 = NSImageView(frame:frameRect)
view3.image = img3
XCPShowView(identifier: "Parabola", view: view3)
