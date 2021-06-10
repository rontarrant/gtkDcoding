---
title: "0076: Nodes-n-noodles III – Noodles and Mouse Clicks"
layout: post
topic: nodes
description: GTK Tutorial covering drawing a cubic Bezier curve on a DrawingArea.
author: Ron Tarrant

---

# 0076: Nodes-n-noodles III – Noodles and Mouse Clicks

We’re up to step three as we work towards drawing a noodle with the mouse.

This time, we’re going to toss out the hard-coded starting coordinates for the noodle and instead, when the user clicks a mouse button, take the coordinates from the location of the mouse pointer.

## Start the Curve with the Mouse

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/023_nodes/nodes_023_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/023_nodes/nodes_023_03_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/023_nodes/nodes_023_03_cubic_bezier_set_xy_start_with_mouse.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

As implied above, this won’t be a complete solution, but we’re getting there. And to get this step to work, we need to change a couple of things in our code:

- harness the `onButtonPress` signal so we know when the mouse button is pressed, and
- set up and maintain a flag that will decide when the drawing routines will be called.

### Harnessing the Mouse... Again

We know how to harness mouse button presses from [Blog Post #0014](/2019/03/01/0014-reacting-to-mouse-events.html), specifically [the mouse button press example](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_01_press.d).

First, we add `onButtonPress` to our growing list of signals in the `MyDrawingArea` constructor:

```d
this()
{
	addOnDraw(&onDraw);
	addOnMotionNotify(&onMotion);
	addOnButtonPress(&onButtonPress);
		
} // this()
```

And add its callback:

```d
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
```

One more little change...

### Draw Flag

In the instantiation section of `MyDrawingArea`, we add a line:

```d
bool dragAndDraw = false;
```

And it follows that we also have to make it do something. Where? We change our `onDraw()` callback so it now looks like this:

```d
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
```

All we’ve done here is to make the set of drawing instructions conditional. If the `dragAndDraw` flag is negative, we don’t do it.

Our example code, when run, will now have a drag-n-drop feel. The cubic *Bezier* curve won’t appear until we click with the mouse button. Then we can drag the *Bezier* curve out in any direction and the curve follows just like before. However, when the mouse button is clicked again, the drawing of the curve restarts from scratch, using the new mouse location as the starting point. 

## The Final Step to Noodle Drawing

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/023_nodes/nodes_023_04.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal2" class="modal">																<!-- modal# -->
				<span class="close2">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img22">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal2");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img2");														// img#
			var modalImg = document.getElementById("img22");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close2")[0];										// close#
			
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
			<img id="img3" src="/images/screenshots/023_nodes/nodes_023_04_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal3" class="modal">																			<!-- modal# -->
				<span class="close3">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img33">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal3");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img3");																	// img#
			var modalImg = document.getElementById("img33");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close3")[0];													// close#
			
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

	<div class="frame-footer">																							<!--------- filename (below) ------------>
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/023_nodes/nodes_023_04_draw_noodle_complete.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

What we’ve been working toward all this time is this:

- when the mouse button is pressed, the curve begins drawing at the position of the mouse,
- as the mouse moves, we see constant feedback as to how the curve looks, and
- when we release the mouse button, the curve becomes static.

To get there, we need to harness one more signal, `onButtonRelease`. And the purpose of this signal is so we know when to stop drawing... which is when we let go of the mouse button.

So, once again, we add another signal hook-up to the constructor:

```d
this()
{
	addOnDraw(&onDraw);
	addOnMotionNotify(&onMotion);
	addOnButtonPress(&onButtonPress);
	addOnButtonRelease(&onButtonRelease);

} // this()
```

And toss in an associated callback:

```d
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
```

A couple of things to note here:

1. no matter what, this callback always switches the `dragAndDraw` flag off, and
2. the curve’s end point is set just before the flag is switched off.

### One More Look at the dragAndDraw Flag

There is one more place where this flag changes the flow of control and that’s in `onFrameElasped()`:

```d
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
```

Here, we’re using the `dragAndDraw` flag to decide whether or not to queue up the next drawing operation. So what we end up with is this:

- the `onButtonPress()` callback enables curve drawing,
- as long as the mouse button is held down:
	- curve drawing continues in the `onDraw()` callback, refreshing every 24th of a second, and
	- as long as the mouse is moving, `onMotion()` continually updates the end position of the curve until...
- the mouse button is released and `onButtonRelease` turns off the drawing flag and the last mouse position reported by `onMotion()` becomes the final end point for the static curve.

## Conclusion

So much for noodles. Next time we pick up the nodes-n-noodles series, we’ll tackle nodes. And next time, we'll be looking at more common widgets.

Until then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/01/0075-nodes-ii-mouse-noodle.html">Previous: Mouse Noodle</a>
	</div>
	<div style="float: right;">
		<a href="/2019/10/08/0077-notebook-i-basics.html">Next: Notebook - The Basics</a>
	</div>
</div>
