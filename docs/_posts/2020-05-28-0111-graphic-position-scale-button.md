---
title: "0111: A Scale Widget to Control Graphic Placement"
layout: post
topic: scale
description: This GTK Tutorial covers a D-specific implementation of Scale Widget controlling placement of a graphic element.
author: Ron Tarrant

---

# 0111: A Scale Widget to Control Graphic Placement

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/011_misc/misc_011_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/011_misc/misc_011_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/011_misc/misc_011_02_scale_to_animation.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Last time, we did the simple version of a `Scale` button. If you didn’t read that—depending on your skill level—it might be helpful in understanding what’s going on in today’s post. So, no mucky about, let’s get down to it...

## The Scale-v-DrawingArea Demo

Okay, because we’re doing a bit of graphic work this time, we’ll need to import the usual graphical culprits:

```d
import cairo.Context;
import gtk.DrawingArea;
```

And in the `AppBox` class, we’ll be setting up two widgets, the `Scale` and a `DrawingArea`:

```d
class AppBox : Box
{
	MyScale myScale;
	int localPadding = 0, globalPadding = 10;
	bool expand = false, fill = false;
	MyDrawingArea myDrawingArea;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myDrawingArea = new MyDrawingArea();
		myScale = new MyScale(myDrawingArea);

		packStart(myScale, expand, fill, localPadding);
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox
```

We went over all this stuff in the *Cairo* drawing series (which started in [blog post 0057](/2019/07/30/0057-cairo-i-the-basics.html) and continued to [blog post 0064](/2019/08/23/0064-cairo-vii-drawingarea-animation.html)), so let’s move on to the more relevant details...

### The MyScale Callback Function

This is where the action is:

```d
void valueChanged(Range range)
{
	double scaleValue = getValue();
	ballDisplay.setBallPosition(cast(int)scaleValue);
		
} // valueChanged()
```

The callback hook-up is the same as the previous example, so no need to go over it again here. If you need to refresh your memory on this point, take a look at [the previous post](/2020/05/17/0110-scale-button.html).

Breaking it down, we:
- call the inherited function `Scale.getValue()`, 
- so we can set the function-local variable `scaleValue`,
- which is then passed to `ballDisplay`’s `setBallPosition()` function.

What’s `ballDisplay`? That’s how the `MyScale` class refers to the `DrawingArea` we stuffed into the `AppBox`. Here’s what I mean...

### MyScale’s Constructor

Take a look at the constructor’s argument:

```d
this(MyDrawingArea myDrawingArea)
{
	super(Orientation.HORIZONTAL, minimum, maximum, step);
		
	ballDisplay = myDrawingArea;
	addOnValueChanged(&valueChanged);
		
} // this()
```

The `AppBox` passes in a pointer to the `DrawingArea` which is then renamed as `ballDisplay` to put it into context for the coming operations. Not `Context` as in `Cairo Context`, but context as in circumstances... specifically, the circumstances of accessing the `DrawingArea` from the `Scale` button.

### The MyDrawingArea Class

Let’s break this class down a bit...

#### The Class Preamble

```d
class MyDrawingArea : DrawingArea
{
	int ballX;
```

This variable keeps track of where the ball's position... where it is at any given moment at runtime. We’ll see how that works momentarily.

#### The Constructor

```d
this()
{
	ballX = 30;
		
	addOnDraw(&onDraw);
		
} // this()
```

We set an initial position for the graphic—a ball—and hook up the callback function which we’ll talk about now...

#### The Callback

As is usual with a `DrawingArea` callback, all we do is draw:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	context.setLineWidth(3); // prepare the context
	context.arc(ballX, 50, 10, 0, 2 * 3.1415); // define the circle as an arc
	context.stroke(); // and draw

	return(true);
		
} // onDraw()
```

We set a line width, define the ball shape, draw it, and we’re out of there. Responding to changes in the `Scale`’s slider happens in a different function:

#### The setBallPosition() Function

And this function is called directly from MyScale’s callback (the callback being the function which reacts to movement of the `Scale` slider):

```d
void setBallPosition(int x)
{
	x *= 15; // move the ball a noticeable distance
	ballX = x + 30;
	queueDraw();
		
} // setBallPosition()
```

Now, because the `Scale`’s `Range` is from `0` to `10`, using a one-to-one ratio for moving the ball isn’t going to be that noticeable, so the first thing we do is take the value passed in from `MyScale`’s callback and multiply it by `15`. That way we don't have to squint to see the ball move.

Next, we update the value of `ballX`, the ball’s position, and finally, force the `DrawingArea` to do a redraw.

And that, ladies and gents, is that.

## Conclusion

It’s fairly straightforward to control the position of a graphic in a `DrawingArea` using a `Scale` button (or, in fact, a `ScaleButton`, but that I’ll leave as an exercise for you if you’re so inclined).

Until next time, be brave, code well, and don’t let the bugs bite.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/05/17/0110-scale-button.html">Previous: The Scale Button</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/06/08/0112-gtk-gio-application-barebones.html">Next: The GTK/GIO Application - Introduction</a>
	</div>
-->
</div>

