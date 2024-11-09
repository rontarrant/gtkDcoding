---
title: "0045: Split a Window into Panes"
topic: container
tag: container
layout: post
description: How to use the GTK Paned class to split a window into panes.
author: Ron Tarrant

---

# 0045: Split a Window into Panes

There will be times when you’ll need a window separated into two areas with a handle to adjust the division between them. For instance, a file manager has a directory/folder tree on the left and the contents of a selected directory on the right and as I’m sure you’re aware, if you dig deep enough into a directory hierarchy, you have to widen the left-hand area so you can see the full path which is why it's handy to have that adjustment handle between the two panes.

Today’s code lays the foundation for this type of functionality.

## A Pane in the Window... Two, Really

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/014_container/container_01_paned.d" target="_blank">here</a>.
	</div>
</div>

A `Paned` container can have its child panes side by side or one below the other. And since we may want programmable access to manipulate the child widgets we put in these panes, I’ve created a class derived from `Paned` and called it `SideBySide`:

```d
class SideBySide : Paned
{
	Image child01, child02;
	
	this()
	{
		super(Orientation.HORIZONTAL);
		
		auto child01 = new Image("images/e_blues_open.jpg"); 
		add1(child01);
		
		auto child02 = new Image("images/guitar_bridge.jpg");
		add2(child02);
		
		addOnButtonRelease(&showDividerPosition);
		
	} // this()
	
	
	public bool showDividerPosition(Event event, Widget widget)
	{
		writeln("The divider is set to: ", getPosition());
		
		return(true);
		
	} // showDividerPosition()
	
} // class SideBySide
```

This is just about as simple as it gets with `Paned` containers. We’ve got two child `Image` widgets, each tucked into its own pane.

And just to show off one of `Paned`’s functions, I’ve connected up a generic `Widget Event` signal to spit out the position of the pane divider handle. Hover the mouse over the handle, click-n-drag, and when you release the mouse button, `showDividerPosition()` spits out the new position of the handle.

### Paned Behaviour

Because there are only two panes in a `Paned` container, the functions for assigning child `Widget`s are numbered:

- `add1(child1)`, and
- `add2(child2)`.

Or if you want to populate both in one go, you can do it with a single function:

```d
add(child1, child2);
```

You could also use `pack1()` and `pack2()` if you prefer, but the behaviour will be different, so let’s look at that.

## Paned Packing (a Vertical Version)

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/014_container/container_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/014_container/container_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/014_container/container_02_paned_pack.d" target="_blank">here</a>.
	</div>
</div>

Our second example has a new derived class for a *vertical* `Paned` container:

```d
class UppyDowny : Paned
{
	Image child01, child02;
	
	this()
	{
		super(Orientation.VERTICAL);
		
		auto child01 = new Image("images/e_blues_open.jpg"); 
		pack1(child01, true, false);
		
		auto child02 = new Image("images/guitar_bridge_alt.jpg");
		pack2(child02, false, true);
		
		addOnButtonRelease(&showDividerPosition);
		
	} // this()
	
	
	public bool showDividerPosition(Event event, Widget widget)
	{
		writeln("The divider is set to: ", getPosition());
		
		return(true);
		
	} // showDividerPosition()
	
} // class UppyDowny
```

Here are the differences between this example and the first:

- the panes are stacked vertically instead of horizontally,
- `pack1()` has three arguments instead of one:
	- the child `Widget`,
	- a `bool` to determine whether or not the child will expand when the divider handle is moved away from it, and
	- another `bool` to control whether or not the child `Widget` will shrink when the handle is moved toward it.
- when you move the divider handle in the first example, each image slides out of the way as the handle is moved toward it, but...
- in the second example, only the guitar bridge image moves.

Note also that even though the panes expand or contract as you move the handle, the `Image`s aren’t resizing. So, it’s just the panes that change size, not their contents.

### How addX() Imitates packX()

The default behaviour for `add1()` or `add2()` allows both panes to resize just as can be done with `pack1()` and `pack2()`. That’s because when using the `addX()` functions, they assume behaviours that would be the same as if you’d used `packX()` while passing the following arguments:

- `pack1(child1, false, true)` = `add(child1)`, and
- `pack2(child2, true, true)` = `add(child2)`.

The corollary is, if you want to mimic the behaviour of `add1()` and `add2()`, using the above arguments to `pack1()` and `pack2()` would do the trick.

And that’s pretty much it for now. See you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/06/14/0044-custom-dialog-iii.html">Previous: A Fancy Dialog</a>
	</div>
	<div style="float: right;">
		<a href="/2019/06/21/0046-the-spinbutton.html">Next: SpinButton</a>
	</div>
</div>

