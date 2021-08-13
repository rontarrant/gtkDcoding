---
title: "0014: Reacting to Mouse Events"
topic: mouse
layout: post
description: Harnessing mouse events in a GTK Window - a D language tutorial.
author: Ron Tarrant

---

# 0014: Reacting to Mouse Events

Now we start down the road toward full control of what happens when the user fiddles with mouse buttons. Sometimes we want to trigger something when a mouse button is pressed, but other times (more often, really) we want to react when the mouse button is released. This is the accepted norm in most GUI designs, so let’s not rock the boat until we have good reason to. And today, we have no excuse.

We’ve gone back to an unadorned `TestRigWindow` for this series of examples because this isn’t about `Button` buttons, it’s about mouse buttons. To avoid any possible confusion when I say ‘button,’ I don’t want any buttons in the GUI and that way I won’t get mixed up... and neither will you.

But since these examples—button press and button release—are so similar, we'll talk about them both together.

## A Mouse Button Press Event

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/005_mouse/mouse_005_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/005_mouse/mouse_005_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_01_press.d" target="_blank">here</a>.
	</div>
</div>

## And a Mouse Button Release Event

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/005_mouse/mouse_005_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/005_mouse/mouse_005_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_02_release.d" target="_blank">here</a>.
	</div>
</div>

## A New Import

Yeah, I’m not talking about this year’s Volvo or Toyota, but an import statement... this, to be exact:

```d
import gdk.Event;
```

We’ve seen the first one before, but I’ve included it here to remind everyone that it’s imported from the `gdk` side of things, not `gtk`.

Just below that import statement is a comment to let you know where we find `EventType` flags for events like:

- buttons being pressed,
- buttons being released,
- the motion of the mouse pointer,
- key presses and releases,
- changes in focus,
- changes in keymaps...

...all kinds of things. They give us a serious amount of control to pass along to the user.

## Changes to the TestRigWindow Class

First, let’s look at the constructor:

```d
this()
{
	super(title);
	addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	addOnButtonPress(&onMousePress);
	
	showAll();
	
} // this()
```

The change of note is the call to `addOnButtonPress()`. This hooks our `onMousePress()` function to the `BUTTON_PRESS` event.

And that function looks like this:

```d
public bool onMousePress(Event event, Widget widget)
{
	bool value = false;
	
	if(event.type == EventType.BUTTON_PRESS)
	{
		GdkEventButton* mouseEvent = event.button;
		pressReport(mouseEvent.button);
		value = true;
	}

	return(value);
	
} // onMousePress()
```

Notice the function definition. We’re not returning a void, but a Boolean. And the arguments have changed, too. We’re passing in an event as well as the originating `Widget`, in this case it’s the Window underlying our `TestRigWindow` derivative.

We make sure we’ve actually got a new `Event` to play with, then dig into it to find its type. The only one we want to react to is `BUTTON_PRESS`. And which button was pressed? To find out, we dig a little deeper. Each `Event` carries with it a field identifying whatever bit of hardware was manipulated to cause the event.

All that stuff about a value that’s returned from this function has to do with signal chains which we covered in [blog post #0011 Callback Chains](/2019/02/19/0011-callback-chains.html). Once the event has been handled, we tell `Main` we’re done handling signals and back away.

## But, wait, There’s more...

You’ve likely noticed the call to pressReport() and here’s that function:

```d
void pressReport(uint mouseButtonNumber)
{
	writeln("Button # ", mouseButtonNumber, action);

} // pressReport()
```

I put this in here mostly to illustrate that mouse buttons are identified by *unsigned integers*, something we may need to know sometime down the road.

And that variable *action*? It’s a string defined at the top of `TestRigWindow`. Here is a list of the variables defined there:

```d
string title = "Test Rig";
string buy = "Bye";
string action = " was pressed.";
```

Nothing out of the ordinary except for the playful misspellings.

## Conclusion

Next time, we’ll dig into some more mouse events. Until then, happy D-coding and may the `Widgets` be with you.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/02/26/0013-scrolled-layout.html">Previous: Scrolled Layout</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/05/0015-enter-leave.html">Next: Entering and Leaving</a>
	</div>
</div>
