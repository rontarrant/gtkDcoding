---
title: "0019: Disappearing Entry Text and Font Selection"
topic: text
layout: post
description: How to make a GTK Entry widget disappear and how to use the FontButton - a D language tutorial.
author: Ron Tarrant

---

# 0019: Disappearing Entry Text and Font Selection

Today’s examples are quite unrelated. The only reason they appear in the same blog post is because my mind skipped from disappearing text Entry boxes to font selection. I don’t know why and it really doesn’t matter, so let’s just get on with it.

## Disappearing Entry

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/006_text/text_006_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/006_text/text_006_04_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_04_disappearing_entry.d" target="_blank">here</a>.
	</div>
</div>


Because the `TextRigWindow` class does a drill-down into the Entry to grab the text, I’ll start with the `Entry` and work backwards to `TextRigWindow`’s `endProgram()` function so as to keep things in context.

Firstly, we’re stuffing our two widgets—a text `Entry` and a `CheckButton`—into a Box and because we want to do that drill-down I mentioned, the `Box` will be manifested in the `EntryBox` class. This allows us, as we’ve done before, to use variables to access the widgets in the `Box`:

```d
Entry entry;
CheckButton checkButton;
```

We also have the padding and the `CheckButton` label text here:

```d
int padding = 5;
string checkText = "Visible";
```

The constructor is very much the same as so many other example we’ve already examined:

```d
this()
{
	super(Orientation.VERTICAL, padding);
	
	entry = new Entry();
	
	checkButton = new CheckButton(checkText);
	checkButton.addOnToggled(&entryVisible);
	checkButton.setActive(true);
			
	add(entry);
	add(checkButton);
	
} // this()
```

First we create the `Box`, passing along the orientation and padding we want, the create the widgets. Hook up the `onToggled` signal and set the default state of the `CheckButton` so it’s checked. Dump them into the box and off we go.

For the callback, things should also be very familiar by now. It breaks down as:

- a string array holds part of the message we’ll be writing to the command shell,
- we collect the state of the `CheckButton` and use it to set the `Entry`’s visibility, and
- grab the button’s state once more to use as an index into the string array and make the message complete.

That’s one down. Now let’s look at…

## The Font Button Example

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/006_text/text_006_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/006_text/text_006_05_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_05_fontbutton.d" target="_blank">here</a>.
	</div>
</div>


This one is so straightforward, it almost doesn’t need any explanation. And the reason is that **GTK**’s `FontButton` wears its heart on its sleeve, so to speak. The selected font and its size show up on the button itself. Click the button and a list of fonts appears along with a set of sizing widgets. Jammed in between the font list and the sizing widgets is an `Entry` field where you can type example text so you know exactly what you’re getting into when you select a font.

But all I’ve talked about here is just what the `FontButton` does. What about the code?

It’s so dead simple as to be almost laughable. The only thing I’ll point out is that the `TestRigWindow`’s `endProgram()` function grabs the currently-selected font along with it’s weight and size and dumps all this info to the command shell.

```d
void endProgram(Widget w)
{
	writeln("The text entry box holds: ", fontButton.getFontName());
	
} // endProgram()
```

And that’s two down.

Next time, I’ll introduce you to images on buttons and how to swap them. Until then, happy D-coding and may you find a less tired cliché than I have in other blog posts.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/15/0018-variations-on-a-text-entry.html">Previous: Text Entry Variations</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/22/0020-image-buttons.html">Next: Image Buttons</a>
	</div>
</div>
