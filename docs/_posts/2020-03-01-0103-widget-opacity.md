---
title: "0103: SFX - Widget Opacity"
layout: post
topic: sfx
description: This GTK Tutorial covers ghosting a Widget using opacity.
author: Ron Tarrant

---

# 0103: SFX - Widget Opacity

The most common thing for diminished opacity to signal is that a `Widget` isn't currently available. However, it may also be that we want to see what's behind the `Widget`(s) while we fiddle with them to set a bunch of settings. To these ends, let's look at how opacity is changed in *GTK*.  

## Setting Opacity

Here’s a straightforward example to start:

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/016_sfx/sfx_016_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/016_sfx/sfx_016_05_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/016_sfx/sfx_016_05_opacity.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

To get that ghosted look for the second `Button`, its opacity is set using the `setOpacity()` function... which you’ll find in the `AppBox` constructor:

```d
button2.setOpacity(0.5);
```

That’s all well and good, but let's look at some situations where such a thing might be useful.

## A Fake Ghosted Button
 
Now, when I say “useful,” take that with a grain of salt because we’ll see further along that what we’re about to do—fake a ghosted `Button`—can be done another way. Still, it’s nearly impossible to predict when something may or may not come in handy, so let’s take a look...

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/016_sfx/sfx_016_06.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/016_sfx/sfx_016_06_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/016_sfx/sfx_016_06_opacity_ghosting.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

For the sake of reasonable layout management, we’ll toss these buttons onto a `Grid` like this:

```d
class ButtonGrid : Grid
{
	MySwitch mySwitch;
	MyButton myButton;
	Label switchLabel;
	int borderWidth = 10;
	int columnSpacing = 10, rowSpacing = 5;

	this()
	{
		switchLabel = new Label("Ghost Me");
		attach(switchLabel, 0, 0, 1, 1);
		mySwitch = new MySwitch();
		mySwitch.setLabel(switchLabel);
		attach(mySwitch, 1, 0, 1, 1);
		
		myButton = new MyButton();
		attach(myButton, 0, 1, 2, 1);
		myButton.setCompanion(mySwitch);

		setBorderWidth(borderWidth);
		setMarginBottom(10);
		setColumnSpacing(columnSpacing);
		setRowSpacing(rowSpacing);
		
	} // this()
	
} // class ButtonGrid
```

Why are we looking at this? It never hurts to take a fresh look at aesthetics and all that border, row, and column spacing stuff.

But the main thing I want to draw your attention to is the `setCompanion()` function (the eighth statement in the constructor). It sets up an association between the `Button` and the `Switch` so that clicking on the `Button` can affect the appearance and behaviour of the `Switch`, sort of an extension of what we were talking about in Blog Posts [0099: SFX - Button Interactions](/2020/01/21/0099-sfx-button-interactions-i-text-labels.html) and [0100: SFX - Button Interactions II, Color, Font, & Shape](/2020/01/28/0100-sfx-button-interactions-ii-color-font-shape.html).

The function is part of the `MyButton` object:

```d
void setCompanion(MySwitch mySwitch)
{
	companion = mySwitch;
		
} // setCompanion()
```

And the action takes place in `MyButton`’s `onButtonPress()` callback:

```d
bool onButtonPress(Event e, Widget w)
{
	if(companion.getGhosting() is true)
	{
		writeln("Activating switch");
		companion.switchGhosting(false);
		setLabel(labelText[1]);
	}
	else
	{
		writeln("Deactivating switch.");
		companion.switchGhosting(true);
		setLabel(labelText[0]);
	}
		
	return(true);
		
} // onButtonPress()
```

You’ll notice that the `if`/`else` depends on a flag that’s actually a property of the `MySwitch` object. More about that in a moment. First, take a look at the rocker action of the `if`/`else`. If the flag is set, unset it. If not, set it.

But we also change the `MyButton` label to reflect the state of `MySwitch`. If you’ve already looked at the complete code file, you may have noticed in the `MyButton` preamble, as well as having a pointer to a `MySwitch` object, there’s a string array for `Label`s:

```d
string[] labelText = ["Activate", "Deactivate"];
```

And now you know why that’s there.

### Breakdown of MySwitch

Starting with the preamble, we have:

```d
Label switchLabel;
bool ghosting = false;
```

Because a `Switch` widget doesn’t have the capacity for a label of its own, we give it one by supplying a `Label` widget. This is the reason for the `Grid`. In fact, I opted for a `Grid` so the `Label` can easily be placed beside `MySwitch` while `MyButton` occupies its own row below.

And because this is a `Switch`, we harness it with the `onStateSet` signal, hooking up our callback function of the same name, `onStateSet()` which looks like this:

```d
bool onStateSet(bool state, Switch s)
{
	if(!ghosting)
	{
		setState(state);
		writeln("State set is: ", getState(), " and state is: ", state);
	}
	else
	{
		writeln("Switch is ghosted. Doing nothing.");
	}
		
	return(true);
		
} // onStateSet()
```

This handles setting and unsetting that `ghosting` flag we saw in the preamble. And, like the `if`/`else` in `MyButton`’s `onButtonPress()` callback, it’s simply a matter of checking the state of the flag and, no matter which state we find, we switch to the other.

And speaking of switching the flag, here’s the function we call from `MyButton` to do the switching:

```d
void switchGhosting(bool on)
{
	ghosting = on;
		
	if(on is true)
	{
		setOpacity(0.5);
		switchLabel.setOpacity(0.5);
	}
	else
	{
		setOpacity(1.0);
		switchLabel.setOpacity(1.0);
	}
		
} // switchGhosting()
```

At first glance, you may wonder why the argument to this function is named `on`. By the time you get to the `if`/`else`, it should be clear:

```d
if(on is true)
```

Because `if(on is false)` tells of the opposite state, right?

And this is where the demonstrated action takes place. We either set `MySwitch`’s opacity to half (`0.5`) or full (`1.0`). Then we do the same thing with the `Label`, just to demonstrate that this opacity stuff can be set on any `Widget`.

The rest of this demo is straightforward enough.

## Conclusion

Now we’ve seen how to set opacity for three types of `Widget`:

- `Button`,
- `Label`, and
- `Switch`.

But there are a few more circumstances I’d like to cover as well as a completely different approach to ghosting, something that’s actually more natural for *GTK* and disables the `Widget` at the same time it ghosts it. And that, we’ll cover next time.

See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/02/19/0102-grid-spacing.html">Previous: Grid Spacing</a>
	</div>
	<div style="float: right;">
		<a href="/2020/03/12/0104-widget-opacity-ii.html">Next: Widget Opacity II</a>
	</div>
</div>
