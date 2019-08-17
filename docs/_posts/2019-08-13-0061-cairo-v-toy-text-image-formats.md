---
title: "0061: Cairo V – Toy Text API and Image Formats"
layout: post
topic: cairo
description: GTK Tutorial on using Cairo's Toy Text API.
author: Ron Tarrant

---

# 0061: Cairo V – Toy Text API and Image Formats

These two topics are related in that, after a short intro to *Cairo*’s toy text API, we use it to print a list of available image formats on our *GTK* window. So, let’s start with…

## *Cairo*’s Toy Text API

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_018_15.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_018_15_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_15_text.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

*Cairo*’s text API has its limitations and thus it’s referred to as a toy. Doesn’t matter to me because I just wanna get some text all up in my context, so let’s just do it.

To write text in a *Cairo* `DrawingArea`, you need to do this:

- select a font,
- set the font size,
- set a text color,
- pick a place to write it, and
- call `showText()`.

If you wanna get fancy about it, like centering the text, you need to go a few extra steps.

### Text Extents

What it is: it’s the amount of space the text will take up in the `DrawingArea`.

How it’s calculated:

- do all the font settings from the first list above,
- get the width and height of the `DrawingArea`,
- ask the `Context`’s `textExtents()` function how much screen real estate the text will take up, and
- calculate where to place the text by subtracting the text extents width and height from the `DrawingArea`’s width and height.

And when you roll all that up into a callback, it looks like this:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	getAllocation(size);
	
	// set the font, size, and color
	context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
	context.setFontSize(35);
	context.setSourceRgb(0.0, 0.0, 1.0);

	// find the dimensions of the text so we can center it
	context.textExtents("Hello World", &extents);
	context.moveTo(size.width / 2 - extents.width / 2, size.height / 2 - extents.height / 2);
	context.showText("Hello World");
				
	return(true);
		
} // onDraw()
```

`Cairo`’s toy text API always left-justifies text, so if we want to center it or right justify, we’re on our own as the above calculations show. But then, this API isn’t about getting fancy; for that, we have *Pango* which we’ll deal with sometime down the road.

### Initializations

The only other thing we need to do is initialize a couple of variables at the top of the class:

```d
GtkAllocation size;
cairo_text_extents_t extents;
```

Now let’s move on and do some preliminary work for the up-coming mini-series within the *Cairo* series, loading and saving images, which is what we’ll do in the next post.

### Writing a List of Text Items to a DrawingArea

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_018_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_018_16_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_16_list_formats.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screenshots on a single page -->

We’re going to need a few extra bits and bobs of data to get this to work. Besides a `GtkAllocation` to retrieve `DrawingArea` dimensions, we also need:

```d
Pixbuf pixbuf;
ListSG formatList;
PixbufFormat pixbufFormat;
PixbufFormat[] pixbufFormats;
```

Here’s what they are and why we need them:

- `pixbuf` is a buffer associated with a *Cairo* `Surface`… effectively, it’s an image buffer tied to the `DrawingArea`,
- `formatList` is a singly-linked list of objects (`ListSG`), each of which can hold various types of data, in this case, each holds a string, the name of a format, and
- `pixbufFormat` and `pixbufFormats` are there so we can use a `foreach()` loop to step through and get the names of the formats.

The callback is a bit involved, so let’s look at it in chunks… although not all of this will be in the same order it appears in the code.

### Callback Chunk #1

```d
getAllocation(size);
pixbuf = getFromSurface(context.getTarget(), 0, 0, size.width, size.height);

formatList = pixbuf.getFormats();
pixbufFormats = formatList.toArray!PixbufFormat();
```

What we’re doing here is:

- `getAllocation()` gets us the size of the `DrawingArea`,
- `getTarget()` (found inside the call to `getFromSurface()`) gets us the *Cairo* `Surface` which allows us to…
- `getFromSource()` to grab the `Pixbuf`, and from that…
- we can use `getFormats()` to get the linked list of format strings, and finally
- use a bit of *D* magic in the form of `toArray!PixbufFormat()` to fill the `pixbufFormats` array.

And what’s a `PixbufFormat`? It’s a class that keeps track of details of a `Pixbuf` format… its name, mime types, license associated with the image type, the file name extensions usually used for that image… all kinds of stuff. But for now, all we’re concerned with are the format names.

Now, we’ve already looked at how to set of a font with size, color and all that, so we’ll skip *Callback Chunk #2* and go to…

### Callback Chunk #3

The code that digs the format names out of the `PixbufFormat` array and writes them to screen looks like this:

```d
foreach(pixbufFormat; pixbufFormats)
{
	context.moveTo(40, y);
	format = pixbufFormat.getName();
	context.showText(format);
	y += 30;
}
```

What we have here is:

- a standard `foreach()` loop,
- a `moveTo()` call for placement (with y being previously set and, in a moment, interated),
- a call to `PixbufFormat.getName()` to grab the text,
- `showText()` to slap it into the window, and finally
- that iteration I mentioned in point two of this list.

## Conclusion

And that’s the first step in working with images. Over the next few posts, we’ll look at how to load image, how to save them, and then after a short side trip into animating text, we’ll look at how to load a bunch of images to use in a flipbook animation.

And you don’t wanna miss that, right?

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/09/0060-cairo-iv-fill-arc-cartoon-mouth.html">Previous: Cairo Arc Fill & Precision Drawing</a>
	</div>
	<div style="float: right;">
		<a href="/2019/08/16/0062-cairo-vi-load-display-images.html">Next: Cairo Load & Display Images</a>
	</div>
</div>
