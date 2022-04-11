---
title: "0080: Notebook VI - Customized Tabs, Part 2"
layout: post
topic: container
tag: container
description: This GTK Tutorial is part two of customizing how tabs look.
author: Ron Tarrant

---

# 0080: Notebook VI - Customized Tabs, Part 2

Last time we got started on building customized tabs, so let's continue, starting with another look at the screen-shot showing our goal:

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_16_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_16_notebook_multi_custom_tabs.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

## The Actual Customization

Okay, now we’re getting serious. By stuffing a `DrawingArea` into the tab, we get to draw whatever we want in there. I opted for a round-shouldered tab shape with the tab’s label text inside it, but you could get all *Monty Python* and do something completely different.

We'll go over the drawing code in a later post, but for now, let's talk about all the prep that needs to be done for the drawing...

## In the Class Preamble

```d
int _tabNumber;
Notebook _notebook;
cairo_text_extents_t extents;
GtkAllocation size; // the area assigned to the DrawingArea by its parent
```

These are:

- `_tabNumber`: a number that identifies the currently-created `Notebook` page/tab,
- `_notebook`: a pointer to the parent (the `Notebook`),
- `extents`: how much space a string will take up, and
- `size`: the size of the `DrawingArea`

The `_tabNumber` variable originates in the MyNotebook class and is passed down to here. If we were adding tabs dynamically, we would have a mechanism at the MyNotebook level that would automatically increment this number so that each tab has a unique identifier. We'll see this mechanism in a later post.

## In the Constructor

```d
this(string labelText, int tabNumber, Notebook notebook)
{
	_tabNumber = tabNumber;	
	_notebook = notebook;
	_labelText = labelText;

	radians = PI / 180.0;

	// map out the shape ofa tab with rounded corners
	northWestArc = [180 * radians, 270 * radians]; // upper-left
	northEastArc = [-90 * radians, 0 * radians]; // upper-right
	cornerRadius = 10;

	addOnDraw(&onDraw);
	addOnButtonPress(&onButtonPress);
		
} // this()
```

First, we set up local copies of the values being passed in, define `radians`, then set up the arrays for drawing the two arcs (rounded shoulders), set the arc radius, and finally, hook up the signals.

### Signals and Communications

This is it, the solution to passing a mouse click from the child widget to the `Notebook` tab. Remember in [Blog Post #79](/2019/10/15/0079-notebook-iii-custom-tabs-i.html) when we talked about harnessing the `onSwitchPage` signal? Well, here’s the other half of that equation...

In the `TabDrawingArea` constructor, we hooked up the `onButtonPress` signal to trigger this callback:

```d
	bool onButtonPress(Event event, Widget widget)
	{
		_notebook.setCurrentPage(_tabNumber);
		int pageNumber = _notebook.getCurrentPage();
		writeln("_pageNumber: ", pageNumber);
		
		return(true);
		
	} // onButtonPress()
```

Each time the user clicks on our customized tab, this callback triggers and, in turn, reaches back into the `Notebook` and calls `setCurrentPage()`. And what happens whenever the page is switched? The `onSwitchPage` signal is fired and that triggers the `Notebook`’s `onSwitchPage()` callback.

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/014_container/active_tab_area.png" alt="Figure 1: Active tab areas" style="width: 294px; height: 231px;">
		<figcaption>
			Figure 1: Active tab areas
		</figcaption>
	</figure>
</div>

So, in effect, what we’ve done is harness one signal in one widget to fire another signal in another widget.

Have another look at the drawing from [Blog Post #79](/2019/10/15/0079-notebook-iii-custom-tabs-i.html). Remember, we talked about coming up with a workaround so the user can click anywhere on the tab and get the same results?

The `onButtonPress` callback is the final part of that solution to this dilemma.

<BR>

## Conclusion

In the third and final installment for this mini-series, we'll look at the drawing code. See you then. Take care.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/15/0079-notebook-iii-custom-tabs-i.html">Previous: Notebook III - Custom Tabs I</a>
	</div>
	<div style="float: right;">
		<a href="/2019/10/22/0081-notebook-v-custom-tabs-iii.html">Next: Notebook V - Custom Tabs III</a>
	</div>
</div>
