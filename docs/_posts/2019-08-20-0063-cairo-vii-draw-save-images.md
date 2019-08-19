---
title: "0063: Cairo VII – Draw and Save Images"
layout: post
topic: cairo
description: GTK Tutorial on drawing and saving images with Cairo.
author: Ron Tarrant

---

# 0063: Cairo VII – Draw and Save Images

So, this time we’re going to draw some images and then save them.

***Warning**: These images are* not *high art and may or may not cause harm to your artistic sensibilities. (You’ve now been officially cautioned.)*

In fact, because all these images are just a rectangle with text overlaid, I’m not even going to go over how they’re drawn. I’ll just say this one thing…

If you want a draw operation to be on top of another—like text overlaid on a rectangle, for instance—foreground draw operations need to be done *after* background draw operations. You probably sorted that out on your own, but there it is anyway.

## Saving Images – Basic Procedure

Every time we save an image, we carry out the same set of operations:

- find the size of the `DrawingArea`,
- grab the full expanse of the `DrawingArea`’s `Surface` that we want to save and stuff it into a buffer,
- set up the save options and option values for the image (this is different for each format), and
- save the image.

But since each has their own save options, we’ll look at each individually starting with…

## Saving a JPeg

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_018_20.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_018_20_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_20_draw_save_jpeg.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screenshots on a single page -->

Here’s the initialization section:

```d
GtkAllocation size;
Pixbuf pixbuf;
string[] jpegOptions, jpegOptionValues;
int xOffset = 0, yOffset = 0;
```

We used a `GtkAllocation` object before, the main purpose of which is to get the size allocated to a `Widget`—in this case, the `DrawingArea`—so we don’t have to guess.

The `Pixbuf` is the buffer we’re going to stuff the image into as we prepare to save and the rest are pretty obvious:

- `jpegOptions`: an array of save options,
- `jpegOptionValues`: an array of values for each of the save options,
- `xOrigin`, `yOrigin`: the offset from the top-left corner of the `DrawingArea`.

*Note: If `xOffset` and `yOffset` are non-zero, we won’t be saving the entire image.*

*Note 2: The last two arguments to the `getFromSurface()` call (see the `onDraw()` snippet below), if less than the width and height of the `Surface`, will also save less than the entire image. Taking these two notes together, I'm sure you arrived at the conclusion that you can save any rectangular area of the Surface you choose.*

I haven’t bothered with width and height variables here because these examples all save the entire `DrawingArea` and so we use the width and height fields from the `GtkAllocation` as we’ll see in a moment.

The constructor is so mundane as to warrant skipping in this discussion… so we shall.

As for the callback, we’ll leave out the drawing bit and go right for the meat:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	// set up and draw a rectangle
	// (see code file)

	// set up and draw text
	// (see code file)

	getAllocation(size); // grab the widget's size as allocated by its parent
	pixbuf = getFromSurface(context.getTarget(), xOffset, yOffset, size.width, size.height); // the contents of the surface go into the buffer

	// prep and write JPEG file
	jpegOptions = ["quality"]; 
	jpegOptionValues = ["100"];

	if(pixbuf.savev("./rectangle_hw.jpg", "jpeg", jpegOptions, jpegOptionValues))
	{
		writeln("JPEG was successfully saved.");
		
	}

	return(true);
	
} // onDraw()
```

And here’s what’s happening:

- get the size of the `DrawingArea` with `getAllocation(size)`,
- grab either the entire `Surface` or a subsurface (by supplying a non-zero offset) and stuff it into a buffer (that’s the `Pixbuf`),
- set up the *JPeg* save options and their values, and
- call `Pixbuf.savev()` to save the image.

### Save Options for JPeg

- "icc-profile" - the complete ICC profile encoded into base64
- "quality" - 0 … 100
- “x-dpi” - dots per inch (reasonable values: 50 to 300)
- “y-dpi” - dots per inch (same as x-dpi: 50 to 300)

And that’s all there is to it.

## Saving a PNG

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_018_21.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_018_21_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_21_draw_save_png.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screenshots on a single page -->


Since everything else is the same, let’s skip right to the part of the callback that does the saving:

```d
// prep and write to a PNG
pngOptions = ["x-dpi", "y-dpi", "compression"];
pngOptionValues = ["150", "150", "1"];
	
if(pixbuf.savev("./rectangle_hw.png", "png", pngOptions, pngOptionValues))
{
	writeln("PNG was successfully saved.");
	
}
```

So the differences here (compared to our first example) are:

- set up the PNG save options, and
- the values for each.

### Save Options for PNG

- "x-dpi"	dots per inch (reasonable range is 50 to 300)
- "y-dpi"	dots per inch (same as x-dpi: 50 to 300)
- "tEXt::key" - an ASCII string of length 1 – 79, UTF-8 encoded strings
- "compression" - 0 … 9
- "icc-profile"	- the complete ICC profile encoded into base64

## Saving a TIFF

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_cairo/cairo_018_22.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/018_cairo/cairo_018_22_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_22_draw_save_tiff.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->


As with the others, just set up the options and save:

```d
tiffOptions = ["bits-per-sample", "compression"];
tiffOptionValues = ["8", "1"];
	
if(pixbuf.savev("./rectangle_hw.tiff", "tiff", tiffOptions, tiffOptionValues))
{
	writeln("TIFF was successfully saved.");
		
}
```

### Save Options for TIFF

- "bits-per-sample"
	- "1" for saving bi-level CCITTFAX4 images
	- "8" for saving 8-bits per sample
- "compression"
	- "1" for no compression
	- "2" for Huffman
	- "5" for LZW
	- "7" for JPEG
	- "8" for DEFLATE (see the libtiff documentation and tiff.h for all supported codec values)
- "icc-profile" - (zero-terminated string) containing a base64 encoded ICC color profile.

## Saving a BMP

<!-- 6, 7 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img6" src="/images/screenshots/018_cairo/cairo_018_23.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal6" class="modal">																<!-- modal# -->
				<span class="close6">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img66">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal6");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img6");														// img#
			var modalImg = document.getElementById("img66");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close6")[0];										// close#
			
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
			<img id="img7" src="/images/screenshots/018_cairo/cairo_018_23_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal7" class="modal">																			<!-- modal# -->
				<span class="close7">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img77">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal7");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img7");																	// img#
			var modalImg = document.getElementById("img77");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close7")[0];													// close#
			
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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_23_draw_save_bmp.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for fourth (4th) occurrence of application and terminal screenshots on a single page -->

Everything’s the same, but there are no listed options so you have to pass in two empty arrays like this:

```d
if(pixbuf.savev("./rectangle_hw.bmp", "bmp", [], []))
{
	writeln("BMP was successfully saved.");
		
}
```

## Conclusion

And that’s most of what there is to saving images using Cairo. Next time, we’ll start digging into animation.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/16/0062-cairo-vi-load-display-images.html">Previous: Cairo Load & Display Images</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/08/23/0064-cairo-vii-drawingarea-animation.html">Next: Cairo DrawingArea Animation</a>
	</div>
-->
</div>
