0076: Cairo XI – Noodles and Mouse Clicks

We’re up to step three as we work towards controlling the noodle drawing with the mouse.

This time, we’re going to toss out the hard-coded noodle starting coordinates and instead, when the user clicks a mouse button, take the coordinates from the location of the mouse pointer.

Start the Curve with the Mouse

<screen shot: cairo_018_29>

As implied above, this won’t be a complete solution, but we’re getting there. And to get this step to work, we need to change a couple of things in our code:

- harness the onButtonPress signal so we know when the mouse button is pressed, and
- set up and maintain a flag that will decide when the drawing routines will be called.

Harnessing the Mouse… Again

We know how to harness mouse button presses from [Blog Post 0014](), specifically [the mouse button press example](mouse_005_01_press.d).

First, we add onButtonPress to our growing list of signals in the MyDrawingArea constructor:

this()
{
	addOnDraw(&onDraw);
	addOnMotionNotify(&onMotion);
	addOnButtonPress(&onButtonPress);
		
} // this()

And add its callback:

public bool onButtonPress(Event event, Widget widget)
{
	bool returnValue = false;

	dragAndDraw = true;

	if(event.type == EventType.BUTTON_PRESS)
	{
		GdkEventButton* mouseEvent = event.button;
		xStart = event.button.x;
		yStart = event.button.y;
		
		returnValue = true;
	}

	return(returnValue);
		
} // onButtonPress()

One more little change…

Draw Flag

In the instantiation section of MyDrawingArea, we add a line:

bool doDrawing = false;

And it follows that we also have to make it do something. Where? In the onDraw() callback (note that this is an already-existing callback, not the one we just set up above) so it now looks like this:

bool onDraw(Scoped!Context context, Widget w)
{
	if(_timeout is null)
	{
		_timeout = new Timeout(fps, &onFrameElapsed, false);
	}

	if(dragAndDraw == true)
	{
		// set up and draw a cubic Bezier
		context.setLineWidth(3);
		context.setSourceRgb(0.3, 0.2, 0.1);
		context.moveTo(xStart, yStart);
		context.curveTo(controlPointX1, controlPointY1, controlPointX2, controlPointY2, xEnd, yEnd);
		context.stroke();
	}

	return(true);
		
} // onDraw()

All we’ve done here is to make the set of drawing instructions conditional. If the doDrawing flag is negative, we don’t do it.

Our example code, when run, will now have a drag-n-drop feel. The cubic Bezier curve won’t appear until we click with the mouse button. Then we can drag the Bezier curve out in any direction and the curve follows just like before. However, when the mouse button is clicked again, the drawing of the curve restarts from scratch, using the new mouse location as the starting point. 

The Final Step to Noodle Drawing

<screen shot: cairo_018_30>

What we’ve been working toward all this time is this:

- when the mouse button is pressed, the curve begins drawing at the position of the mouse,
- as the mouse moves, we see constant feedback as to what the final curve will look, and
- when we release the mouse button, the curve becomes static.

To get there, we need to harness one more signal, onButtonRelease. And the purpose of this signal is so we know when to stop drawing… That is, when we let go of the mouse button, the drawing should freeze.

So, once again, we add another signal hook-up to the constructor:

this()
{
	addOnDraw(&onDraw);
	addOnMotionNotify(&onMotion);
	addOnButtonPress(&onButtonPress);
	addOnButtonRelease(&onButtonRelease);

} // this()

And its callback:

public bool onButtonRelease(Event event, Widget widget)
{
	bool value = false;
		
	if(event.type == EventType.BUTTON_RELEASE)
	{
		GdkEventButton* buttonEvent = event.button;
		xEnd = event.button.x;
		yEnd = event.button.y;
		value = true;
	}

	dragAndDraw = false;

	return(value);
		
} // onButtonRelease()

A couple of things to note here:

1) no matter what, this callback always switches the dragAndDraw flag off, and
2) the curve’s end point is set just before the flag is switched off.

One More Look at the dragAndDraw Flag

There is one more place where this flag changes the flow of control and that’s in onFrameElasped():

bool onFrameElapsed()
{
	GtkAllocation size;
	getAllocation(size);
		
	if(dragAndDraw == true)
	{
		queueDrawArea(size.x, size.y, size.width, size.height);
	}
		
	return(true);
		
} // onFrameElapsed()

Here, we’re using the drawAndDraw flag to decide whether or not to queue up the next drawing operation. So what we end up with is this:

- the onButtonPress() callback enables curve drawing,
- as long as the mouse button is held down:
o curve drawing continues in the onDraw() callback, refreshing every 24th of a second, and
o as long as the mouse is moving, onMotion() continually updates the end position of the curve until…
- the mouse button is released and onButtonRelease turns off the drawing flag and the last mouse position reported by onMotion() becomes the final end point for the static curve.

Conclusion

So much for noodles. Next time, we’ll tackle nodes, eventually leading to a full-blown nodes-n-noodles example.

??

??

??

??

