---
title: "0104: Widget Opacity II"
layout: post
topic: sfx
tag: sfx
description: This GTK Tutorial covers ghosting and disabling a Widget.
author: Ron Tarrant

---

# 0104: Widget Opacity II – Real Ghosting and More Real Ghosting

Last time, we looked at how to fake ghosting using the `setOpacity()` function. This time, we’ll see how to do proper ghosting using the `setSensitive()` function. Then we’ll move on to an example wherein we overlay buttons, one ghosted and one not, over an image. And we’ll be using a `Layout` instead of a `Grid` this time.

## How to Make a Cruel Widget

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/016_sfx/sfx_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/016_sfx/sfx_07_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/016_sfx/sfx_07_insensitive.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Well, not exactly cruel... just insensitive.

Last time, it took more code to get this job done. For one thing, `MySwitch` needed a ghosting flag to keep track of when the opacity was low. And for another, we needed an entire function (`switchGhosting`) so `MyButton` could turn ghosting on and off.

But this time, we eliminate both of these. `MyButton`, because it has `MySwitch` set up as a companion (like we did last time) can go straight for the jugular:

```d
bool onButtonPress(Event e, Widget w)
{
	if(companion.getSensitive() is false)
	{
		writeln("Activating switch");
		companion.setSensitive(true);
		setLabel(labelText[1]);
	}
	else
	{
		writeln("Deactivating switch.");
		companion.setSensitive(false);
		setLabel(labelText[0]);
	}
		
	return(true);
		
} // onButtonPress()
```

It checks to see which way `MySwitch`’s sensitivity is set and flips it to the other state. Because we’re doing it this way, the opacity of the `Label` isn't going to match `MySwitch`’s insensitive state. This may be confusing for the user, so syncing the `Label`’s appearance with that of `MySwitch` may be something to try as an exercise.

Or not.

Moving right along...

The only other difference between this example and [the last one](https://github.com/rontarrant/gtkd_demos/blob/master/016_sfx/sfx_06_opacity_ghosting.d) is that the only object that knows about the `Label` is the `ButtonGrid`, so all references to `Label` outside of `ButtonGrid` are now eliminated.

## Ghosted Buttons on an Image

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/016_sfx/sfx_08.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/016_sfx/sfx_08_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/016_sfx/sfx_08_ghost_over_drawingarea.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

There may be nothing inherently new in this demo, but it is another way to demonstrate what we’re talking about as well as present another possible use case. Here is a list of what’s being demonstrated here:

- an opacity-ghosted `Button` can be active,
- an insensitive `Button` can’t, and
- making a `Button` insensitive doesn’t change its opacity.

And since we’re using a Layout instead of a `Grid`, let’s look at how all this fits together...

### The BGLayout Class

```d
class BGLayout : Layout
{
	MyButton myButton1, myButton2, myButton3;
	BGDrawingArea bgDrawing;
	
	this()
	{
		super(null, null);
		setSizeRequest(640, 426); // has to be set so signals get through from child widgets
		
		bgDrawing = new BGDrawingArea();
		put(bgDrawing, 0, 0);		
		
		myButton1 = new MyButton(0);
		put(myButton1, 226, 213);
		myButton1.setOpacity(0.5);

		myButton2 = new MyButton(1);
		put(myButton2, 320, 120);

		myButton3 = new MyButton(2);
		put(myButton3, 175, 306);
		myButton3.setSensitive(false);
		
	} // this()
	
} // class BGLayout
```

Because we want to place these `Button`s over parts of the image that will show through, thus proving the transparency of the `Button`s, we’re using a `Layout` so we don’t have to fiddle around too much when placing them.

Notice also that each call to `MyButton()` passes in a number. This is the index into the `labelText` array in the `MyButton` class and decides which of the three strings we’ll use initially for labeling the `Button`s.

### The MyButton Class

Here’s the preamble where the `labelText` string array is defined:

```d
string[] labelText = ["Ghosted", "Non-ghosted", "Insensitive"];
```

#### The Constructor

```d
this(int labelIndex)
{
	super(labelText[labelIndex]);
	addOnButtonPress(&onButtonPress);

} // this()
```

Just pick the label string and hook up the signal.

#### The Callback

```d
bool onButtonPress(Event e, Widget w)
{
	if(getOpacity() !is 1.0)
	{
		setLabel(labelText[1]);
		setOpacity(1.0);
		writeln("opacity = ", getOpacity(), ", turning it to full.");
	}
	else
	{
		setLabel(labelText[0]);
		setOpacity(0.5);
		writeln("opacity = ", getOpacity(), ", turning it to half.");
	}
	writeln("Button pressed is: ", getLabel());
	
	return(true);
	
} // onButtonPress()
```

Here, we check the opacity setting, using an `if`/`else` to switch back and forth from half opacity to full.

You may wonder why I’ve done it this way, checking to see if opacity is set to `1.0`. In fact, you may be tempted to test if it’s set to `0.5` (I was at first.). But the reality of the situation is that when you set the opacity to `0.5`, it’s actually set to `0.501961`. It's our old buddy FPI (Floating Point Inaccuracy) come to play havoc with our sanity. You could test for `0.501961` if you like, but I don't imagine it's worth the extra typing. Who knows if the inaccuracy will be the same from one OS to another or between the 32-bit and the 64-bit versions of an OS. It seems more sane to me to test for `1.0` instead. Or if you want to deal with finer-tuned numbers, just look for a range like this:

```d
if(getOpacity() > 0.5 && getOpacity() < 0.6)
```

Of course, you might also switch based on the `labelText`, like this:

```d
if(getLabel() == labelText[0])
{
	setLabel(labelText[1]);
	setOpacity(1.0);
	writeln("label: ", getLabel(), ", opacity = ", getOpacity(), ", turning it to full.");
}
else
{
	setLabel(labelText[0]);
	setOpacity(0.5);
	writeln("label: ", getLabel(), ", opacity = ", getOpacity(), ", turning it to half.");
}
```

All this does is look to see if the label text is `“Ghosted”` and if it is, changes it to `“Non-ghosted”`.

Note: You might think you can do a string comparison with the is keyword as in:

```d
if(getLabel() is labelText[0])
```

However, because *D* uses *Unicode* strings, we can’t do that, but but we can do this:

```d
getLabel() == labelText[0]
```

I’ve left both methods in the source with the label comparison commented out so you can (to borrow an expression from my grandmother) pick your choose.

## Conclusion

So much for ghosting, opacity, and sensitivity. Next time, we’ll look at some common *D-language* stuff that you may find useful in building a UI, even though these snippets aren’t necessarily *GTK*-specific.

Until then, have a happy life.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/03/01/0103-widget-opacity.html">Previous: Widget Opacity</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/03/23/0105-dlang-ui-snippets-i.html">Next: Dlang UI Snippets I</a>
	</div>
-->
</div>
