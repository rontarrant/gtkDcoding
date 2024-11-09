---
title: "0099: SFX - Button Interactions"
layout: post
topic: sfx
tag: sfx
description: This GTK Tutorial covers interactions between buttons.
author: Ron Tarrant

---

# 0099: SFX - Button Interactions

This post came about as the result of a request from Joel Christensen who asked me to cook up a demo wherein clicking one *GTK* `Button` would change the appearance of another.

Anyway, on with the show...

## Changing Another Button’s Text Label

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/016_sfx/sfx_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/016_sfx/sfx_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/016_sfx/sfx_01_button_to_button_text.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

But let's get both buttons to react, each to the other. This isn't really an *Observer* pattern, although it could be written as one. Instead, you might think of it as a *Cooperator* pattern if, indeed, it warrants being called a pattern at all. (*Note: in an upcoming post, we'll look at using the* Observer *pattern to get a Button to affect changes in whatever types of `Widget` we point it at.*)

For this demonstration, the most straightforward (and immediately noticeable) change that can be made in the partner `Button` is to switch out the text label, so that’s what we’ll do.

And since the text label changes will go back and forth between the two `Button`s, let's call this class `PingPongButton`.

### The PingPongButton Preamble

Here’s what gets declared and defined in the preamble:

```d
int labelNumber = 0;
string labelText;
string[] nameSuffixes = [" Tra", " La", " Li"];
PingPongButton partnerButton;
```

And here’s what they mean:

- `int labelNumber`: an index into the `nameSuffixes` array,
- `string labelText`: the base name for the button (which is passed in from outside),
- `string nameSuffixes`: an array of suffixes for the button names that we can switch between each time a `PingPongButton` is clicked, and
- `PingPongButton partnerButton`: a reference to a companion button that will interact with this one.

### The PingPongButton Constructor

This is fairly plain and simple despite the extra functionality we’re stuffing into it:

```d
this(string buttonLabel)
{
	super(buttonLabel ~ nameSuffixes[0]);
	labelText = buttonLabel;
		
	addOnButtonPress(&onButtonPress);
		
} // this()
```

As mentioned above, we’re passing in a string to use as `Button` label text. That gets concatenated to the first element of the `nameSuffixes` array on start-up, but we’ll be switching that up in a moment.

And, of course, the only other thing happening here is hooking up the `onButtonPress` signal.

Moving right along...

### The Callback

There’s nothing mysterious here:

```d
bool onButtonPress(Event e, Widget w)
{
	string newLabel;
	
	labelNumber++;
		
	if(labelNumber == nameSuffixes.length)
	{
		labelNumber = 0;
	}
		
	newLabel = labelText ~ nameSuffixes[labelNumber];
	partnerButton.setLabel(newLabel);
		
	writeln("Partner button label has changed to: ", newLabel);
		
	return(true);
		
} // onButtonPress()
```

After setting up a string to hold the new label text we’re about to build, we increment the index we use for digging into the `nameSuffixes` array.

Then we check to make sure we aren’t running off the end of the `nameSuffixes` string array by testing for the array length and rewinding our index to `0`.

From there, it’s all rather predictable. We concatenate the new label text together and slap it onto the companion button.

But we haven’t mentioned how to get the reference to the companion `Button`. Well, like most things *GtkD*, it's not complicated once you've seen it done...

### The addPartner() Function

Here’s the last piece of the puzzle:

```d
void addPartner(PingPongButton newPartnerButton)
{
	writeln("New partner button for ", getLabel(), ": ", newPartnerButton.getLabel());
	partnerButton = newPartnerButton;
		
} // addPartner()
```

This function is called from the `AppBox` class right after both `PingPongButton`s are instantiated. One call for each `PingPongButton` and we're all set up.

And since we’re talking about it, here’s...

### The AppBox Class

Let's just look at the whole thing, shall we?

#### Preamble

Meet `Ralph` and `George`, our two `Button`s, each with the power to change the other:
```d
string ralph = "Ralph", george = "George";
PingPongButton pingButton, pongButton;
int globalPadding = 10, localPadding = 5;
```

#### Constructor

And here is how we set them up:

```d
this()
{
	super(Orientation.HORIZONTAL, globalPadding);
		
	pingButton = new PingPongButton(ralph);
	packStart(pingButton, false, false, localPadding);

	pongButton = new PingPongButton(george);
	packStart(pongButton, false, false, localPadding);

	// partner up the buttons
	pingButton.addPartner(pongButton);
	pongButton.addPartner(pingButton);
		
} // this()
```

The most important bit here is that both buttons need to be instantiated before we make the calls to `addPartner()`, one call for each button. Obviously, `addPartner()` can only be called at a time when both buttons exist.

## Conclusion

And that’s how to affect the appearance of one `Button` with another. But we’re not done with this because it occurred to me that we might also want to change other things besides the text labels. What about the color of the `Button`? Or the text label’s font?

Tune in next time when we’ll take a look at this. Here’s a hint: it involves *CSS*.

See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/01/14/0098-headerbar-more.html">Previous: HeaderBar - More</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/01/28/0100-sfx-button-interactions-ii-color-font-shape.html">Next: Button Interactions II</a>
	</div>
-->
</div>
