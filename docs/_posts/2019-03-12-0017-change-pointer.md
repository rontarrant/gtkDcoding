---
title: "0017: Changing the Mouse Pointer"
topic: mouse
layout: post
description: Changing the shape of the mouse pointer based on which GTK widget it's over - a D language tutorial.
author: Ron Tarrant

---

# 0017: Changing the Mouse Pointer


<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/005_mouse/mouse_005_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/005_mouse/no_output_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_07_change_pointer.d" target="_blank">here</a>.
	</div>
</div>

How many programmers does it take to change a mouse pointer?

I don't have an answer, but I can tell you how many functions it takes: one. And we'll be dealing with two such masterful functions this time, `setCursor` and `resetCursor` which are available to all *Widgets*.

Their use is straightforward.

## Code Breakdown

We need quite a list of imports to do this:

```d
import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gdk.Cursor;
import gtk.Layout;
```

The most obvious new addition is `gdk.Cursor` (as before, note the ‘*d*’ in ‘*gdk*’). But in this example, the `Cursor` class is only needed for instantiation. The `CursorType` enum is found in `gtk.c.types` as mentioned in the comment below the import statements.

And there’s quite an array of cursor shapes available, too, all that you’d expect to see plus several dozen more. I picked a few for this demo: `HEART`, `GUMBY`, and `HAND1`.

### Other Differences in the Code

I made an arbitrary change to how the buttons are added. Because there are three, I stuffed them into an array of `Button`s and used a `foreach()` to pop them into the `Layout`, increasing the `y` location each time by 80 pixels:

```d
this()
{
	super(null, null);
	
	HandButton handButton = new HandButton();
	HeartButton heartButton = new HeartButton();
	GumbyButton gumbyButton = new GumbyButton();

	buttons = [handButton, heartButton, gumbyButton];
	
	foreach(button; buttons)
	{
		put(button, x, y);
		y += spacing;
	}

} // this()
```

Because they're widgets at heart, we can declare the array as an array of widgets as is done at the top of the `MyLayout` class:

```d
Widget[] buttons;
```

We could also have made this an array of buttons, but it's good to keep in mind that we can include other widgets in an array like this and get them into the GUI without writing out individual `put()` statements.

With minor differences, all three derived button classes are the same, so we’ll examine only one. And since Gumby (probably a registered trademark) is the more cartoon-like, let’s go there:

```d
class GumbyButton : Button
{
	string title = "Gumby Over";
	
	this()
	{
		super(title);
		
		addOnEnterNotify(&onEnter);
		addOnLeaveNotify(&onLeave);
		
	} // this()
	

	public bool onEnter(Event event, Widget widget)
	{
		Cursor myCursor = new Cursor(CursorType.GUMBY);
		setCursor(myCursor);

		return(true);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		resetCursor();

		return(true);
		
	} // onLeave()

} // class GumbyButton
```

### Disecting Gumby

In the constructor, all we do is call the parent class to create the button, then hook up the `Enter` and `Leave` signals.

The `onEnter()` function is no stranger. It expects a *Boolean* return value which (thinking back) we know can be used for chaining signals. We don’t in this case. From there, we create and change the cursor shape.

`onLeave()` is simpler. All it does is reset the cursor to the default shape.

And that’s it.

### Bonus Code Example: All Mouse Actions

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/005_mouse/mouse_005_08.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/005_mouse/mouse_005_08_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_08_all_actions.d" target="_blank">here</a>.
	</div>
</div>

Okay, not all, but quite a few. There are other signals you could hook up. If you want to play around, I encourage you to take a look at the `GdkEventType` enum starting on line number 947 of [the gdk types.d file]( https://github.com/gtkd-developers/GtkD/blob/master/generated/gtkd/gdk/c/types.d).

So, happy D-coding and may the Widgets be with you, as always.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/08/0016-scroll-pointer-all.html">Previous: Scrollwheel, etc.</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/15/0018-variations-on-a-text-entry.html">Next: Text Entry Variations</a>
	</div>
</div>
