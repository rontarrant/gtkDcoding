---
title: "0046: SpinButton"
topic: button
tag: button
layout: post
description: How to use the GTK SpinButton.
author: Ron Tarrant

---

# 0047: SpinButton

This one’s both easy and tricky. Let me explain...

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/002_button/button_18.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/002_button/button_18_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/002_button/button_18_spinbutton.d" target="_blank">here</a>.
	</div>
</div>

Having a gander at the first example, you’ll see that the only new-ish bit is this:

```d
class MySpinButton : SpinButton
{
	double minimum = -50;
	double maximum = 50;
	double step = 2;

	Adjustment adjustment;
	double initialValue = 4;
	double pageIncrement = 8;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(SpinButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()


} // class MySpinButton
```

One thing to notice here is that the `SpinButton` doesn’t work alone. It needs...

## The Adjustment

Technically, the `Adjustment` isn’t a `Widget` because it’s derived directly from `ObjectG`. This means that it doesn’t have a visual presence, but it does give you control over the range and behaviour of the `SpinButton`.

*Note: The `Adjustment` also helps out a bunch of other `Widget`s including (but not limited to):*

- *the `Container` and its offspring:*
	- *the `Layout`,*
- *the `ScaleButton`, and its child...*
	- *the `VolumeButton`,*
- *the `ScrolledWindow`, and*
- *the `Viewport`.*

In short, anything that needs adjusting. And the `Adjustment` is also the most complicated part of setting up and using a `SpinButton`.

At the top of the `MySpinButton` class definition, there’s a bunch of stuff initialized for use when instantiating the `Adjustment`, and as long as you keep these values sane, you’ll have very little trouble. These values are:

- `minimum` and `maximum` – straightforward, these are the upper and lower limits of the spinner,
- `step` – the increment added to or subtracted from the current value each time the spinner buttons are clicked... or—while the `SpinButton` has focus—each time the up and down arrow keys are pressed,
- `initialValue` – again straightforward, and then there’s...
- `pageIncrement` – how much is added to or subtracted from the spinner's current value when you hit the *Page-up* or *Page-down* keys, and
- `pageSize`... Now, this is an odd one...

## Oddity of the pageSize Argument

With a `SpinButton`, the `Adjustment`'s `pageSize` is best set to ‘0.’

## Variations on a SpinButton – Floating Point Values

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/002_button/button_19.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/002_button/button_19_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/002_button/button_19_multiple_spinbuttons.d" target="_blank">here</a>.
	</div>
</div>

In our second example, you’ll find (among others) the `FloatSpinButton` class:

```d
class FloatSpinButton : SpinButton
{
	float minimum = -1.0;
	float maximum = 1.0;
	double step = .1;

	Adjustment adjustment;
	float initialValue = 0.0;
	float pageIncrement = 0.5;
	float pageSize = 0.0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setWrap(true);
		
		addOnValueChanged(&valueChanged);
//		addOnOutput(&outputValue);
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Float Standard", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Float Standard: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class FloatSpinButton
```

The objective here is to use and show floating point values. But, notice that all the initialized parameters for the `Adjustment` are floats except for `step`. This is because of an oddity in the `Adjustment` object that seems to take two different forms, but rather than bore you with a long explanation, I’ll just give you the short version and jump right to the workaround for the current use-case...

The `SpinButton` has two signals you can hook up to:

- `onValueChanged`, and
- `onOutput`.

And there are a bunch of sane variable types you can use for the values:

- `double`,
- `float`,
- `int`,
- `byte`, and
- you can even fake a *Boolean* by limiting the callback to checking for 0 or 1 only.

For some reason, when combining certain variable types with a certain one or the other of the signals, clicking on the adjustment buttons will cause the signal to fire twice.

*Note: This will also happen if you change the current value by typing into the in-built `Entry` and hitting* Enter. *It won’t double-fire* then, *but it will next time you click on one of the adjustment buttons. At present, I know of no way to avoid this, so if this behaviour will be noticable by your users, you may want to let them know so you don't field a whole raft of bug reports on it.*

### Troubleshooting a SpinButton

So, rule of thumb for using the `SpinButton` or any other widget using the `Adjustment`:

1. If you’re getting double signal firings with the `onValueChanged` signal, switch to the `onOutput` signal... and vice versa.
2. If switching signals doesn't help, try a different variable type (`int`, `byte`, `double`, `float`, etc.)

### Precision

Now have a look at the first chunk of the `PrecisionSpinButton` class:

```d
class PrecisionSpinButton : SpinButton
{
	double minimum = -1.0;
	double maximum = 1.0;
	double step = .001;
	uint precision = 3;

	Adjustment adjustment;
	double initialValue = 0.0;
	double pageIncrement = 0.01;
	double pageSize = 0.0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setDigits(precision);

		addOnValueChanged(&valueChanged); // NO double-fire
//		addOnOutput(&outputValue); // double-fire
		
	} // this()
```

In the initialization section, we’ve got another variable: `precision`.

It’s used in the constructor with `setDigits()` to set the number of decimal places to show in the spinner.

## Wrapping Up

Now you know how to tame the `SpinButton` and `Adjustment` beasts.

## Everything but the Kitchen Sink

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/002_button/button_20.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal4" class="modal">																<!-- modal# -->
				<span class="close4">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img44">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal4");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img4");														// img#
			var modalImg = document.getElementById("img44");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close4")[0];										// close#
			
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
			<img id="img5" src="/images/screenshots/002_button/button_20_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal5" class="modal">																			<!-- modal# -->
				<span class="close5">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img55">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal5");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img5");																	// img#
			var modalImg = document.getElementById("img55");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close5")[0];													// close#
			
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

	<div class="frame-footer">																							<!---------- filename (below) ---------->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/002_button/button_20_spinbutton_experiments.d" target="_blank">here</a>.
	</div>
</div>

And just for fun, I’ve included this third example with `Double-`, `Float-`, `Precision-`, `Int-`, `Byte-`, and that fake `BoolSpinButtons` I mentioned earlier, just to show how versatile this widget can be.

*Note: The FloatSpinButton example in this file falls victim to GTK's rounding error and so my recommendation is: don't use the SpinButton for floating point values unless you're prepared to deal with the rounding error yourself.*

That’s it for this time around. Have a great day.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/06/18/0045-split-a-window-into-panes.html">Previous: Split a Window into Panes</a>
	</div>
	<div style="float: right;">
		<a href="/2019/06/25/0047-scalebutton-and-volumebutton.html">Next: ScaleButton & VolumeButton</a>
	</div>
</div>
