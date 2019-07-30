---
title: 0059 – Cairo III – Circles and Arcs
layout: post
topic: cairo
description: GTK Tutorial on drawing circles and arcs with Cairo.
author: Ron Tarrant

---

# 0059 – Cairo III – Circles and Arcs

Let’s jump right in and look at…

## Drawing a Circle

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_018_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_018_09_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_09_draw_circle.d" target="_blank">here</a>.
	</div>
</div>


The essence of circle drawing is this:

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setLineWidth(3);
		context.arc(330, 160, 40, 0, 2 * 3.1415);
		context.stroke();
			
		return(true);
			
	} // onDraw()
{% endhighlight d %}

And even though you might expect a `circle()` function, we actually use `arc()`… and since an arc is just an incomplete circle, well… there you go.

### The Arguments

They are:

- x position of the circle’s center,
- y position of the circle’s center,
- the radius,
- the point along the circle where we start drawing, and
- the point along the circle where we stop drawing.

Those last two arguments are in radians. That’s why the point where we stop drawing is two times PI.

### The *Wikipedia*/*Cairo* Anomaly

When I first started exploring the `arc()` function, I wasn’t getting the results I expected. My confusion was twofold:

- I had assumed that 0 degrees (and therefore 0.0 radians) was true north like it is on a compass, and
- I also assumed that, like a compass, degrees increase in a clockwise direction around the circle.

So, I *Google*d radians and read the *Wikipedia* page. However, their conversion chart showed 0 to the east, compass-wise, and both degrees and radians increasing counterclockwise.

Eventually, I realized that *Cairo* agreed with *Wikipedia* one count, but not both.

So, here’s the straight dope on radians according to *Cairo*:

- 0 is to the east (compass east), and
- radians increase in value in a clockwise direction.

Not being much of a mathematician, I have no idea why 0 faces east and I certainly don’t know why *Wikipedia*’s conversion chart goes the wrong way (whether we’re talking *Cairo* or boxing a compass) but so you won’t have to fiddle with either of those paradigms, I redid the conversion chart so it accurately reflects *Cairo*’s `arc()` function requirements:

## Drawing an Arc

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_018_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_018_10_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_10_draw_arc.d" target="_blank">here</a>.
	</div>
</div>

You’re may be ahead of me on this one, but drawing an arc is the same as drawing a circle except that the start and end points are closer together :

{% highlight d %}
	bool onDraw(Scoped!Context context, Widget w)
	{
		float x = 320, y = 180;
		float radius = 40, startAngle = 0.7, endAngle = 2.44;
	
	 	// draw the arc
		context.setLineWidth(3);
		context.arc(x, y, radius, startAngle, endAngle);
		context.stroke();
	
		return(true);
			
	} // onDraw()
{% endhighlight d %}

If you consult the conversion chart, you’ll see that the arc starts at about 40 degrees (south-southeast in *Cairo*’s version of the universe) and goes to 140 degrees. And remember, drawing is done in a clockwise direction, so even though it’s right to left, it’s still clockwise.

## Conclusion

Next time, we’ll continue on and cover fills, then have a bit of fun with arcs.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/02/0058-cairo-ii-rectangles.html">Previous: Cairo Rectangles</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/08/09/0060-cairo-iv-fill-arc-cartoon-mouth.html">Next: Cairo Arc Fill & Precision Drawing</a>
	</div>
-->
</div>
