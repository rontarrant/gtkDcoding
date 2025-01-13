---
title: "0088: Nodes-n-noodles VII – It’s Alive!"
layout: post
topic: nodes
tag: nodes
description: This GTK Tutorial covers animating a node with the mouse for a node-n-noodles demo.
author: Ron Tarrant

---

# 0088: Nodes-n-noodles VII – It’s Alive!

Are you ready to move a node?

Yeah, me, too.

## The Moveable Node

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/023_nodes/nodes_08.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/023_nodes/nodes_08_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/023_nodes/nodes_08_drawingarea_node_moveable.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Again, we have to add some new statements in the `MoveableNode` class’s preamble and constructor, but our list of changes doesn’t stop there. We also need to add a couple of other functions and doctor every callback we’ve got so far. On top of that, we have to go up a level, class-wise, and make changes to the `NodeLayout` as well.

So to start with, let’s look at that...

### Setting Up the NodeLayout for Moving Nodes

In each nodes-n-noodles demo until now, the initial position of the node was hard-coded in the `NodeLayout`’s constructor like this:

```d
put(moveableNode, 20, 140);
```

But if we’re working toward—eventually—adding nodes as we go, we’ll want to move the `MoveableNode`'s position into the `MoveableNode` class where it belongs. But-but... at this experimental stage, that would be awkward because we'd have to instantiate the `MoveableNode`, then use a getter to grab its location info before we could place it within the `NodeLayout`. So for now, let’s throw caution to the wind and just move the node’s initial position into the `NodeLayout`’s preamble where we can still get at it easily, thus leaving proper encapsulation for a later stage of development:

```d
class NodeLayout : Layout
{
	MoveableNode moveableNode;
	int[] _initialXY = [20, 140];
	
	this()
	{
		super(null, null);
		setSizeRequest(640, 360); // has to be set so signals get through from child widgets
		
		moveableNode = new MoveableNode(this);
		put(moveableNode, _initialXY[0], _initialXY[1]);
		moveableNode.setPosition(_initialXY[0], _initialXY[1]);

	} // this()
	
	
	void moveNodeTo(MoveableNode moveableNode, double x, double y)
	{
		move(moveableNode, cast(int)x, cast(int)y);
		moveableNode.setPosition(x, y);
		
	} // moveNodeTo()
	
} // class NodeLayout
```

Okay, that works. The `_initialXY` array will store the node’s starting position and sometime down the road we’ll deal with varying this initial position, perhaps by having new nodes appear attached to the mouse pointer so they can be placed wherever the user wants. Sounds like a plan, but for now, this’ll do.

Another thing we have to do is grab a pointer to the `NodeLayout` and pass it to the `MoveableNode`. Why? So we have access to `NodeLayout.moveNodeTo()` because that’s how we’ll define the `MoveableNode`’s position in relation to the `NodeLayout`. We haven’t even talked yet about how we’ll tell the `NodeLayout` where the `MoveableNode` is and it’s a bit tricky because the x/y coordinates of the mouse pointer we’ve been working with so far have been in relation to the upper-left corner of the `MoveableNode`, not the `NodeLayout`.

It may have crossed your mind, too, that we talked about `xRoot` and `yRoot` last time and that these values might be of some help. But, no. Those variables record the offset from the upper-left corner of the `Screen` which is two levels up the hierarchy as can be seen here:

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/023_nodes/screen_window_layout_node.png" alt="Figure 1: Relationship between the Screen, Window, Layout, and Node" style="width: 446px; height: 312px;">
		<figcaption>
			Figure 1: Relationship between the Screen, Window, Layout, and Node
		</figcaption>
	</figure>
</div>

And this means, in order to move the `MoveableNode` around within the `NodeLayout`, we need to translate the mouse pointer position from `MoveableNode` coordinates to `NodeLayout` coordinates. Not that it’s difficult—just mind-bending—and we’ll get to that in a moment. All you need to keep in mind for now is that `NodeLayout.moveNodeTo()` makes the actual move happen and is called from `MoveableNode.onMotionNotify()`. And after the move is made, `moveNodeTo()` reaches back into the `MoveableNode` to update its position there.

Which, unfortunately, makes these two classes tightly coupled, but considering that we likely won't use one without the other... we just might find a way to live with that.

Now, let’s look at the changes in the `MoveableNode` class.

### MoveableNode Changes

First, here’s what we’re adding to the preamble:

```d
double _xOffset = 0, _yOffset = 0;
bool _dragOn = false;
bool _connectToIn = false, _connectToOut = false;
double[] _nodePosition;
int _xIndex = 0, _yIndex = 1; // indices into the _nodePosition array
NodeLayout _nodeLayout;
```

In the very first line, we’re preparing to translate from `MoveableNode` coordinates to `Layout` coordinates. When the user clicks anywhere on the `MoveableNode`, these two variables, `_xOffset` and `_yOffset`, will record where in relation to the node’s origin (upper-left corner) the mouse pointer was at the time of the click.

Next we have `_dragOn`, a mode flag that gets *raised* when we want the `MoveableNode` to move and *lowered* when we want it to stay put. More on this in a moment.

The next two variables, `_connectToIn` and `_connectToOut`, are also mode flags—not used at this time—but as we progress toward a fully-functional nodes-n-noodles demo, we’ll be using them when we make connections between nodes. For now, they’re just there to show that we’re taking these things into account.

The `_nodePosition` array will keep track of the `MoveableNode`’s x/y coordinates on the `NodeLayout` and the next two, `_xIndex` and `_yIndex`, are here for clarity (rather than accessing the array as `_nodePosition[0]` and `_nodePosition[1]`, we do it with `_nodePosition[_xIndex]` and `_nodePosition[_yIndex]`).

And finally, `_nodeLayout` is a pointer to the `MoveableNode`’s parent container.

#### Changes to the MoveableNode’s Constructor

The first significant change here is the line:

```d
setEvents(EventMask.POINTER_MOTION_MASK | EventMask.BUTTON1_MOTION_MASK);
```

In order to separate mouse movement in two states—mouse button held down and mouse button not held down—we need to add these two signal masks. Without them, every movement of the mouse pointer will move the node, whether we're holding a mouse button down or not.

Further down, we hook up the extra signals/callbacks we’ll need to properly process all this activity, bringing our total up to four connected signals:

```d
addOnDraw(&onDraw);
addOnButtonPress(&onButtonPress);
addOnButtonRelease(&onButtonRelease);
addOnMotionNotify(&onMotionNotify);
```

As mentioned before, the processing of each node movement is done in three stages:

- in `onButtonPress()`, we figure out what was clicked and set the active flag for the appropriate area: node handle, in terminal, or out terminal,
- in `onMotionNotify()`, we figure out which direction the mouse pointer is moving and do the appropriate math to translate from node coordinates to `Layout` coordinates (this is so the `MoveableNode` can be `put()` in the right place on the `NodeLayout`), and lastly,
- in `onButtonRelease()`, we turn off the active flag so we know we’re finished with whatever activity we were carrying out: moving the node or connecting one of the terminals.

## Conclusion

Because there's so much to this node movement stuff, let's stop here for now and pick up next time by looking at a handful of new functions needed to make this whole thing work.

Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/11/12/0087-nodes-vi-hotspots.html">Previous: Node VI - Hot Spots</a>
	</div>
	<div style="float: right;">
		<a href="/2019/11/19/0089-nodes-viii-its-alive-2.html">Next: Node VIII - It's Alive! (2)</a>
	</div>
</div>
