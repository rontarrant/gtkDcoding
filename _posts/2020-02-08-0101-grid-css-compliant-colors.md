---
title: "0101: Grid with CSS 4.x Compliant Colouring"
layout: post
topic: container
tag: container
description: This GTK Tutorial covers laying out a Grid using CSS in a GTK 4.x-compliant way.
author: Ron Tarrant

---

# 0101: Grid with GTK 4.x-compliant CSS Coloring

Since I started this blog back in January 2019, the D language has gone from being #25 in popularity to #14 as of early February 2020. That's a significant jump and I couldn't be happier that my favourite language is doing so well. I have no idea if this blog has helped in any way with this, but it's fun to think it has. In the end, though, what really matters is that more and more people are discovering a fine language and—dare I say—the world is a better place for it.

This being the 101st post, let’s circle back around to cover some topics that were missed the first time through the list of `Widget`s. The plan for this post was originally to dig into setting column and row spacing for a `Grid`, but then I realized that before we go there, we need to revisit how we actually create the checkerboard `Grid`. Why? Because the way we did this before won't work after *GTK 4.x* is released and since we have an alternate way of doing this now, let's get a jumpstart on things, shall we?

## A Checkerboard Grid with CSS

We touched on *CSS* before a few times, but as stated above, we need to take a new look at the checkerboard `Grid` demo. What we did before to colour the background of a `Label` was stuff it into an `EventBox`. But this mechanism is deprecated. Bye, bye `EventBox`. It’s been nice knowing you.

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/009_grid/grid_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/009_grid/grid_05_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/009_grid/grid_05_checkerboard_css.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

### A New WideLabel Class

So, what are we going to use in place of the `EventBox`? Well... nothing, really. Not as a container, anyway. Instead, we'll associate a *CSS* object with our `Label` directly.

Here’s what the original `WideLabel` class looked like:

```d
class WideLabel : EventBox
{
	Label label;
	
	this(string text)
	{
		super();
			
		label = new Label(text);
		label.setSizeRequest(60, 60);
		add(label);
			
	} // this()
	
} // class WideLabel
```

Here, the `Label` was a child of the `WideLabel` class and the class itself was derived from the `EventBox`. Comparing that to the new `WideLabel` class:

```d
class WideLabel : Label
{
	this(string text)
	{
		super(text);
		
		setSizeRequest(60, 60);
			
	} // this()
	
} // class WideLabel
```

See? Much simpiler now. `WideLabel` is derived from `Label` and when we get to the next level of derivation, the whole thing will become clear.

And BTW, my understanding is that we aren’t actually missing out by losing the `EventBox`. Any functionality worth having will be moved elsewhere, but we’ll talk more about that when *GTK 4.x* arrives.

Now let’s compare one of `WideLabel`’s derived classes, the old version and the new...

### The BlueLabel Class

Here’s what this used to look like:

```d
class BlueLabel : WideLabel
{
	this(string labelText)
	{
		super(labelText);
		
		RGBA blueColor = new RGBA(0.518, 0.710, 1.0, 1.0); // 0.518	0.710	1.000
		overrideBackgroundColor(StateFlags.NORMAL, blueColor);
		
	} // this()
	
} // class BlueLabel
```

We were mucky around with overriding colors and states. And don't forget, all this is being done to the `EventBox`, not the `Label`, because without *CSS*, we have no other way to give a `Label` a non-default background color.

But in the new version:

```d
class BlueLabel : WideLabel
{
	CSS css;
	string blueLabelName = "blue_label";

	this(string labelText)
	{
		super(labelText);
		setName(blueLabelName);
		css = new CSS(getStyleContext());
		
	} // this()
	
} // class BlueLabel
```

We start off by setting up a *CSS* object (which is the same as we’ve used elsewhere, but we’ll look at it again below) and giving our `BlueLabel` class a *CSS* name. Attach the *CSS* object to the `BlueLabel` object and that’s that.

### The CSS Object

We’ve seen this before, but let’s have another look anyway:

```d
class CSS // GTK4 compliant
{
	CssProvider provider;

	enum LABEL_CSS = "label#red_label
		{
			background-color: #84B5FF;
		}
		label#blue_label
		{
			background-color: #FF6B8E;
		}";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(LABEL_CSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
```

The main thing to notice here is that we have two *CSS* names defined, one for a red background and another for a blue.

And when we look again at two statements from the `BlueLabel` preamble and constructor:

```d
string blueLabelName = "blue_label";

setName(blueLabelName);
```

We see that we've got a match between the selector name and the `BlueLabel` *CSS* name.

The same thing appears in the `RedLabel` class, except that, of course, the string is called `redLabelName` and is set to `“red_label”`.

Absolutely nothing else needs to be changed to make this work. Our `Grid` full of `Label`s with non-standard background colors has made the transition to *GTK 4.x* compliance.

## Conclusion

Next time, we’ll take another look at the `Grid` and I’ll show you a different way to give a `Grid` extra spacing around each cell.

Until then, happy February. I feel like a lot of us will need this wish what with all this global warming stuff going on. Stay warm and see you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/01/28/0100-sfx-button-interactions-ii-color-font-shape.html">Previous: Button Interactions - Color, Font, Shape Changes</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/02/19/0102-grid-spacing.html">Next: Grid Spacing</a>
	</div>
-->
</div>

