---
title: "0093: An Alternate Way to Gather Window Stats"
layout: post
topic: window
tag: window
description: This GTK Tutorial covers collecting window stats in preparation for saving a configuration file.
author: Ron Tarrant

---

# 0093: An Alternate Way to Gather Window Stats

In the two previous blog posts, we looked at how to gather size, position and maximize state info and—if you didn’t think I was serious before—we’re looking at it one more time.

## One Signal Tells All... Sort of

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/001_window/window_13.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/001_window/window_13_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_13_alt_window_stats.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The `configure-event` struct gives us access to almost all the info we need. It tells us the `Window`’s dimensions and its position in some rather obvious fields:

- `x` and `y` store the position, and
- `width` and `height` store the dimensions.

We still have to go elsewhere for the maximized state, but that’s no big hardship.

Anyway, let’s dig in...

## The Constructor

```d
this()
{
	super(title);
	addOnDestroy(&quitApp);
	addOnConfigure(&onConfigureEvent);
		
	appBox = new AppBox(this);
	add(appBox);
		
	showAll();
		
} // this()
```

This has reverted back to the same state we saw in our first demo in [Blog Post #90](/2019/11/22/0090-window-stats-i-position.html), proving that we really only need to work with the one signal (`configure-event`) to get what we need for a configuration file.

## The onDestroy() Callback

I’ll throw this in so you can see exactly where we’re reporting (or, in the real world, storing) the info we gather:

```d
void quitApp(Widget widget)
{
	string exitMessage = "Save the window stats for next time the user runs this application.";
	writeln(exitMessage);
	writeln("xPosition: ", xPosition, ", yPosition: ", yPosition, ", width: ", width, ", height: ", height);
	checkMaxState();
		
	Main.quit();
		
} // quitApp()
```

All the stats are pulled from local variables (remember: we have to store them before the `Window.onDestroy` signal fires) and reported here as the program exits.

But now let’s get into the alternate stuff...

## Where are Those Window Stats Again?

Well, they’re where they always were. In fact, the maximize state can only be found in the `Window` property list, but the rest of the stats can also be found in the `configure-event` struct.

And the `ConfigureEvent` property names leave no mysteries to solve:

- `x` and `y`: the window position, and
- `width` and `height`: the window dimensions.

But breaking that info out can be a bit tricky, so let’s look at that in...

## The onConfigureEvent Callback

Here’s what we’re looking at:

```d
bool onConfigureEvent(GdkEventConfigure* event, Widget widget)
{
	if(event.type is EventType.CONFIGURE)
	{
		xPosition = event.x;
		yPosition = event.y;
		width = event.width;
		height = event.height;
	}
		
	if(isMaximized())
	{
		_isMaximized = true;
	}
	else
	{
		_isMaximized = false;
	}

	writeln("Window position - x: ", xPosition, ", y: ", yPosition, ", Window area - width: ", width, ", height: ", height);

	return(false); // must be false or the window doesn't redraw properly.
		
} // onConfigure()
```

I’ll draw your attention to the function definition... this line:

```d
bool onConfigureEvent(GdkEventConfigure* event, Widget widget)
```

We’re getting specific about the `Event` type so we can pull out information specific to the type of `Event`, in this case, a `GdkEventConfigure`... which, for some reason, didn’t get aliased to `EventConfigure` in the GtkD wrapper. Any-who...

We do have the option, with an overload to this function, to react to an ordinary `Event`, but that won’t give us all the `Window` stats.

Now let’s look a little further down:

```d
if(event.type is EventType.CONFIGURE)
{
	xPosition = event.x;
	yPosition = event.y;
	width = event.width;
	height = event.height;
}
```

We grab all the values from the event and stuff them into our class properties. The `if()` statement is there just to make sure we didn’t go astray in our code somewhere in the preamble of this function.

## Conclusion

Now you know everything you need to know (perhaps more than you want to know) about gathering `Window` stats. Next time, we start a new series on hardware detection with *GTK*.

Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/12/03/0092-window-stats-ii-size.html">Previous: Window Stats - How Big is My Window?</a>
	</div>
	<div style="float: right;">
		<a href="/2019/12/17/0094-hardware-i-monitors.html">Next: Hardware I - Monitors</a>
	</div>
</div>
