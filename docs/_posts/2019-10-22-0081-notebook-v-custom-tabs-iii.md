---
title: "0081: Notebook V – Customized Tabs Part 3"
layout: post
topic: container
description: This GTK Tutorial covers customizing how tabs look.
author: Ron Tarrant

---

# 0081: Notebook V – Customized Tabs Part 3

Okay, let’s have another look at what we’re aiming for:

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_014_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_014_16_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_16_notebook_multi_custom_tabs.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

## A Second Look at the TabDrawingArea Preamble

This time around, we’ll concentrate on just the stuff we're using to draw:

```d
cairo_text_extents_t extents;
GtkAllocation size; // the area assigned to the DrawingArea by its parent
double[] northWestArc, northEastArc;
double xRight, xLeft, textBaseline = 22, yUpper;
double width, height;
double[] tabOutlineRGBA = [0.5, 0.5, 0.5, 1.0];
double[] tabFillRGBA = [0.949, 0.949, 0.949, 1.0];
double cornerRadius = 10, radians;
double lineWidth = 2;
```

The first two variables we looked at last time, but I’m repeating them here because they factor into the drawing. They are:

- `cairo_text_extents_t extents`: which gives us the amount of space (width and height) that our string will take up in the `DrawingArea`, and
- `GtkAllocation size`: which will tell us the size of the entire `DrawingArea`.

The `extents` we need so we can make the `DrawingArea` large enough to fit the drawing. We need the `size` so we can center the text within the tab.

Now, the rest of this is for the actual drawing of the shape we’ll use as the tab’s background. Here’s a diagram I used as a guide:

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/014_container/container_014_15.png" alt="Figure 1: Diagram for a round-shouldered tab" style="width: 250px; height: 141px;">
		<figcaption>
			Figure 1: Diagram for a round-shouldered tab
		</figcaption>
	</figure>
</div>

About the diagram:

- where the red and blue lines meet is the center point for `northWestArc`,
- where the violet and gray lines meet is the center point for `northEastArc`,

Relating the preamble variables with the diagram:

- the `northWestArc` and `northEastArc` arrays will store values, in radians, that denote compass points for starting and stopped the drawing of the arc,
- `xRight` and `xLeft` are the center points of the two green circles (where the blue/red lines intersect on the left and the gray/violet lines meet on the right),
- skipping down a bit... `cornerRadius` is the measurement from the center of either of the circles to the outer edge, and
- `lineWidth` is how thick the line will be.

Now, let’s skip back up and go over the rest of these preamble variables:

- `textBaseline`: this isn’t shown on the diagram, but it’s the y offset for where we’ll be drawing the text in relation to the top of the `DrawingArea`... the top being ‘0’ (*see Figure 2 below*),
- `yUpper` is marked by the horizontal blue and violet lines on the diagram, and
- `width` and `height` will be the dimensions of our rendered text.

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/014_container/custom_tabs_baseline_various_positions.png" alt="Figure 2: How the Custom Tab's Baseline setting Affects Placement of the Text" style="width: 497px; height: 341px;">
		<figcaption>
			Figure 2: How the Custom Tab's Baseline setting Affects Placement of the Text
		</figcaption>
	</figure>
</div>

That’s it for the variables controlling the mechanics of the drawing, but we have two more arrays to look at (both are colors given as components of red, green, blue, and alpha):

- `tabOutlineRGBA`: this is the line color, and
- `tabFillRGBA`: this is an optional fill color if we want the tab to be a color other than gray.

Okay, moving right along…

## A Second Look at the Constructor

```d
this(string labelText, int tabNumber, Notebook notebook)
{
	_tabNumber = tabNumber;
	_notebook = notebook;
	_labelText = labelText ~ " " ~ _tabNumber.to!string();
		
	radians = PI / 180.0;

	// map out the shape ofa tab with rounded corners
	northWestArc = [180 * radians, 270 * radians]; // upper-left
	northEastArc = [-90 * radians, 0 * radians]; // upper-right
	cornerRadius = 10;

	addOnDraw(&onDraw);
	addOnButtonPress(&onButtonPress);
		
} // this()
```

Just ignore the first two lines (which were covered in [Part 2 of this series](/2019/10/18/0080-notebook-iv-custom-tabs-ii.html)).

We did look at the third line before, but let me refresh your memory... This converts `_tabNumber` to a string so it can be concatenated onto the end of `_labelText`. This gives us a finalized string each time a `TabDrawingArea` is instantiated with both text and a tab number.

