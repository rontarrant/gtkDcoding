---
title: "0094: Hardware I – Monitors"
layout: post
topic: hardware
description: This GTK Tutorial covers collecting window stats in preparation for saving a configuration file.
author: Ron Tarrant

---

# 0094: Hardware I – Monitors

Knowing the size and position of the application window (Blog Post #90, #91, and #92) becomes more important if your user has more than one monitor. Most will use one as a primary where they do 90% of their work while relegating the other(s) to such tasks as reference materials, etc. I’m sure you know that, but it makes a great preamble to today’s topic.

But before we dig in, let’s go over some...

## GTK/GDK Hardware Class Objects

The following objects are not really hierarchical. Some contain pointers to the others while still others just stand by themselves. For easiest access to almost all of them, start with a `Display` to grab a pointer to the default `Seat` or the default `Screen`.

### Seat

Back in the day (like, 1960s and '70s) when computer technicians were first moving away from using punch cards, the interface that caught on was the terminal consisting of a keyboard, a monitor, and (eventually) a pointing device.

That concept lives on in *GTK* as the *GTK* `Seat`. A `Seat` is considered to be any and all hardware available to a single user at a single workstation. In other words, if the user doesn't have to get up from his seat to physically touch the device, it's part of his *GTK* `Seat`. That will include a keyboard, one or more monitors, and a pointing device.

### Display

A `Display` is any and all hardware providing visuals to a single user at a single workstation. What makes it stand out from all the other hardware objects is that the `Display` is part of *GDK*, not *GTK*. The `Seat` is about tracking all user hardware whereas the `Display` is about the visuals. You can access the `Seat` from the `Display` using `getDefaultSeat()`, but the `Display`'s main purpose is to act as a container for anything the user will be looking at:

- the monitor(s),
- the cursor,
- the pointer, and
- the `Screen`.

### Screen

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/024_hardware/seat_display_screen.png" alt="Figure 1: Seat, Display, and Screen" style="width: 327px; height: 390px;">
		<figcaption>
			Figure 1: Seat, Display, and Screen
		</figcaption>
	</figure>
</div>


So, we’ve got the monitors, the `Display` and the `Screen`. So... what’s a `Screen`? This is the most abstract concept of the three. Where `Seat` represents a collection of user hardware and a `Display` is a collection of monitors, a `Screen` is the visible surface area of all the monitors collectively. So, it’s not the monitors, but the monitor screens all butted together into one single surface. 

#### And why do we care about all this?

Sometimes, you need to put a window on a specific monitor... or capture the input from a keyboard or pointing device before it gets processed through other widgets. Or, as I’ve been going on about for the last few blog posts, you might want to do your users a favor and give them predictable sizing and positioning for windows and dialogs as a way to boost productivity.

So, let’s start by...

## Monitoring the Monitors

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/024_hardware/hardware_024_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/024_hardware/hardware_024_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/024_hardware/hardware_024_01_number_of_monitors.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The basic idea here is to ask the `gdk.Display` how many monitors it has. This code can appear anywhere you wanna put it, so I picked the top-level window just to keep the demo as brief as possible. We start by adding two definitions to the `TestRigWindow` preamble:

```d
Display myDisplay;
int monitors;
```

Which means the constructor becomes:

```d
this()
{
	super(title);
		
	myDisplay = Display.getDefault();
	monitors = myDisplay.getNMonitors();
		
	addOnDestroy(&quitApp);

	showAll();

} // this()
```

We grab the default `Display`, the one that all *GTK* applications have right out of the box, and from there, we get the number of monitors. This number is then reported in the `monitorReport()` function:

```d
void monitorReport()
{
	writeln("Your set-up has ", monitors, " monitors");
		
} // monitorReport()
```

But we’re not stopping here. Next time, we’ll go after a full report on the `Screen` and the monitors that make it up. Until then, have a happy coding life.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/12/10/0093-window-stats-iii-alt.html">Previous: Window Stats - Alternate Window Stats</a>
	</div>
	<div style="float: right;">
		<a href="/2019/12/24/0095-hardware-ii-full-monitor-report.html">Next: Hardware II - Full Monitor Report</a>
	</div>
</div>
