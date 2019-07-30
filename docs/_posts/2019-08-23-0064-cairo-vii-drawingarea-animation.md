---
title: 0064 – Cairo VIII – Animation on a DrawingArea
layout: post
topic: cairo
description: GTK Tutorial on animating with Cairo.
author: Ron Tarrant

---

# 0064 – Cairo VIII – Animation on a DrawingArea

When animating on a `DrawingArea`, the drawing is done more or less the same way, but a bit at a time over a number of frames. Also, a signal is hooked up to a callback in the normal way, and then in the callback, a `Timeout` object is created. It’s the `Timeout` object, as you may guess, that’s used to determine how often the Surface gets refreshed and that’s what sets the frame rate.

## A Simple Animated Timer

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_018_24.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_018_24_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_24_counter_animation.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screenshots on a single page -->

In this first example, we’ll slap down the numbers 1 through 24 in sequence and refresh the `DrawingArea`’s `Surface` every 24th of a second.

Here’s the initialization section of the `MyDrawingArea` object:

{% highlight d %}
	Timeout _timeout;
	int number = 1;
	int fps = 1000 / 24; // 24 frames per second
{% endhighlight d %}

The `Timeout` class is part of `glib`, so it’s imported with:

{% highlight d %}
	import glib.Timeout;
{% endhighlight d %}

at the top of the file.

And the `fps` variable is an easy way to set the frames per second. Timing is in milliseconds, so 1000 (one second’s worth of milliseconds) divided by the desired frame rate gives you exactly what you expect:

- 1000 / 24 = 24 fps,
- 1000 / 30 = 30 fps,
- 1000 / 6 = 6 fps, and
- so on.

Setting up the `Timeout` is the first thing you do in the callback and it’s done like this:

{% highlight d %}
	if(_timeout is null)
	{
		_timeout = new Timeout(fps, &onFrameElapsed, false);
	}
{% endhighlight d %}

The `Timeout` object acts very much like a signal hook up. In our example, once the `Timeout` is instantiated:

- `onFrameElasped()` function acts like a callback,
- `fps` tells the `Timeout` how often to call `onFrameElapsed()`, and
- `false` tells the `Timeout` not to fire right away, but to wait for the first interval to pass first.

And here’s what `Timeout`’s “callback” looks like:

{% highlight d %}
	bool onFrameElapsed()
	{
		GtkAllocation size;
		getAllocation(size);
			
		queueDrawArea(size.x, size.y, size.width, size.height);
			
		return(true);
		
	} // onFrameElapsed()
{% endhighlight d %}

We grab a `GtkAllocation` like we have before so we can get the dimensions of the `DrawingArea`, then use those dimensions to redraw. We could, if we wanted, refresh only a small portion of the `DrawingArea`, but it’s a rare case that needs such attention to detail.

As for the actual drawing itself, we do this:

{% highlight d %}
	if(number > 24) // number range: 1 - 24
	{
		number = 1;
	}

	context.showText(number.to!string());
	number++;
{% endhighlight d %}

And that’s in the `onDraw` callback… which is the real callback attached to the `DrawingArea` as opposed to the sort-of callback attached to the `Timeout`.

We don’t have to set up a `for()` loop because the `Timeout` repeats 24 times per second and ends up doing the job a loop would normally do.

## Animating the Drawing of a Circle

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_018_25.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_018_25_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_25_draw_circle_animation.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screenshots on a single page -->

This example is very similar to redrawing text. In the initialization section we have:

{% highlight d %}
	Timeout _timeout;
	float arcLength = PI / 12;
	int fps = 1000 / 12; // 12 frames per second
{% endhighlight d %}

This time, we’re running at 12 frames per second. The length of arc we’ll draw each frame is `PI / 12` and because we’re working in radians and a full circle is `2PI`, that means our circle will be redrawn once every two seconds.

The `onFrameElapsed()` `Timeout` callback is the same as before, so let’s have a gander at the `onDraw` callback:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
			
		}
		
		if(arcLength > (PI * 2))
		{
			arcLength = PI / 12;
		}

		arcLength += (PI / 12);

		context.setLineWidth(3);
		context.arc(320, 180, 40, 0, arcLength);
		context.stroke(); // and draw
		
		return(true);
		
	} // onDraw()
{% endhighlight d %}

The action starts with the `if()` statement when we measure out a length of arc to draw, then add it to the length of arc we already have. Then we set up the line width, set up the `arc()` function and do the stroke.

Pretty simple. And, of course, you could do any other drawing in there as well. And this not being the 80’s or 90’s, you’d have to pack in a very large crap-load of drawing commands before you slow down the refresh rate.

## Flipbook Animation

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_cairo/cairo_018_26.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/018_cairo/cairo_018_26_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_26_flipbook_animation.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->

And now for the *pièce de resistance*, loading a bunch of frames and flipping through them at 12 fps… which simulates shooting on twos. That’s animator parlance meaning that each image is shot twice and played back at 24 fps. Anyway, here’s the initialization section:

{% highlight d %}
	int currentFrame = 0;
	int fps = 1000 / 12; // 6 frames per second
	Timeout _timeout;
	Pixbuf[] pixbufs;
	int numberOfFrames = 75;
{% endhighlight d %}

This time around, we’re going to keep track of our current frame. And there’s also an array of `Pixbuf`s to store all the individual images that will be our frames.

The constructor plays a bigger part in things this time:

{% highlight d %}
	this()
	{
		for(int i = 0; i < numberOfFrames; i++)
		{
			if(i < 10)
			{
				pixbufs ~= new Pixbuf("./images/sequence/one00" ~ i.to!string() ~ ".tif");
			}
			else
			{
				pixbufs ~= new Pixbuf("./images/sequence/one0" ~ i.to!string() ~ ".tif");
			}
	
		} // for()
			
		addOnDraw(&onDraw);
			
	} // this()
{% endhighlight d %}

The `for()` loop loads all the frames and inside that, we build the file names through string concatenation (which is less trouble than copying an pasting a whole crap-load of file names into an array).

Once the files are all loaded snug into their `Pixbuf`s, we hook up the signal and move on.

Again, the `Timeout`’s callback is the same, so here’s the `onDraw` callback:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
				
		}
			
		context.setSourcePixbuf(pixbufs[currentFrame], 0, 0);
		context.paint();
			
		currentFrame += 1;
			
		if(currentFrame >= numberOfFrames)
		{
			currentFrame = 0;
		}
			
		return(true);
			
	} // onDraw()
{% endhighlight d %}

So here we:

- instantiate and hook up the `Timeout`,
- grab a frame from our array and stuff it into the Context, and
- do some frame number math.

Nothing to it.

## Conclusion

Next time we’ll… dive back into the MVC series and look at the `TreeStore` to see how it differs from the `ListStore`. Don't miss it, eh.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/20/0063-cairo-vii-draw-save-images.html">Previous: Cairo Draw & Save Images</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/08/27/0065-mvc-x-treestore-basics.html">Next: MVC - TreeStore Basics</a>
	</div>
-->
</div>
