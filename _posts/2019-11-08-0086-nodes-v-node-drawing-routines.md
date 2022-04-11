---
title: "0086: Nodes-n-noodles V - The Drawing Routines"
layout: post
topic: nodes
tag: nodes
description: This GTK Tutorial covers drawing routines for a node-n-noodles demo.
author: Ron Tarrant

---

# 0086: Nodes-n-noodles V – The Drawing Routines

Before digging into the details of drawing the node, let’s do a quick summary of what we're up to with the `MoveableNode`. Here’s a visual of what we’re aiming for (in case you weren’t here last time):

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/023_nodes/nodes_06.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/023_nodes/nodes_06_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/023_nodes/nodes_06_draw_node_drawingarea.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

*Note: You'll notice that the above link doesn't lead to the same source file we used last time. That code used an external image whereas this one has the drawing routines mentioned above.*

So, here's a summary of what we're doing...

- The `MoveableNode` is based on a the `DrawingArea` widget.
	- It's the parent object, and
	- it has no drawing routines of its own.
	- This parent object's properties determine the overall size of the `MoveableNode`.
- The Shapes—the circles and rounded rectangles that make up the `MoveableNode`—are child objects.
	- Each shape has its own drawing routine, and
	- does its own preparatory calculations for shape, size, and color.
	- Each shape also keeps track of its location within the `DrawingArea` that is the `MoveableNode`. 
	- Shapes are drawn in z-depth order so, for instance, the circles used as terminals aren't masked by the larger shape of the `MoveableNode` itself.

And the reason it's done like this is so that when we get around to moving this `MoveableNode` object, all its decorations and details come along for the ride without any extra work on our part.

Okay, that’s out of the way. Let’s get at it...

## The MoveableNode Class

Compared to our first `MoveableNode` with its external image, this one is a bit more crowded. An `Image` is far less code, but it’s also external and, therefore, less portable, so in moving toward a more self-contained approach, here’s where we stand:

```d
class MoveableNode : DrawingArea
{
	NodeShape nodeShape; // appearance of the node
	NodeHandle nodeHandle; // appearance of the drag handle
	NodeTerminalIn nodeTerminalIn; // appearance of the input terminal
	TerminalInStatus terminalInStatus; // appearance of the input terminal's status block
	NodeTerminalOut nodeTerminalOut; // appearance of the output terminal
	TerminalOutStatus terminalOutStatus; // appearance of the output terminal's status block
	int width = 113, height = 102;
```

Here in the preamble, we declare all those shapes I mentioned. What we’re going to end up with is in the screen shot above. Please note that there are six sub-shapes that make up the `MoveableNode` and each is an object.

```d
	this()
	{
		nodeShape = new NodeShape();
		nodeTerminalIn = new NodeTerminalIn();
		terminalInStatus = new TerminalInStatus();
		nodeTerminalOut = new NodeTerminalOut();
		terminalOutStatus = new TerminalOutStatus();
		nodeHandle = new NodeHandle();
		addOnDraw(&onDraw);
		
	} // this()
```
	
In the constructor, each of the sub-shapes is instantiated and the `onDraw()` callback is hooked up.

```d
	bool onDraw(Scoped!Context context, Widget w)
	{
		setSizeRequest(width, height); // without this, nothing shows

		// call sub-objects' draw routines?
		nodeShape.draw(context);
		nodeTerminalIn.draw(context);
		nodeTerminalOut.draw(context);
		nodeHandle.draw(context);
		terminalInStatus.draw(context);
		terminalOutStatus.draw(context);
		
		return(true);
		
	} // onDraw()

} // class MoveableNode
```

And, naturally, in the `onDraw()` callback, the drawing routines are called. As mentioned, these routines are encapsulated in their respective classes/objects, so at this point, we don't need to concern ourselves with them any more than we have.

And I'd like to point out that the `terminalStatus` shapes are based on the `nodeHandle` shape which is derived from the `nodeShape`, so a lot of this code is being reused... sort of. In the interests of full-blown inheritance, I could have created one parent class for a general rectangular shape with rounded corners and then derived all the rest from it. But for clarity, there is some repetition. I mean, it’s not like we have to be careful how much RAM we use, right? So, let’s just set our metaphorical elbows akimbo and get on with life.

