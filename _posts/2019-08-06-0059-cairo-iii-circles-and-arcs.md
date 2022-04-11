---
title: "0059: Cairo III – Circles and Arcs"
layout: post
topic: cairo
tag: cairo
description: GTK Tutorial on drawing circles and arcs with Cairo.
author: Ron Tarrant

---

# 0059: Cairo III – Circles and Arcs

Let’s jump right in and look at...

## Drawing a Circle

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_09_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_09_draw_circle.d" target="_blank">here</a>.
	</div>
</div>


The essence of circle drawing is this:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	context.setLineWidth(3);
	context.arc(330, 160, 40, 0, 2 * 3.1415);
	context.stroke();
		
	return(true);
		
} // onDraw()
```

And even though you might expect a `circle()` function, we actually use `arc()`... and since an arc is just an incomplete circle, well... there you go.

The arguments to the `arc()` function are:

- x position of the circle’s center,
- y position of the circle’s center,
- the circle radius (as if the circle were complete),
- the point along the arc where we start drawing, and
- the point along the arc where we stop drawing.

Those last two arguments are in radians. That’s why the point where we stop drawing is two times PI.

### The *Wikipedia*/*Cairo* Anomaly

When I first started exploring the `arc()` function, I wasn’t getting the results I expected. My confusion was twofold:

- I had assumed that 0 degrees (and therefore 0.0 radians) was true north like it is on a compass, and
- I also assumed that, like a compass, degrees increase in a clockwise direction around the circle.

So, I *Google*d radians and read the *Wikipedia* page. However, their conversion chart showed 0 to the east, compass-wise, and both degrees and radians increasing counterclockwise.

Eventually, I realized that *Cairo* agreed with *Wikipedia* on one count, but not the other.

So, here’s the straight dope on radians according to *Cairo*:

- 0 is to the east (compass east), and
- radians increase in value in a clockwise direction.

Not being much of a mathematician, I have no idea why 0 faces east and I certainly don’t know why *Wikipedia*’s conversion chart has radians increasing in a counter-clockwise direction. But *Cairo* agrees with real-world clocks and compasses, so at least we have those as jumping off points for understanding what's going on with *Cairo* arcs.

So I took the liberty of reproducing the conversion chart so it accurately reflects *Cairo*’s worldview:

<div class="inpage-frame">
	<figure class="center">
		<img src="/images/diagrams/018_cairo/degrees_radians_clockwise.png" alt="Figure 1: Degrees and Radians, Clockwise" style="width: 600px; height: 600px;" class="center">
		<figcaption>
			Figure 1: Degrees/radians conversion in the Cairo worldview. 
		</figcaption>
	</figure>
</div>

## Drawing an Arc

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_10_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_10_draw_arc.d" target="_blank">here</a>.
	</div>
</div>

You may be ahead of me on this one, but drawing an arc is the same as drawing a circle except that the start and end points stop short of describing the entire circle:

```d
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
```

If you consult the conversion chart, you’ll see that the arc starts at about 40 degrees (south-southeast in *Cairo*’s version of the universe) and goes to 140 degrees. And remember, drawing is done in a clockwise direction, so even though the start point is to the right of the end point (effectively, right to left) it’s still a clockwise `stroke()`.

## Conclusion

Next time, we’ll continue on and cover fills, then double back and have a bit of fun with arcs.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/02/0058-cairo-ii-rectangles.html">Previous: Cairo Rectangles</a>
	</div>
	<div style="float: right;">
		<a href="/2019/08/09/0060-cairo-iv-fill-arc-cartoon-mouth.html">Next: Cairo Arc Fill & Precision Drawing</a>
	</div>
</div>
