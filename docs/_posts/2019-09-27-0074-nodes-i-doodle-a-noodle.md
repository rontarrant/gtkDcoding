---
title: "0074: Nodes-n-noodles I – Doodle a Noodle"
layout: post
topic: nodes
description: GTK Tutorial covering drawing a cubic Bezier curve on a DrawingArea.
author: Ron Tarrant

---

# 0074: Nodes-n-noodles I – Doodle a Noodle

This post is the beginning of another new series and, for want of a better name, it shall be called... well... it's right there in the title: *Nodes-n-noodles*.

But what are these nodes and noodles of which I speak?

This is a UI element that caught my imagination a few years ago when I first saw it in *Blender*’s Node Editor. Even if the term nodes-n-noodles isn’t familiar, the concept might be. It boils down to this:

- two or more UI elements (nodes) with connectors, and
- if you click on one element’s connector and drag to the other element’s connector,
- voilá, you’ve got a noodle connecting two nodes.

And in *Blender*, it looks like this:

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/023_nodes/blender_nodes_and_noodles.png" alt="Figure 1: Model/View/Controller and the User" style="width: 279px; height: 167px;">
		<figcaption>
			Figure 1: Model/View/Controller and the User
		</figcaption>
	</figure>
</div>

Blender opted for straight noodles, but we're going a different way... Bezier curves.

This UI concept opens up a lot of possibilities. In fact, the *Blender Foundation* has decided to use this nodes-n-noodles approach wherever possible in *Blender*. It’s intuitive and easy to use. And in *Cairo*, it’s almost ridiculously simple to implement because all the heavy lifting goes on behind the scenes.

## How This Miniseries Will Play Out

We’ll look at this in three phases...

First, we’ll start with simply drawing a noodle using a cubic Bezier curve, then work towards controlling the drawing of the curve with the mouse.

Second, we’ll dig into drawing a node with visible connectors. By the end of this second phase, we’ll have two nodes and be able to move them around within the `DrawingArea`’s `Context`.

Third, we’ll bring nodes and noodles together. We’ll be able to connect the nodes and work toward being able to move one node around while the noodle-curve connecting it to the other node updates to accommodate the new position of the node.

## How to Doodle a Noodle: Step 1

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/023_nodes/nodes_023_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/023_nodes/nodes_023_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/023_nodes/nodes_023_01_cubic_bezier.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

We’ve actually talked about the basics of this technique before in [Blog Post #60](/2019/08/09/0060-cairo-iv-fill-arc-cartoon-mouth.html). All we’re really doing is drawing a curve, but this time we’re taking a few more things into consideration...

### Opposing Control Points

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/023_nodes/opposing_control_points.png" alt="Figure 1: Model/View/Controller and the User" style="width: 250px; height: 174px;">
		<figcaption>
			Figure 1: Model/View/Controller and the User
		</figcaption>
	</figure>
</div>

This type of cubic Bezier curve is easy to draw. Given that a *Cairo* curve is drawn using four sets of coordinates—start point, first control point, second control point, and the end point—we just need keep these things in mind:

The coordinates of the first control point break down like this:

- the x position is the same as the end point’s x, and
- the y position is the same as the start point’s y.

The second control point’s coordinates work out to be:

-  x is the same as the start point’s x position, and
- y is the same as the end point’s y position.

<div class="inpage-frame">
	<figure class="right">
		<img src="/images/diagrams/023_nodes/opposing_surface_normals.png" alt="Figure 1: Model/View/Controller and the User" style="width: 250px; height: 174px;">
		<figcaption>
			Figure 1: Model/View/Controller and the User
		</figcaption>
	</figure>
</div>

This, of course, requires that the control points describe surface normals for the two nodes being connected. In a nutshell (if you’re unfamiliar with the concept of a *surface normal*) it's a perpendicular line radiating from a surface. In 2D graphics, it looks like this:

So, when we draw the cubic Bezier curve, we—in fact—only need the start and end coordinates and the coordinates for the control points can be extrapolated.

<BR>

### The DrawingArea Code

```d
class MyDrawingArea : DrawingArea
{
	double xStart = 25,  yStart = 128;
	double xEnd = 230, yEnd = 50;

	this()
	{
		addOnDraw(&onDraw);
		
	} // this()

	
	bool onDraw(Scoped!Context context, Widget w)
	{
		double xControlPoint1 = xEnd, yControlPoint1 = yStart;
		double xControlPoint2 = xStart, yControlPoint2 = yEnd;
		// set up and draw a cubic Bezier
		context.setLineWidth(3);
		context.setSourceRgb(0.3, 0.2, 0.1);
		context.moveTo(xStart, yStart);
		context.curveTo(xControlPoint1, yControlPoint1, xControlPoint2, yControlPoint2, xEndPoint, yEndPoint);
		context.stroke();

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
```

In the class preamble, we define the start and end points of the curve. Normally, this is where I’d also put the declarations and definitions for the control points as well, but because it's illegal to assign one variable to another in the preamble, these variable assignments are done in the constructor.

And the rest is close enough to the third example ([Drawing a Curve](https://github.com/rontarrant/gtkDcoding/blob/master/018_cairo/cairo_018_13_draw_1_curve.d)) in [Blog Post #60](/2019/08/09/0060-cairo-iv-fill-arc-cartoon-mouth.html) as to need no further explanation.

## Conclusion

And that’s step one/phase one of drawing a noodle. Next time, we’ll carry on and look at the other steps we have to take in order to draw a ‘live’ noodle with the mouse.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/09/24/0073-frame-part-ii.html">Previous: Frames, Part II</a>
	</div>
	<div style="float: right;">
		<a href="/2019/10/01/0075-nodes-ii-mouse-noodle.html">Next: Noodling with the Mouse</a>
	</div>
</div>