From there we have:

- `radians`: we could have grabbed this from the standard math library, but it’s just as simple to do it this way; it comes out to a little less than two one-hundredths which is very close to the true measurement of one radian… when compared to one degree of arc around a circle (6.28 radians = 360 degrees),
- then we set up the start/end point coordinates (`northWestArc` and `northEastArc`) for drawing the rounded shoulders (keep in mind, as we talked about in the *Cairo* series, drawing in *Cairo* always goes clockwise), and
- `cornerRadius`: as stated above, this is the distance starting from where the blue and red lines intersect and going to the outer edge of the arc.

The last two lines, where the signals are hooked up, we covered last time.

### Finally, the onDraw() Callback

The first two lines:

```d
bool onDraw(Scoped!Context context, Widget w)
{
	// set the font size to something resembling the default UI font
	context.setFontSize(13);
	context.selectFontFace("Sans 10", CairoFontSlant.NORMAL, CairoFontWeight.BOLD);
```

These set up the font. I picked *Sans 10* because it either is the standard *Windows 10* UI font or looks enough like it for our purposes. And, yes, it’s got to be bold or it just doesn’t look heavy enough compared to other UI text.

In *Linux* and other *UNIX*-like OSs, the UI font will vary depending on your theme.

Next, we have:

```d
getAllocation(size);
```

This gives us the size of the `DrawingArea` which we’ll use in a moment to figure out where to place the text.

```d
context.textExtents(_labelText, &extents);
width = extents.width + 20;
height = extents.height + 10;
```

A call to `textExtents()` gives us the area that will be taken up by the rendered text, in pixels. We tack on a bit more in each direction so the text won’t look cramped.

```d
setSizeRequest(cast(int)width, cast(int)height);
xLeft = 12;
xRight = width - 11;
yUpper = 15;
context.setLineWidth(lineWidth);
```

Here, we:

- resize the `DrawingArea` so we have enough room to do the job at hand,
- `xLeft`: set the x coordinate of the point where we’ll start drawing. This is 12 pixels in from the left edge of the `DrawingArea`,
- `xRight`: set the x coordinate where we finish the drawing on the right hand side (offset 11 pixels in from the right edge,
- `yUpper`: set the y location of the center of the circle (as we talked about in the preamble section above), and
- `setLineWidth()`: self explanitory.

*Note: You might think both `xLeft` and `xRight` should have the same value, but because of a* Cairo *anomaly related to line width, they don't.*

### Final Setup Before Drawing the Tab

```d
context.newSubPath();
context.moveTo(2, 32);
context.lineTo(2, 12);
context.arc(xLeft,  yUpper, cornerRadius, northWestArc[0], northWestArc[1]); // upper left corner
context.arc(xRight, yUpper, cornerRadius, northEastArc[0], northEastArc[1]); // upper right corner
context.lineTo(width - 2, 32);
// context.closePath(); // closing the path puts a line across the bottom which doesn't look very nice
```

These statements prep the *Cairo* drawing routines, outlining the round-shouldered tab starting in the bottom left corner, moving up into the left shoulder, across to the right, then back down to the bottom.

*Note: If you want a line across the bottom of the tab, uncomment the `closePath()` statement.*

*Note 2: Keep in mind that the above statements don't actual do the drawing. It's like handing someone a map with a route marked on it. The* map *will be used in the next step.*

### Drawing the Tab

First we fill it:

```d
context.setSourceRgba(tabFillRGBA[0], tabFillRGBA[1], tabFillRGBA[2], tabFillRGBA[3]);
context.fillPreserve();
```

Then we do the outline:

```d
context.setSourceRgba(tabOutlineRGBA[0], tabOutlineRGBA[1], tabOutlineRGBA[2], tabOutlineRGBA[3]);
context.stroke();
```

And lastly, we overlay the text:

```d
context.moveTo(size.width / 2 - extents.width / 2, textBaseline); context.showText(_labelText);
```

And that is that.

## Conclusion

Next time, we’ll start by looking at adding and removing tabs from a `Notebook`.

Until then, have fun.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/18/0080-notebook-iv-custom-tabs-ii.html">Previous: Notebook IV - Custom Tabs II</a>
	</div>
	<div style="float: right;">
		<a href="/2019/10/25/0082-notebook-vi-add-remove-tabs.html">Next: Notebook VI - Add & Remove Tabs</a>
	</div>
</div>
