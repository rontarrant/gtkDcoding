---
title: "0062: Cairo VI – Load and Display Images"
layout: post
topic: cairo
description: GTK Tutorial on loading and displaying images with Cairo.
author: Ron Tarrant

---

# 0062: Cairo VI – Load and Display Images

Loading images in *GTK* isn’t difficult, but it takes on two different forms depending on which type of file you want to load.

On the other hand, once the image is loaded, displaying it is a piece of cake.

Today we look at three examples covering both ways of loading files:

- loading and displaying a PNG with `createFromPng()`,
- loading and displaying a JPeg with `setSourcePixbuf()`, and
- loading and displaying a TIFF, also using `setSourcePixbuf()`.

## PNG – Load and Display

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_018_17.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_018_17_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_17_display_png.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screenshots on a single page -->

We’re still dealing with code that’s very much the same as all other *Cairo* operations we’ve done so far and again, but this time around, we have changes in the constructor as well as the callback.

First, the constructor:

{% highlight d %}
	this()
	{
		surface = ImageSurface.createFromPng(filename);
		addOnDraw(&onDraw);
		
	} // this()
{% endhighlight d %}

Here, we need to create a `Surface` and pass it a file name, both of which are declared in the initialization section of the `MyDrawingArea` class:

{% highlight d %}
	Surface surface;
	string filename = "./images/foundlings.png";
{% endhighlight d %}

And when we get to the callback, here’s what happens:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceSurface(surface, 0, 0);
		context.paint();
		
		return(true);
		
	} // onDraw()
{% endhighlight d %}

The `Context` needs to associate itself with the `Surface` we created and because we want the entire Surface, we pass it `x` and `y` both with values of `0`.

And that’s all there is to it.

The next method of loading an image can also be used with PNG format, but it will also work with every image format supported by *GTK*.

## JPeg – Load and Display

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_018_18.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_018_18_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_18_display_jpeg.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->


This time, our initialization section gets a bit longer:

{% highlight d %}
	Pixbuf pixbuf;
	int xOffset = 20, yOffset = 20;
	string filename = "./images/guitar_bridge.jpg;
{% endhighlight d %}

Instead of a `Surface`, we’ll be working with a `Pixbuf`. I also brought the values of `xOffset` and `yOffset` into this section because there are times when we don’t want the image to be loaded in the top-left corner. `xOffset` and `yOffset` take care of that, placing the image’s upper-left corner in a specific spot in the window.

In the call to `setSizeRequest()` in the `TestRigWindow` constructor, I made the window 40 pixels wider and 50 pixels taller than the photograph so that the offset leaves a border around the image. Note, too, that the bottom border is wider than the rest, adhering to the aesthetic we talked about in [the Grid examples](https://github.com/rontarrant/gtkDcoding/blob/master/009_grid/grid_009_04_aesthetic_layout.d).

The constructor looks like this:

{% highlight d %}
	this()
	{
		pixbuf = new Pixbuf(filename);
		addOnDraw(&onDraw);
		
	} // this()
{% endhighlight d %}

This is actually simpler than the first method we looked at. There’s no `Surface` in the middle of things. It's there; we just don't have to deal with it. We just load that image right into the `Pixbuf` and that makes it possible, in the callback, to do this:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourcePixbuf(pixbuf, xOffset, yOffset);
		context.paint();
		
		return(true);
		
	} // onDraw()
{% endhighlight d %}

Substitute a call to `setSourcePixbuf()` for the call to `setSourceSurface()` we used before and from there’s it’s all the same.

## SVG – Load and Display

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_cairo/cairo_018.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/018_cairo/cairo_018_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_display_svg.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->


As you may guess, this is identical to the second method we used…

The initialization section:

{% highlight d %}
	Pixbuf pixbuf;
	Context context;
	int x, y;
	string filename = "./images/Envy.svg";
{% endhighlight d %}

The constructor:

{% highlight d %}
	this()
	{
		pixbuf = new Pixbuf(filename);
		addOnDraw(&onDraw);
		
	} // this()
{% endhighlight d %}

And the callback:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourcePixbuf(pixbuf, 0, 0);
		context.paint();
		
		return(true);
		
	} // onDraw()
{% endhighlight d %}

And, of course, this method also works for BMP, GIF, TIFF, and any of the other formats we found in the [list formats example](https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_16_list_formats.d).

## Conclusion

So, now we know how to load and display images. Next time around, we’ll tackle drawing images and then saving them.

Until then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/13/0061-cairo-v-toy-text-image-formats.html">Previous: Cairo Toy Text & Image Formats</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/08/20/0063-cairo-vii-draw-save-images.html">Next: Cairo Draw & Save Images</a>
	</div>
-->
</div>
