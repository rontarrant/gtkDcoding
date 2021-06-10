---
title: "0095: Hardware II – Full Monitor Report"
layout: post
topic: hardware
description: This GTK Tutorial covers collecting monitor data for a running application.
author: Ron Tarrant

---

# 0095: Hardware II – Full Monitor Report

This time, we’re looking for more than just a monitor head count. We can get the resolution of each monitor in a multi-monitor `Seat`, each monitor’s position within the `Screen` (or `Seat`, if you prefer), the model and, since we’ll have all the information we’ll need at our fingertips, let’s also find out which monitor our `Window` is on at any given time. This fulfills a request made by *GreatSam4Sure* on [forum.dlang.org](https://forum.dlang.org).

## Window Location & Other Stuff

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/024_hardware/hardware_024_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/024_hardware/hardware_024_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/024_hardware/hardware_024_02_full_monitor_report.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

To accomplish all this, we’re going to need a whole raft of imports, so as well as the ones we used from last time, we need to add these:

```d
import gtk.Button;

import gdk.Device;
import gdk.Seat;
import gdk.Window;
import gdk.Rectangle;
import gdk.MonitorG;
import gdk.Screen;
```

The reason we need the first import is obvious. The `Button` created will, when pressed, tell us which monitor the window is on. The rest are for gathering the information we want and we’ll go over them as we come to them.

### TestRigWindow Class Preamble

Here in the class preamble, we get set up to gather the info:

```d
Screen screen;
ReportButton reportButton;
```

How they’re used:

- `screen`: the default `Screen` used by our application,
- `reportButton`: which, as stated above, will be used to tell us which monitor the `Window` is on at any given time. (If you've got a multi-monitor `Seat`, try moving the window from one to another and then clicking the button.)

### The Constructor

Here, we also have a bit more to do:

```d
this()
{
	super(title);

	myDisplay = Display.getDefault();
	monitorReport();

	screen = Screen.getDefault();
	writeln("screen width: ", screen.width(), ", height: ", screen.height());

	reportButton = new ReportButton(myDisplay);
	add(reportButton);

	addOnDestroy(&quitApp);

	showAll();

} // this()
```

Besides calling `monitorReport()` to dump all the monitor information to the terminal, we also:

- grab a pointer to the default `Screen` (from which all the other info is gleaned), and
- instantiate the `reportButton`, passing it a pointer to the default `Display`.

We don’t *have* to pass this pointer. Because the `Display` is the default `Display`, it’s accessible from anywhere within our application. And that means we could just grab a pointer to the default `Display` from within the `reportButton` constructor instead. Either way works, but...

For the `TestRigWindow.monitorReport()` function to work, we need a pointer to the default `Display` there as well, so we might as well leave it there in the `TestRigWindow` constructor and pass it to the `ReportButton`. Then if, sometime down the road, we decide to change the way we're handling the `Display` pointer, we only have to rework it in one place.

### The monitorReport() Function

Here's the function where it all happens:

```d
void monitorReport()
{
	MonitorG monitorG;
	GdkRectangle rectangle;
	int numberOfMonitors = myDisplay.getNMonitors();

	writeln("Your set-up has ", numberOfMonitors, " monitors...\n\n");

	if(numberOfMonitors > 1)
	{
		foreach(int i; 0..numberOfMonitors)
		{
			monitorG = myDisplay.getMonitor(i);
			monitorG.getGeometry(rectangle);

			writeln("monitor #", i);
			writeln("monitor position within the screen area - x = ", rectangle.x, ", y = ", rectangle.y);
			writeln("monitor size: width = ", rectangle.width, ", height = ", rectangle.height);
			writeln("manufacturer: ", monitorG.getManufacturer());
			write("monitor model: ", monitorG.getModel());

			if(monitorG.isPrimary())
			{
				write(" and it's your primary display.");
			}

			writeln();
			writeln();
		}
	}
	else
	{
		monitorG = myDisplay.getMonitor(0);

		writeln("You have a single monitor");
		writeln("monitor position within the display - x = ", rectangle.x, ", y = ", rectangle.y);
		writeln("monitor size: width = ", rectangle.width, ", height = ", rectangle.height);
		writeln("manufacturer: ", monitorG.getManufacturer());
		write("monitor model: ", monitorG.getModel());

		writeln(" and it's your only display.");
	}

} // monitorReport()
```

This function starts off the same as it did in our previous example, by finding out how many monitors are available to the `Seat`, but from there, it goes into more detail, but before we go there, let's look at the variables in the function preamble and what they're used for:

- `int numberOfMonitors`: self-explanitory,  
- `monitorG`: a temporary pointer for each monitor as we loop through the list of monitors in `monitorReport()`, and
- `rectangle`: each monitor’s geometry (screen size and its placement in the `Screen`) as we loop through the list.

Looking at the big picture here, we first determine if we’re on a single-monitor `Seat`. If not, we dig in and:

- grab a pointer to the current monitor, assigning it to `monitorG`,
- find it’s geometry and store that info in a rectangle struct (`GdkRectangle` is defined in [generated/gtkd/gdk/c/types.d](https://github.com/gtkd-developers/GtkD/blob/master/generated/gtkd/gdk/c/types.d) starting on line #3933),
- as each monitor is examined, we look to see if it’s the primary monitor for the `Seat`, and
- push all these various bits of information to the terminal.

However, if there’s only one monitor, we don’t need to dig around so much. Instead, we just grab a pointer to the single monitor and dump all its info to the terminal.

### The ReportButton

A lot of this is similar to any `Button` we’ve worked with before. It’s got a string to name the `Button`, we make a size request (for convenience, really; it’s just so the full `Window` title shows and there's something to grab onto when moving the `Window` from monitor to monitor), add a callback, and connect that callback to a signal.

So, let’s go over what we haven’t done before...

#### Preamble

We declare:

```d
Display _myDisplay;
MonitorG _monitorG;
```

Since we've gone over these already, let's just move on to...

#### Constructor

```d
this(Display myDisplay)
{
	super(labelText);
	setSizeRequest(250, 30);

	addOnClicked(&onClicked);

	_myDisplay = myDisplay;

} // this()
```

We add a line to assign our local copy of the default `Display` pointer.

Things get interesting when we look at...

#### Callback

```d
void onClicked(Button b)
{
	MonitorG monitorG4Window;
	monitorG4Window = _myDisplay.getMonitorAtWindow(this.getWindow());

	int numberOfMonitors = _myDisplay.getNMonitors();

	foreach(int i; 0..numberOfMonitors)
	{
		_monitorG = _myDisplay.getMonitor(i);

		if(_monitorG is monitorG4Window)
		{
			writeln("The current window is on monitor #", i);
		}
	}

} // onClicked()
```

- `monitorG4Window`: reports whichever monitor the `Window` is on at the time the `Button` is pressed which is determined by a call to:
- `_myDisplay.getMonitorAtWindow()` and passing in a pointer to our application’s `Window`,
- then we go through the process once again of finding out how many monitors there are and grabbing a pointer to each so we can compare that pointer to the `monitorG4Window` to see if they match, and
- write the result to the terminal.

## Conclusion

And that leaves just one more thing to say before closing:

Happy holidays!

See you next time for more hardware stuff when we look at keyboards, including an alternate way to grab key presses.

See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/12/17/0094-hardware-i-monitors.html">Previous: Hardware I - Monitors</a>
	</div>
	<div style="float: right;">
		<a href="/2019/12/31/0096-hardware-iii-keyboard-pointer.html">Next: Hardware IIII - Keyboard & Pointer</a>
	</div>
</div>
