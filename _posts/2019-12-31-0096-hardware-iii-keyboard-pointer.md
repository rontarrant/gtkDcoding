---
title: "0096: Hardware III – Keyboard and Pointer"
layout: post
topic: hardware
tag: hardware
description: This GTK Tutorial covers collecting keyboard and pointer data for a running application.
author: Ron Tarrant

---

# 0096: Hardware III – Keyboard and Pointer

For times when we need to grab key press or mouse pointer events for special circumstances, we can do that through the `Display` > `Seat` hierarchy as well. We’ll start with...

## The Keyboard

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/024_hardware/hardware_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/024_hardware/hardware_03_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/024_hardware/hardware_03_keyboard.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The usual suspects show up in the preamble, but if we’re going to react to keystrokes, we need to add a `Keymap`:

```d
Seat seat;
Display myDisplay;
Device _keyboard;
Keymap keymap;
```

We won’t be fooling around with changing the `Keymap` at this point, but we do need access to the default `Keymap` so we can put names to faces, so to speak. To set that up, we look to the constructor:

```d
this(string title)
{
	super(title);

	myDisplay = Display.getDefault();
	seat = myDisplay.getDefaultSeat();
	_keyboard = seat.getKeyboard();
	keymap = Keymap.getDefault();

	addOnDestroy(&quitApp);
	addOnKeyPress(&onKeyPress);
		
} // this()
```

The first four lines after the call to the `super()` constructor do the drill-down to the default `Keymap`. Then come the signal hook-ups, the second being the one of interest this time around because it hooks up...

### The onKeyPress() Callback

```d
bool onKeyPress(GdkEventKey* eventKey, Widget widget)
{
	string pressedKey;
	int keys;
		
	pressedKey = keymap.keyvalName(eventKey.keyval);
	writeln("The keyval is: ", eventKey.keyval, " which means the ", pressedKey, " was pressed.");

	return(true);
		
} // onKeyPress()
```

The `Keymap.keyvalName()` function returns the name of a pressed key as a string which means we don’t have to dig any further before feeding the result into a switch statement or a series of `if`/`else`’s.

Just keep in mind that any callback function you hook up to the `onKeyPress` signal needs a Boolean return value.

Now let’s move on to...

## The Mouse Pointer

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/024_hardware/hardware_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/024_hardware/hardware_04_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/024_hardware/hardware_04_mouse.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

Again, we have the drill-down from `Display` to `Seat` to pointing `Device`, but unlike the `Keyboard`, we need a couple more objects to help us make the most of getting pointer data...

### In the Preamble

We add a `Screen` as well as `x`/`y` coordinates:

```d
Seat seat;
Display myDisplay;
Device pointer;
Screen screen;
int x, y;
```

And after doing the same type of drill-down in the constructor and hooking up signals:

```d
this(string title)
{
	super(title);

	myDisplay = Display.getDefault();
	seat = myDisplay.getDefaultSeat();
	pointer = seat.getPointer();
		
	addOnDestroy(&quitApp);
	addOnEnterNotify(&onEnterNotify);
		
} // this()
```

We have...

### A Callback

Which looks like this:

```d
bool onEnterNotify(Event event, Widget widget)
{
	Window lastEventWindow, windowAtPosition;

	pointer.getPosition(screen, x, y);
	lastEventWindow = pointer.getLastEventWindow();
	windowAtPosition = pointer.getWindowAtPosition(x, y);

	writeln("position: x = ", x, ", y = ", y); // position is in display coordinates
	writeln("lastEventWindow: ", lastEventWindow);
	writeln("windowAtPosition: ", windowAtPosition);
	
	return(true);
		
} // onEnterNotify()
```

I picked the `onEnterNotify` signal because it only reports once when you move the pointer over the window. Anything else will fill the terminal with hundreds of lines of output in a demo like this, so I’ll leave it to you to explore those other signals. If you need a refresher, just about anything under [the topic `Mouse`](/topics/#mouse) should help you orient yourself.

## Conclusion

And that pretty much wraps up our look at hardware for now. In case you haven't looked at a calendar lately, this also wraps up 2019. We'll start the new year with a discourse on the `HeaderBar`, a replacement for a `Window.Titlebar`, which turns out to be a rather interesting beast.

So, happy New Year, happy coding and see you next week.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/12/24/0095-hardware-ii-full-monitor-report.html">Previous: Hardware II - Full Monitor Report</a>
	</div>
	<div style="float: right;">
		<a href="/2020/01/07/0097-headerbar.html">Next: HeaderBar</a>
	</div>
</div>