I did go so far as to outline two classes for a generic `NodeTerminal` shape and a generic `TerminalStatus` shape and from there, derived the `-In` and `-Out` versions of both. But that’s as far as I went with it. If you’re up for a bit of fun, you might take it upon yourself to design a master shape class and derive all the rounded rectangle shapes from it.

### The Sub-shapes

Each of the sub-shapes keeps track of:

- rim and fill colors, and
- it’s offset from the `MoveableNode` origin.

Drawing routines are in the sub-shape... unless the sub-shape is derived from a parent shape. In those cases (specifically, the `NodeTerminalIn`/`Out` and `TerminalStatusIn`/`Out`) drawing routines are in the parent classes `NodeTerminal` and `TerminalStatus`.

Have a gander at the sub-shape classes to see what I mean. Here's the `NodeTerminalIn` class and its parent/root class, the `NodeTerminal`:

```declare
class NodeTerminalIn : NodeTerminal
{
	double[] _rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] _fillRGBA = [1.0, 0.706, 0.004, 1.0];
	int _xOffset = 6, _yOffset = 34;
	
	this()
	{
		super(_xOffset, _yOffset, _fillRGBA, _rimRGBA);
		
	} // this()
	
} // class NodeTerminalIn


class NodeTerminal
{
	double _radius = 5,
			 _lineWidth = 2;
	int _xOffset, _yOffset;
	double[] _fillRGBA, _rimRGBA;
	
	this(int xOffset, int yOffset, double[] fillRGBA, double[] rimRGBA)
	{
		_xOffset = xOffset;
		_yOffset = yOffset;
		_fillRGBA = fillRGBA;
		_rimRGBA = rimRGBA;
		
	} // this()
	
	
	void draw(Context context)
	{
		// set up the path and color
		context.newSubPath();
		context.arc(_xOffset, _yOffset, _radius, 0, PI * 2);
		context.closePath();
		
		// fill the circle
		context.setSourceRgba(_fillRGBA[0], _fillRGBA[1], _fillRGBA[2], _fillRGBA[3]);
		context.fillPreserve();
		
		// color the path
		context.setSourceRgba(_rimRGBA[0], _rimRGBA[1], _rimRGBA[2], _rimRGBA[3]);
		context.setLineWidth(_lineWidth);
		context.stroke();
		
	} // draw()
	
} // class NodeTerminal

```

By and large, each class breaks down the same way. The preamble has:

- the origin of the shape as an offset from the origin of the parent class/object, `MoveableNode`,
- the sub-shape’s dimensions along with the radius, and
- colors, line width, etc.

Because a circle (i.e. a `NodeTerminal`) only needs a point of origin and a radius in order to draw itself, there is one set of variables that aren't used here. They only show up in the rectangular shapes (`NodeShape`, `NodeHandle`, and `TerminalStatus`):

```d
double[] northEastArc, southEastArc, southWestArc, northWestArc;
```

These four 2-element arrays keep track of where to begin and end drawing each of the rectangle's rounded corners.

The constructors for the sub-shapes are all about doing prep work for the drawing routines and the `draw()` function carries out the actual drawing. And I should point out that if these classes/objects were standalone, each `draw()` function would become an `onDraw()` callback hooked up to the `onDraw` signal for each object. But because of how we're doing this—calling all the `draw()` functions from the `MoveableNode.onDraw()` parent callback—we don't need to hook up the signals for these shapes. In fact, there are no signals at this level to hook them up to, anyway.

Everything else is very much like what we covered in earlier posts for *Cairo* drawing. The only difference, really, is that we pass the `MoveableNode`’s drawing `Context` to each sub-shape’s `draw()` function.

## Conclusion

Full disclosure: I didn’t start with the image of the node and develop the drawing routines from it. I started with a hand-drawn node, went to an *Inkscape* drawing, then developed the drawing routines. Once I got the kinks ironed out and the code was working, I did a screen shot and created the image file from there. So, in fact, I put the cart before the horse. (Don’t tell anyone.)

Next time, we’ll get into hotspots. See you then.


<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/11/05/0085-nodes-iv-node-drawing.html">Previous: Node IV -Drawing Routines</a>
	</div>
	<div style="float: right;">
		<a href="/2019/11/12/0087-nodes-vi-hotspots.html">Next: Nodes VI - Hot Spots</a>
	</div>
</div>
