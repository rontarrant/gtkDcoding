---
title: "0087: Nodes-n-noodles VI – Adding Hot Spots"
layout: post
topic: nodes
tag: nodes
description: This GTK Tutorial covers drawing node host spots for a node-n-noodles demo.
author: Ron Tarrant

---

# 0087: Nodes-n-noodles VI – Adding Hot Spots

Here's a look at what we're dealing with today. It may look the same as the previous couple of screen shots, but clicking on one of the node connectors (yellow or orange circles) or the light blue drag-bar area dumps a line to the terminal.

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/023_nodes/nodes_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/023_nodes/nodes_07_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/023_nodes/nodes_07_drawingarea_node_with_hotspot.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The objective now is to move toward a node that’s actually moveable... like the class name says. Here's a breakdown of how we're going about this:

- when the pointer is within certain areas on the node,  and
- the user clicks and holds mouse button #1, and
- moves the pointer again,
- a function triggers that moves the node.

The first step toward this is to define those areas as...

## Hotspots

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/023_nodes/node.png" alt="Figure 1: The Node" style="width: 111px; height: 102px;">
		<figcaption>
			Figure 1: The Node
		</figcaption>
	</figure>
</div>

This just means we’re going to define parts of the node that will react to mouse clicks. Those would be the orange and yellow circles and the light blue rectangle at the top.

Why do we need multiple areas? Because eventually, we’ll also be connecting nodes one to another and this means we’ll want hotspots that react to:
<BR>
<BR>

- an incoming connection,
- an outgoing connection, and
- mouse click-n-drag.

Everything we need to do in order to get these hotspots set up will take place in the `MoveableNode` class. Let’s look at these changes by section...

### The Preamble

Here’s where we declare the hot spots:

```d
double[string] dragArea;
double[string] inHotspot;
double[string] outHotspot;
```

These three arrays will hold x/y coordinates for the upper-left and lower-right corners of the hot areas.

### The Constructor

We leave the definition of the hotspot arrays until the constructor because we’re using associative arrays and, by nature, associative arrays aren’t constant and therefore can’t be defined in the preamble. But that’s okay, we’re just as happy to fill in the details here in the constructor:

```d
dragArea = ["left" : 13, "top" : 9, "right" : 99, "bottom" : 30];
inHotspot = ["left" : 0, "top" : 27, "right" : 10, "bottom" : 38];
outHotspot = ["left" : 100, "top" : 60, "right" : 110, "bottom" : 70];
```

And why associate arrays? Because when it comes time to put these values into play in our code, it’ll be easier to keep track of what we’re doing if we refer to them as `dragArea[“left”]` or `outHotspot[“top”]` as opposed to using a numerical index.

And we add one more line to the constructor to hook up the all-important `onButtonPress()` callback:

```d
addOnButtonPress(&onButtonPress);
```

For this stage, that’s all we need to do here so, moving on...

### The Callback

Here's the onButtonPress() function:

```d
	bool onButtonPress(Event event, Widget widget)
	{
		GdkEventButton* buttonEvent = event.button;
		int button1 = 1;
		double xMouse, yMouse;
		xMouse = buttonEvent.x;
		yMouse = buttonEvent.y;

		// restrict active areas to terminal connections and the dragbar
		if(xMouse > dragArea["left"] && xMouse < dragArea["right"] && yMouse > dragArea["top"] && yMouse < dragArea["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// dragArea
				dragAreaActive(xMouse, yMouse);
			}
		}
		else if(xMouse > inHotspot["left"] && xMouse < inHotspot["right"] && yMouse > inHotspot["top"] && yMouse < inHotspot["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// inHotspot
				terminalInActive(xMouse, yMouse);
			}
		}
		else if(xMouse > outHotspot["left"] && xMouse < outHotspot["right"] && yMouse > outHotspot["top"] && yMouse < outHotspot["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// inHotspot
				terminalOutActive(xMouse, yMouse);
			}
		}
	
		return(true);
		
	} // onButtonPress()
```

This is where we separate the clicks we want to deal with from those we don’t, but we have a bit of prep to do before we can distinguish between them. And it starts with this line:

```d
GdkEventButton* buttonEvent = event.button;
```

What's happening here is similar to a cast. The `event` variable passed into the function is generic, but we need to know the type of `Event` it represents.

