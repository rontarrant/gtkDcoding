---
title: "0016: Scroll Wheel and More Button Stuff"
topic: mouse
layout: post
description: Getting feedback from the mouse's scrollwheel in GTK - a D language tutorial.
author: Ron Tarrant

---

# 0016: Scroll-wheel and More Button Stuff

## Tracking the Scroll-wheel

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/005_mouse/mouse_005_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/005_mouse/mouse_005_05_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_05_scroll_wheel.d" target="_blank">here</a>.
	</div>
</div>


Time to get down to the nitty gritty of harnessing the mouse wheel.

Got a 3D object you need to zoom in on? How about lines and lines of text that need to be scrolled through? Yeah, that’s what we’re laying groundwork for today. Here’s the constructor:

```d
this()
{
	super(title);
	addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	// make the window sensitive to mouse wheel scrolling
	addOnScroll(&onScroll);
	
	// Show the window and its contents...
	showAll();
	
} // this()
```

This should be pretty familiar by now, hook up a signal to a callback using one of the `addOnXxxxx()` functions, in this case `addOnScroll()` and here’s the callback:

```d
public bool onScroll(Event event, Widget widget)
{
	bool value = false; // assume no scrolling
	
	if(event.scroll.direction == ScrollDirection.DOWN)
	{
		value = true;
		writeln("scrolling down...");
	}
	else if(event.scroll.direction == ScrollDirection.UP)
	{
		value = true;
		writeln("scrolling up...");
	}

	return(value);

} // onScroll()
```

Again, we have to dig a bit to find the data we want: the direction the mouse wheel is turning. The `ScrollDirection` *enum* in `gtk.c.types` (that’s *generated/gtkd/gtk/c/types.d* if you want to see for yourself) provides us with `UP` and `DOWN` so we can check. Makes it easy. I’ve added in a bit of return value roughage so we know for sure we’re done with any signal chain that might end up being processed at the same time.

## Left, Middle, & Right Mouse Buttons

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/005_mouse/mouse_005_06.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/005_mouse/mouse_005_06_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_06_left_middle_right.d" target="_blank">here</a>.
	</div>
</div>


Let’s throw caution to the wind and put a `Button` back in the window, just one, and give it something interesting to do...

When I was writing out these examples, I’d forgotten I’d already talked about differentiating between mouse buttons, so I wrote this one. This one, though, does process things in a different way:

```d
public bool onButtonRelease(Event event, Widget widget)
{
	bool value = false;
	
	if(event.type == EventType.BUTTON_RELEASE)
	{
		GdkEventButton* buttonEvent = event.button;

		mouseRelease(buttonEvent.button);

		value = true;
	}

	return(value);
	
} // onButtonRelease()
```

From here, you could look at the button data, a *uint*, to see which button was pressed. We handle this with the `mouseRelease()` function:

```d
void mouseRelease(uint mouseButton)
{
	writeln("The ", mouseButtons[mouseButton], " was released.");
	
} // mouseRelease()
```

Which translates the *uint* to plain English using the `mouseButtons` array defined at the top of the `MyLMRButton` class:

```d
string[] mouseButtons = ["None", "Left", "Middle", "Right"];
```

You may wonder why there’s a `“None”` element in this array, but it’s there because there is no mouse button #0. It keeps us from having to subtract ‘1’ each time to find our way to the correct array element.

And so we come to the end of another blog post. Be kind to each other and we’ll talk again soon.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/05/0015-enter-leave.html">Previous: Entering and Leaving</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/12/0017-change-pointer.html">Next: Mouse Pointer</a>
	</div>
</div>
