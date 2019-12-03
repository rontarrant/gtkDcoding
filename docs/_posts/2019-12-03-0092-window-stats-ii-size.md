---
title: "0092: How Big is My Window"
layout: post
topic: window
description: This GTK Tutorial covers collecting size information about an open window.
author: Ron Tarrant

---

# 0092: How Big is My Window

Last time, we were talking about placing a `Window` and—if you remember—I also said I wanted my application to remember the `Window`'s size as well, so let's dig into that, shall we?

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/001_window/window_001_12.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/001_window/window_001_12_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_12_all_window_stats.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Another wrinkle we can toss in here is remembering whether the window is maximized or not when last it was used. This is something else that can be saved to a configuration file for user convenience.

## An Addition to the Constructor

This time, we’ll hook up another signal as you can see here:

```d
this()
{
	super(title);
	addOnDestroy(&quitApp);
	addOnCheckResize(&onCheckResize); // NEW
	addOnConfigure(&onConfigure);

	appBox = new AppBox(this);
	add(appBox);
		
	showAll();
		
} // this()
```

Whereas the `onConfigure` signal tells us when the window’s been moved, `onCheckResize` tells us when the user resizes it. And this naturally needs a callback:

## The onCheckResize Callback

And the callback takes a (perhaps) unexpected argument:

```d
void onCheckResize(Container container)
{
	getSize(width, height);
		
	if(isMaximized)
	{
		_isMaximized = true;
	}
	else
	{
		_isMaximized = false;
	}

	writeln("width: ", width, ", height: ", height);
	checkMaxState();
		
} // onCheckResize()
```

And what’s the purpose of the Container argument? 

That’s the `Widget` with which the check-resize signal is associated. In fact, when you look at the hierarchy of *GTK* `Widget`s, the `Window` class inherits from the `Container` so we have all those `Container` goodies in our `Window`s, too.

Now, the main purpose of this callback is to keep us informed. In actual fact, other than setting our `_isMaximized` flag, we don’t even need it... except for special circumstances, like, perhaps:

- if we want to force a redraw after the window is resized, or
- if we need to restructure the UI as the size of the `Window` changes.

However, both of those are dealt with automatically by *GTK* most of the time. Still, it's good to know the mechanism is there if we need it.

We don’t even need it for gathering the new size stats because we can get that from `Window.getSize()` which we could access whether the `onCheckResize` signal fires or not.

What the `onCheckResize` signal does do is give us a specific moment in the life cycle of our application when it feels natural to check the `Window` state for whatever purpose suits us.

## Other TestRigWindow Functions

We still have a couple of functions to look at, but neither needs much explanation:

- `showWindowStats()` has an extra statement to report the `Window`’s `width` and `height`, and
- `checkMaxState()` reports on the maximize state.

Both are stand-in functions as already explained and each would be replaced by functions for storing the `Window` stats in a configuration file.

## So, Why Pre-save Window Stats

It may cross your mind that, until the application is closing, we don’t need to gather all these `Window` stats, but here’s the rub:

If we wait until the `getDestroy` event, it’s too late. The Window is destroyed before the `getDestroy()` callback is triggered, leaving us with no stats to gather.

And that’s why, in these circumstances, the `configure-event` and `check-resize` flags are so handy.

## Conclusion

Next time, we’ll look at an alternate way to gather this data. Until then, may the great code be yours.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/11/26/0091-window-stats-i-position.html">Previous: Window Stats I - Where's My Window?</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/12/10/0093-window-stats-iii-alt.html">Next: Window Stats III - Alternative Stats Gathering</a>
	</div>
-->
</div>
