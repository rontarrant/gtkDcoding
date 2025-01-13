---
title: "0057: Cairo I – The Basics of Drawing"
layout: post
topic: cairo
tag: cairo
description: GTK Tutorial - introduction to drawing with Cairo.
author: Ron Tarrant

---

# 0057: Cairo I – The Basics of Drawing

Today we're going to put the MVC series aside for a few weeks while we dive into another series on a topic near and dear to my heart... graphics. We’ll start simple and get more complicated as we go. But first, we need to look at some foundation stuff...

## The Imports

To do anything with *Cairo*, you need to add these two lines to your list of import statements:

```d
import cairo.Context;
import gtk.DrawingArea;
```

Perhaps surprisingly, you won’t need to add a lot more to this list for most *Cairo* operations.

## The DrawingArea

Yup, it’s like an overhead projector. You prep whatever you’re going to show off to one side, then slap it onto the projector to shine it on the wall. Same thing here, and setting them up? Nothing to it:

```d
class MyDrawingArea : DrawingArea
{
	//               R   G    B    Alpha
	float[] rgba = [0.3, 0.6, 0.2, 0.9];
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
```

Ignoring the `rgbaColor` array for the moment, to prepare a `DrawingArea`, you just:

- instantiate it,
- write a callback function and
- hook up the `onDraw` signal to call the callback.

That’s it. But anything you plan to show with the `DrawingArea` ‘projector’ you’ll need to prep first. And you do that off-screen with the `DrawingArea`’s constant companion...

## The Context

This is like a paste-up board. You take bits and pieces of images, shapes, lines, etc., mix in some color and build the image you want to show on the `DrawingArea`. When it’s ready, you call one of the `Context`’s many functions to slap your results onto the `DrawingArea` projector.

But to show this, we need an example, so let’s start with something simple like...

## A Simple Fill

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_01_fill_surface.d" target="_blank">here</a>.
	</div>
</div>

Let's start by looking at the callback function... which is where the fill is done:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	context.setSourceRgba(rgba[0], rgba[1], rgba[2], rgba[3]);
	context.paint();

	return(true);
		
} // onDraw()
```

Here, all we do is:

- set the color, and
- fill the entire `DrawingArea`.

And that is *Cairo* drawing at its simplest.

A Technical Note: You’ll notice the `onDraw()` function’s first argument is `Scoped!Context`. `Scoped!` is a *GtkD* reflection of `D`’s `scoped()` function and all it means is that the `Context` will be destroyed automatically when we’re done with it. It has to be done this way because it’s created automatically.

Now let’s look at a second simple example...

## Drawing a Line

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_02_draw_line.d" target="_blank">here</a>.
	</div>
</div>


The only thing different about this line-drawing example compared to the fill example is the callback function:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	context.setLineWidth(3);
	context.moveTo(100, 45);
	context.lineTo(249, 249);
	context.stroke();
		
	return(true);
		
} // onDraw()
```

In this operation, we do four things:

- set the width of the line to draw,
- move the ‘pen’ to where the line starts,
- decide where the line will end, and
- stroke it.

But what if you want to draw...

## Multiple Lines with Rounded Ends

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_cairo/cairo_03.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal4" class="modal">																<!-- modal# -->
				<span class="close4">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img44">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal4");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img4");														// img#
			var modalImg = document.getElementById("img44");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close4")[0];										// close#
			
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
			<img id="img5" src="/images/screenshots/018_cairo/cairo_03_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal5" class="modal">																			<!-- modal# -->
				<span class="close5">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img55">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal5");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img5");																	// img#
			var modalImg = document.getElementById("img55");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close5")[0];													// close#
			
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

	<div class="frame-footer">																							<!---------- filename (below) ---------->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_03_draw_rounded_lines.d" target="_blank">here</a>.
	</div>
</div>


In this third, multi-line example, we just add a few preparatory commands to get the Context set up:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	context.setLineWidth(10);
	context.setLineCap(CairoLineCap.ROUND);	
	context.setLineJoin(CairoLineJoin.ROUND);
	context.moveTo(10, 10);
	context.lineTo(249, 249);
	context.lineTo(450, 15);
	context.lineTo(450, 249);
	context.stroke();
		
	return(true);
		
} // onDraw()
```

It’s mostly just more of what we’ve already been doing, but there are two new lines in there that make the ends and angles of the lines rounded.

So you know what all the options are for `setLineCap()`, here they are:

- `CairoLineCap.BUTT`,
- `CairoLineCap.ROUND`, and
- `CairoLineCap.SQUARE`.

And the options for `setLineJoin()` are:

- `CairoLineJoin.MITER`,
- `CairoLineJoin.ROUND`, and
- `CairoLineJoin.BEVEL`.

One other note: The set of `lineTo()` calls will draw a continuous line with three legs. If instead you want two separate lines, you would change the second `lineTo()` call to a `moveTo()` like this:

```d
context.moveTo(10, 10);
context.lineTo(249, 249);
context.moveTo(450, 15);
context.lineTo(450, 249);
context.stroke();
```

## Conclusion

So, to use a `DrawingArea`, we now know we need to instantiate it and hook up the `onDraw` signal. Also, we need a behind-the-scenes `Context` (automatically supplied in most cases) for preparing any drawing before it hits the `DrawingArea`.

Next time we continue with *Cairo* and look at rectangles. Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/26/0056-mvc-ix-a-combobox-with-flair.html">Previous: ComboBox with Flair</a>
	</div>
	<div style="float: right;">
		<a href="/2019/08/02/0058-cairo-ii-rectangles.html">Next: Cairo Rectangles</a>
	</div>
</div>
