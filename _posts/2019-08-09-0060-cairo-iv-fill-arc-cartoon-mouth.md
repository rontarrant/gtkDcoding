---
title: "0060: Cairo IV – Filled Arc, Precision Drawing, and Curves"
layout: post
topic: cairo
tag: cairo
description: GTK (Cairo) Tutorial on filling arcs, precision drawing, and curves.
author: Ron Tarrant

---

# 0060: Cairo IV – Filled Arc, Precision Drawing, and Curves

This is a continuation of our Cairo briefs...

## Filled Arc

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/018_cairo/cairo_11.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/018_cairo/cairo_11_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_11_filled_arc.d" target="_blank">here</a>.
	</div>
</div>


This is the callback:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	float x = 320, y = 180, radius = 40;
       float start = 0.7, finish = 2.44;
		
 	// draw the arc
	context.setLineWidth(3);
	context.arc(x, y, radius, start, finish);
	context.fill();

	return(true);
		
} // onDraw()
```

This is like the other `arc()` calls, but followed with a `fill()` command instead of `stroke()`.

But we can also do some interesting stuff by issuing a bunch of `arc()` calls interspersed with `moveTo()`’s and such like...

## A Cartoon Smile with Arcs

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/018_cairo/cairo_12.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/018_cairo/cairo_12_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_12_draw_arcs_cartoon_smile.d" target="_blank">here</a>.
	</div>
</div>


The cartoon smile is done like this:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	float xPos1 = 213, yPos1 = 160, xPos2, yPos2;
	float xPos3, yPos3, radius1 = 40, radius2 = 10;
	
	// draw the first arc (the mouth shape)
	context.setLineWidth(3);
	context.arc(xPos1, yPos1, radius1, 0.7, 2.44);
	context.stroke();
	// find the right corner of the mouth shape
	xPos2 = xPos1 + cos(0.7) * radius1;
	yPos2 = yPos1 + sin(0.7) * radius1;
	// draw the second arc
	context.arc(xPos2, yPos2, radius2, 4.2, 0.7);
	context.stroke();
	// find the left corner of the mouth shape
	xPos3 = xPos1 + cos(2.44) * radius1;
	yPos3 = yPos1 + sin(2.44) * radius1;
	// draw the third arc
	context.arc(xPos3, yPos3, radius2, 2.6, 5.6);
	context.stroke();
	
	return(true);
	
} // onDraw()
```

### The X and Y Positions

These are the centers of our three circles around which we’ll draw three arcs. The first—`xPos1`, `yPos1`—is for the mouth shape and the other two are for the “smile lines.”

### Finding the Corners of the Mouth

`xPos2`/`yPos2` and `xPos3`/`yPos3` are positioned at the two ends of the smile arc—the corners of the mouth—which takes a bit of trig, but nothing complicated.

Finding the end of an arc is pretty straightforward. Looking back at the start angle of the mouth arc and the radius, we calculate the right corner of the mouth like this:

```d
xPos2 = xPos1 + cos(0.7) * radius1;
yPos2 = yPos1 + sin(0.7) * radius1;
```

I’ll throw in a quick reminder that arcs are drawn in a clockwise direction which is why this calculation yields `xPos2`/`yPos2`, the right corner.

Same for the left corner except we use the end position of the arc:

```d
xPos3 = xPos1 + cos(2.44) * radius1;
yPos3 = yPos1 + sin(2.44) * radius1;
```

Follow each of those pairs of calculations with a call to arc() with a smaller radius and we’re done.

###Where Did Those cos() & sin() Args Come From?

They're the start and end points of the 'smile' arc and they're in radians. A quick look at our Radians Compass bears this out:

<div class="inpage-frame">
	<figure class="center">
		<img class="center" src="/images/diagrams/018_cairo/radians_compass_smile_points.png" alt="Figure 1: Left: First example, Middle/Right: second example in two steps" style="width: 600px; height: 600px;">
		<figcaption>
			Figure 2: Radians Compass with 'smile' start and end points marked. 
		</figcaption>
	</figure>
</div>

## Drawing a Curve

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_cairo/cairo_13.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/018_cairo/cairo_13_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_13_draw_1_curve.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->


<!-- 6, 7 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img6" src="/images/screenshots/018_cairo/cairo_14.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img7" src="/images/screenshots/018_cairo/cairo_14_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/018_cairo/cairo_14_draw_2_curves.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for fourth (4th) occurrence of application and terminal screenshots on a single page -->

In *Cairo* terms, the difference between an arc and curve is:

- an arc uses a center ‘anchor’ point as a base and two positions around a circle as start and end points, whereas
- a curve uses x/y locations to set up two control points and only needs coordinates for the end point of the curve.

So how does the `curveTo()` function know where to start the curve?

There are three rules governing placement of `curveTo()`’s starting x/y position:

1. It’s set beforehand with `moveTo()`,
2. if no `moveTo()` call precedes `curveTo()`, the first control point doubles as a starting point, or
3. it uses the end point of a previously-drawn line, arc, or curve.

When you look at the code for our two example files, which are a single curve, and two curves joined together, you’ll note that the curve in the first example is repeated in the second, but the resulting curves are quite different. But, looking back at the rules, it’s easy to see why...

Comparing the two curve-drawing examples...

In the first example, the starting x/y position is passed to `curveTo()` and because it's not preceded by a `moveTo()` call, it's also where the drawing actually starts.

In the second example, however, the first call to `curveTo()` *is* preceded by a `moveTo()` which means the `moveTo()` decides where drawing starts. Here's how the two examples play out:

<div class="inpage-frame">
	<figure class="center">
		<img class="center" src="/images/diagrams/018_cairo/cairo_13_14_compared.png" alt="Figure 1: Left: First example, Middle/Right: second example in two steps" style="width: 640px; height: 359px;">
		<figcaption>
			Figure 1: Left: First example, Middle/Right: second example in two steps
		</figcaption>
	</figure>
</div>

## Conclusion

Keep these things in mind while drawing curves and you’ll do just fine:

- remember to use a `moveTo()` *before* a `curveTo()`, or else
- the first x/y coordinate will be the starting point, and
- curves use control points to control the severity of the curve.

And that’s about it for curves. Next time, we’ll dig into what’s referred to as `Cairo`’s *Toy Text* mechanism. Until then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/06/0059-cairo-iii-circles-and-arcs.html">Previous: Cairo Circles and Arcs</a>
	</div>
	<div style="float: right;">
		<a href="/2019/08/13/0061-cairo-v-toy-text-image-formats.html">Next: Cairo Toy Text & Image Formats</a>
	</div>
</div>