If you look at the *GtkD* wrapper source ([generated/gtkd/gdk/c/types.d](https://github.com/gtkd-developers/GtkD/blob/master/generated/gtkd/gdk/c/types.d))  starting on line #2495, you'll see that this `Event` construct has some depth. It's a `struct` wrapped around a `union`. And within the `union`, there are multiple `struct`s, each defining a different type of `Event`. There's a motion `Event`, a button `Event`, and a touch `Event`—just to name a few. And each of these `Event` types has properties meaningful to the type of `Event` it is. What we need to do is dig down into the `Event`'s `union` to pull out the type of `Event` we're dealing with and from that, get the information we need... and what we need is three things:

- the `x` coordinate of the pointer when the mouse button was pressed,
- the `y` coordinate, too, and
- the number of the mouse button... so we aren't reacting to them all.

The `Event` we're after in this situation is the `GdkButtonEvent`, a struct which looks like this:

```d
struct GdkEventButton
{
	GdkEventType type;
	GdkWindow* window;
	byte sendEvent;
	uint time;
	double x;
	double y;
	double* axes;
	ModifierType state;
	uint button;
	GdkDevice* device;
	double xRoot;
	double yRoot;
}
```

Of all the values in this struct, what we want are the `x` and `y` variables which, as you might expect, reflect the position of the pointer within the`DrawingArea`.

<div class="inpage-frame">
	<figure class="right">
		<img src="/images/diagrams/023_nodes/event_hierarchy.png" alt="Figure 1: button variables at two levels in the hierarchy" style="width: 454px; height: 148px;">
		<figcaption>
			Figure 1: button variables at two levels in the hierarchy
		</figcaption>
	</figure>
</div>

*Note: We don't use `xRoot` and `yRoot` because they report the pointer position in relation to the upper-left corner of the `Screen`, the `Screen` being the area of your entire display—the monitor(s) connected to your computer. We'll get into this `Screen` stuff in a later post.*

*Another note: Keep in mind, too, that a `button` variable also appears at two different levels of the hierarchy. The first (highest, outermost) is a* `GdkEventButton` struct *and the second (lowest, innermost) is a* uint. *Confusing the two could get dicey.*

Getting back to the discussion at hand... of all the data contained within the `event`, all we need are:

- the `x` and `y` coordinates, and
- the two `button` values:
	- the `GdkEventButton` struct from which we'll glean those coordinates, as well as
	- the `uint` representing the mouse button that was pressed.

So, we grab the button from the top-level of the `Event` and dig into it to get the mouse button number. 
We could also have addressed it directly as: `event.button.button`.

The x/y coordinates are pulled from the `GdkEventButton` struct and assigned to `xMouse` and `yMouse`. As mentioned above, these keep track of where the pointer was when the physical mouse button was clicked.

Then we use an `if`/`else` construct to differentiate between the various hotspot areas, calling a different handler function for each, those handlers being `dragAreaActive()`, `terminalInActive()`, and `terminalOutActive()` as mentioned above.

We could have done this the other way around but it really doesn’t matter in the end whether the inner `if`/`else` deals with which mouse button was pressed or which hotspot was under the pointer at the time.

And finally, we have...

### The Active() Functions

There are three of them (`terminalInActive()`, `terminalOutActive()`, and `dragAreaActive()`) We’ll just look at one because they’re pretty much the same:

```d
void dragAreaActive(double xMouse, double yMouse)
{
	// see if the mouse is in the drag area 
	writeln("dragArea: xMouse = ", xMouse, " yMouse = ", yMouse);
		
} // dragAreaActive()
```

Right now, all these functions are stubs. Next time, we'll start looking at their content.

## Conclusion

So, our hotspots are set up and all we have to do now is work out how to make this sucker move.

Note that at this time, we have no idea where the mouse pointer is in relation to our `NodeLayout`—that is, the surface we'll be moving the Node around on—but that’s okay. We’ll look at that next time, too.

See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/11/08/0086-nodes-v-node-drawing-routines.html">Previous: Node V - Drawing Routines</a>
	</div>
	<div style="float: right;">
		<a href="/2019/11/15/0088-nodes-vii-its-alive.html">Next: Nodes VII - It's Alive!</a>
	</div>
</div>
