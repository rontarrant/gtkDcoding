---
title: "0075: Cairo X – Mouse Noodling"
layout: post
topic: cairo
description: GTK Tutorial covering drawing a cubic Bezier curve on a DrawingArea.
author: Ron Tarrant

---

# 0075: Cairo X – Mouse Noodling

We’re still working our way through *Phase One* of this nodes-n-noodles concept and this time around, we’ll leave static noodles behind and get some animation happening.

## Controlling the Noodle with the Mouse

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/020_app/app_020_01_02.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal0" class="modal">																	<!-- modal# -->
				<span class="close0">&times;</span>															<!-- close# -->
				<img class="modal-content" id="img00">															<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal0");														// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img0");															// img#
			var modalImg = document.getElementById("img00");													// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close0")[0];											// close#
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function()
			{ 
				modal.style.display = "none";
			}
			</script>
			<figcaption>
			Current example output
			</figcaption>
		</figure>
	</div>

	<div class="frame-terminal">
		<figure class="right">
			<img id="img1" src="/images/screenshots/020_app/app_020_01_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal1" class="modal">																				<!-- modal# -->
				<span class="close1">&times;</span>																		<!-- close# -->
				<img class="modal-content" id="img11">																		<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal1");																	// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img1");																		// img#
			var modalImg = document.getElementById("img11");																// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close1")[0];														// close#
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function()
			{ 
				modal.style.display = "none";
			}
			</script>

			<figcaption>
				Current example terminal output (click for enlarged view)
			</figcaption>
		</figure>
	</div>

	<div class="frame-footer">																								<!-- ------------- filename (below) --------- -->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_01_02_cubic_bezier_follow_mouse.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The next step toward drawing a noodle connection between nodes entails two things:

- using the mouse position as the curve’s end point, and
- taking control of window redraw (animation).

 To that end, we’re going to borrow from an earlier *Cairo* animation example [Blog Post #0064](/2019/08/23/0064-cairo-vii-drawingarea-animation.html) as well as the mouse tracker example [Blog Post #0015](/2019/03/05/0015-enter-leave.html) we looked at back in March.

From these earlier examples, we’re reminded that:

- the mouse pointer’s position is supplied by the `onMotionNotify` signal, and
- gaining control over window redraw means working with a `Timeout` object.

## Draw and Redraw

The `Timeout` object, [as we saw before](https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_24_counter_animation.d), decides when we’ll call a function similar to this example’s `onFrameElapsed()` function (which is taken, unchanged, from [the mouse tracker](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_04_tracker.d) example):

```d
bool onFrameElapsed()
{
	GtkAllocation size;
	getAllocation(size);
		
	queueDrawArea(size.x, size.y, size.width, size.height);
		
	return(true);
		
} // onFrameElapsed()
```

What it does is:

- instantiate a `GtkAllocation` object from which we…
- extract the size of the `DrawingArea`, and
- call for a redraw.

### The Cubic Bezier’s Starting Point

For now, we’ll use a hard-coded starting point and turn our attention to another problem…

### Grabbing the Mouse Pointer Position

We can use the `onMotion()` function from [the mouse tracker example](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_04_tracker.d) to grab the mouse pointer position and use those x/y coordinates, along with the hard-coded starting point coordinates, to set our control points. From the previous post in this series, here’s a reminder of what those control point coordinates will be:

- the coordinates of the first control point are:
	- `x` is the same as the end point’s x,
	- `y` is the same as the start point’s y,
- the second control point’s coordinates:
	- `x` is the same as the start point’s x, and
	- `y` is the same as the end point’s y.

```d
public bool onMotion(Event event, Widget widget)
{
	// make sure we're not reacting to the wrong event
	if(event.type == EventType.MOTION_NOTIFY)
	{
		// get the curve's end point
		xEnd = event.motion.x;
		yEnd = event.motion.y;
			
		// Recalculate the control points so we always have
		// a nice-looking double curve.
		controlPointX1 = xEnd;
		controlPointY1 = yStart;
		controlPointX2 = xStart;
		controlPointY2 = yEnd;
	}

	return(true);
		
} // onMotion()
```

And indeed, in the `onMotion()` function, we’re doing just that. After grabbing the mouse pointer position to use as the curve’s end point (`xEnd`/`yEnd`), we set the `controlPoints` and we’re ready to draw the curve. And the drawing itself is handled by the `onDraw()` function.

### How the onDraw() Function Changes

Two things change in `onDraw()`:

- a `Timeout` object is harnessed to set the redraw rate in frames per second, and
- instantiation of the control point coordinates has moved up to the preamble section of the `MyDrawingArea` class.

And that leaves the `onDraw()` function looking like this:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	if(_timeout is null)
	{
		_timeout = new Timeout(fps, &onFrameElapsed, false);
	}

	// set up and draw a cubic Bezier
	context.setLineWidth(3);
	context.setSourceRgb(0.3, 0.2, 0.1);
	context.moveTo(xStart, yStart);
	context.curveTo(controlPointX1, controlPointY1, controlPointX2, controlPointY2, xEnd, yEnd);
	context.stroke();

	return(true);
		
} // onDraw()
```

And the `MyDrawingArea` preamble now looks like:

```d
Timeout _timeout;
int fps = 1000 / 24; // 24 frames per second
double xStart = 25, yStart = 128;
double xEnd, yEnd;
double controlPointY1 = 128, controlPointX2 = 25;
double controlPointX1, controlPointY2;
```

### The Constructor

As with the previous example, the constructor remains lean:

```d
this()
{
	addOnDraw(&onDraw);
	addOnMotionNotify(&onMotion);
		
} // this()
```

Hook up the signals and we’re done.

## Conclusion

So there you have it, run the example and move the mouse around within the window. The curve redraws as the mouse moves and always describes a cubic *Bezier* curve.

Next time, we’ll take another step wherein a mouse button is clicked to start the drawing of the curve.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/09/27/0074-cairo-doodle-a-noodle.html">Previous: Doodle a Noodle</a>
	</div>
	<div style="float: right;">
		<a href="/2019/10/04/0076-cairo-xi-noodles-and-mouse-clicks.html">Next: Noodles and Mouse Clicks</a>
	</div>
</div>
