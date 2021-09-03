---
title: "0006: Position a Window"
topic: window
layout: post
description: How to position a GTK Window - a D language tutorial.
author: Ron Tarrant

---

# 0006: Position a Window

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/001_window/window_001_06.png" alt="Current example output">	<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal0" class="modal">																								<!-- modal# -->
				<span class="close0">&times;</span>																					<!-- close# -->
				<img class="modal-content" id="img00">																					<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal0");																			// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img0");																				// img#
			var modalImg = document.getElementById("img00");																		// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close0")[0];															// close#
			
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
			<img id="img1" src="/images/screenshots/001_window/window_001_06_term.png" alt="Current example terminal output"> <!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal1" class="modal">																												<!-- modal# -->
				<span class="close1">&times;</span>																										<!-- close# -->
				<img class="modal-content" id="img11">																									<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal1");																							// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img1");																								// img#
			var modalImg = document.getElementById("img11");																						// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close1")[0];																				// close#
			
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

	<div class="frame-footer">																																<!-- filename (below)-->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_06_positioned.d" target="_blank">here</a>.
	</div>
</div>

Sometimes you need a window to land in a specific spot on the screen. As a user, I like windows and dialogs to open in the last position I used and closed them. This is pretty much mandatory behaviour with a three-monitor set-up so I don't waste time scanning all that screen real estate to figure out where my application or dialog just opened.

For this example, I used two buttons, one to move the window up and to the left, the other to move it down to the right. And because of that, I had to use a `Box` object because (if you remember) we can’t put more than one object into a window, but we can if we use a `Box` and put the `Box` in the window.

## Something New

The other thing I introduce here is the `interface`. It's used to sketch out a plan for classes which will be similar enough to share functions and data, but not so similar that the functions will all do exactly the same things in the same way. In our case, we want one button to move the window to the left, the other to the right. That's similar enough that it makes sense to derive these two from an interface because, with both buttons, the window’s moving somewhere. It's just the destinations that are different.

The interface could also be said to lay down the rules for `Button`s that change the position of the window. By reading through the interface code, we can see that it:

- has a meaningful name (`PositionButton`),
- has one function that all derived buttons must also have (`moveWindow`), and
- takes a *GTK* `MainWindow` as an argument.

## Inheritance in D

`LeftButton` and `RightButton` are the derived `Button`s. They inherit from the interface—`PositionButton`—as well as the top-level `Button` class.

The rules regarding inheritance in *D* are:

- an interface can inherit only from another interface,
- a class can inherit from one other class, but
- a class can also inherit from as many interfaces as you need it to, and
- when listing what a class inherits from, you have to list the class first, then any interfaces.

Both `LeftButton` and `RightButton` are set up with the same string of inheritances, but implementation of functions? That’s another story.

In `LeftButton`, the `moveWindow()` function gets the current window position as `x` and `y` coordinates, then subtracts `40` and `60` (respectively) from `x` and `y`, then calls the window’s `move()` function.

`RightButton` does the same thing, but adds to `x` and `y` instead of subtracting. In fact, all I did to create `RightButton` was copy/paste, change minus signs to plus and replace `Left` with `Right`.

## Conclusion

Okay, a short one this time. Until next time, keep those cards and letters coming in and stay happy.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/01/29/0005-window-size.html">Previous: Size a Window</a>
	</div>
	<div style="float: right;">
		<a href="/2019/02/05/0007-button-release-and-reorganizing-the-code.html">Next: Button Release</a>
	</div>
</div>