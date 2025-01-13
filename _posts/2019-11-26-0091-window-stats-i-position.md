---
title: "0091: Where’s My Window?"
layout: post
topic: window
tag: window
description: This GTK Tutorial covers collecting position information about an open window.
author: Ron Tarrant

---

# 0091: Where’s My Window?

This post, although not specifically requested by a reader, was inspired by a reader request...

Two things I appreciate in an application are when it remembers (from one session to the next):

1. the size of its window, and
2. its position.

This is especially convenient since I switched to a multi-monitor set-up. If I open an application or dialog, but then have to search the entire area of three large monitors to find it, I’m not just slowed down and put off, I’m dumped out of that zen-like coding head-space I'm so addicted to. And frankly, that’s grounds for dismissal in my book. I’ve fired several text editors for this violation of etiquette. I’ve even sworn off window managers for this.

So, since I don’t wanna come across as a hypocrite, I decided to come up with a *GTK* solution to these issues and over the next two posts, we’ll look at how to gather these statistics for future use.

## So, Where is My Window, Anyway?

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="images/screenshots/001_window/window_11.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="images/screenshots/001_window/window_11_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/001_window/window_11_get_position.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

As it happens, *GTK* has a signal we can hook up to that gives us our application’s `Window` position. It goes by the name: configure-event.

### The Constructor

Once you’ve got that little tidbit of knowledge, getting the signal/callback sorted out is no harder than any other. Let’s look at the `TestRigWindow`’s constructor:

```d
this()
{
	super(title);
	addOnDestroy(&quitApp);
	addOnConfigure(&onConfigure); // this is it
		
	appBox = new AppBox(this);
	add(appBox);
		
	showAll();

	getPosition(xPosition, yPosition);
	showWindowStats();
		
} // this()
```

Just use `addOnConfigure()`  to hook up the signal to the callback. The last two lines of the constructor don’t need to be there, but for demo purposes, they give us a report on the window's position at start-up.

### The Callback

Very much as straightforward as ever:

```d
bool onConfigure(Event event, Widget widget)
{
	getPosition(xPosition, yPosition);
	writeln("The window is positioned at: x = ", xPosition, ", y = ", yPosition);
		
	return(false);
		
} // onConfigure()
```

In the real world, we wouldn’t be spewing all those lines of text into the shell. Instead, we’d have this callback sitting quietly in the weeds keeping track of our window’s position so that when the time comes, it can be saved out to a configuration file.

That `getPosition()` function is a method of the *GTK* `Window` that either directly, or indirectly, queries the operating system’s window manager.

*Note: Something that isn’t obvious about this demo is that the `onConfigure` callback must return `false`, indicating that there are more signals to process, specifically the redraw signal. If this callback returns `true`, only the `Window` frame will be drawn. So, if you find your application in this state, there's yer problem.*

Now for a look at the `TestRigWindow`’s other function...

### The showWindowStats() Function

This one is called from both the constructor and the `quitApp()` function, the first time it’s called is to give us a first look at window position. The second gives us the final position as we’re exiting the application. In the real world, this function would be replaced with another that writes out configuration data and there’d be yet another function that reads it back in when the application is restarted. That’s something we’ll get into at some point down the road, but for now, let’s just have a look at what we’ve got:

```d
void showWindowStats()
{
	writeln("Window stats...");
	writeln("position: xPosition = ", xPosition, ", yPosition = ", yPosition);
		
} // showWindowStats()
```

This doesn’t gather any new information, just spits out what we already have stored in `TestRigWindow` properties. And that’s the best way to handle this type of thing... one function to gather the info, another to save it or, in this case, just report it.

## Conclusion

Next time, we’ll carry on in this vein by exploring how to record the `Window` size as well. Until then, happy coding and make every little bit count.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/11/22/0090-titlebar-icons.html">Previous: Windows - Titlebar Icons</a>
	</div>
	<div style="float: right;">
		<a href="/2019/12/03/0092-window-stats-ii-size.html">Next: Window Stats II - How Big is My Window?</a>
	</div>
</div>
