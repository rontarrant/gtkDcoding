---
title: "0100: SFX - Button Interactions II - Color, Font, & Shape"
layout: post
topic: sfx
description: This GTK Tutorial covers interactions between buttons using CSS to change color, font and shape.
author: Ron Tarrant

---

# 0100: SFX - Button Interactions II – Changing Color, Font, & Shape

Great Smokin’ Widgets! It’s the *100th GtkDcoding Blog Post*!

It’s been just over a year since I started this blog and I really didn’t think it would last this long. But thanks to the encouragement and sponsorship of readers—the latter through *GtkDcoding*'s acceptance into the *GitHub Sponsorship* program—here we are.

I thank you all from the bottom of my heart. (This is when we clink glasses.)

Now that we’ve had a little bit of a celebration, let’s turn to the subject of the day: continuing to fulfill Joel Christensen's request to affect the appearance of one `Button` by clicking another `Button`.

This time around, we won't just affect the appearance, but also the colour and shape of the `Button`s, all with the help of a *CSS* object, starting with...

## Swapping the Button’s Background Color

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/016_sfx/sfx_016_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/016_sfx/sfx_016_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/016_sfx/sfx_016_02_button_to_button_color.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The first demo today will involve the two buttons changing each other’s background colour and for that purpose, we’ll bring back `Ralph` and `George` again. To understand the changes that bring this about, we’ll start by looking at...

### The AppBox

In the `AppBox` preamble, we add a single line:

```d
int[string] colorNumbers;
```

And that’s put to use in the constructor:

```d
this()
{
	super(Orientation.HORIZONTAL, globalPadding);
	colorNumbers = ["red" : 0, "blue" : 1];
		
	pingButton = new PingPongButton(ralph, colorNumbers["red"]);
	packStart(pingButton, false, false, localPadding);

	pongButton = new PingPongButton(george, colorNumbers["blue"]);
	packStart(pongButton, false, false, localPadding);

	// partner up the buttons
	pingButton.addPartner(pongButton);
	pongButton.addPartner(pingButton);
		
} // this()
```

As we’ve had to do before with associative arrays, we hold off initializing the `colorNumbers` array until the constructor to avoid compiler errors.

Also, this means we’ll be passing in a second argument when instantiating a `PingPongButton`. We supply not just the button’s name, but it’s initial background color as well. Everything else here is the same.

### The CSS Class

As it is in *HTML* pages, *CSS* can be dynamic in a *GTK* application. We’ve looked at *CSS* before when we discussed `Frame` borders ([Blog Post #0073](/2019/09/24/0073-frame-part-ii.html)) and again in the posts covering customized `Notebook` tabs ([Blog Post #0077](/2019/10/08/0077-notebook-i-basics.html)).

This time, we’ll use the *CSS* a little differently, but changes to the *CSS* class aren’t that drastic. In fact, there’s really only one change. In previous examples, we defined one *CSS* selector for each element, but here, we define two:

```d
enum LABEL_CSS = ".text-button#pingpongred
			{
				background: #FFBFBF;
			}
			.text-button#pingpongblue
			{
				background: #BFC7FF;
			}";
```

And that’s so we can ping-pong back and forth between them. Speaking of which, let’s look at the changes in the `PingPongButton` class that make this possible...

### The PingPongButton Class

Changes start in the preamble where we add these two lines:

```d
string[] labelNames = ["pingpongred", "pingpongblue"];
CSS css;
```

If you recall, the way to engage *CSS* within a *GTK* application is to associate a *CSS* selector with the `Widget` by invoking the `Widget`’s *CSS* name. If the `Widget` doesn’t have a *CSS* name, we need to supply one that matches a selector defined in the `LABEL_CSS` enum shown above. To get the `Widget` to switch between two selectors, we use the `labelNames` array in `PingPongButton` to bounce back and forth between the two possible *CSS* names.

And, of course, we supply the `PingPongButton` with its initial *CSS* name and give it access to the *CSS* object with these statements:

```d
setName(labelNames[color]);
css = new CSS(getStyleContext());
```

And, as usual, we instantiate a *CSS* object as the final stage to making the *CSS* available to the `PingPongButton`.

Lastly, we add these lines to the `onButtonPress()` callback:

```d
if(partnerButton.getName() == "pingpongred")
{
	writeln("CSS name is red, switching to blue");
	partnerButton.setName("pingpongblue");
}
else
{
	writeln("CSS name is blue, switching to red");
	partnerButton.setName("pingpongred");
}
```

And that brings about the ping-pong effect in the companion `Button`.

## One Final Example

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/016_sfx/sfx_016_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/016_sfx/sfx_016_03_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/016_sfx/sfx_016_03_button_to_button_font.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

In this demo, we change the font and the roundness of the `Button` corners, but the only thing we need to do is change the details of the *CSS* selectors like this:

```d
enum LABEL_CSS = ".text-button#pingpongred
			{
				font-family: Times New Roman;
				border-radius: 20px;
			}
			.text-button#pingpongblue
			{
				font-family: Arial;
			}";
```

Just a side note: the border-radius rule in the `pingpongred` selector can be just about any whole number, but for maximum roundness, it’s got to be at least `20`. Anything larger won’t make enough visible difference to matter. Anything smaller (you can go as low as `1`) will diminish the roundness until the effect is the same as not using border-radius.

## Conclusion

And there you have it, another technique you can use to keep your user oriented (or disoriented, if that's your aim) to changes in your application. It’s not the kind of thing you’d use just any old time, but if you need to—for instance—tell your user to think carefully about clicking `Button`s in a certain order, turning one of them red may help get the point across.

And so we bring our 100th posting celebration to a close. Along with those 100 posts go nearly 200 demos of the various features of *GTK*. I hope you've had as much fun reading them as I’ve had writing them.

## Hiatus

Because of other commitments encroaching on my time, I'll be slowing things down here on the GtkD Coding Blog. Postings will be sporadic for a while, but will continue, so keep those cards and letters coming in while I try to sort out the rest of my life. I'll still be keeping an eye on my email and on the various forums, so if you have questions or comments, please don't hesitate to get in touch. 

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/01/21/0099-sfx-button-interactions-i-text-labels.html">Next: SFX - Changing Button Text</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/02/04/0101-grid-css-compliant-colors.html">Next: Grid with GTK 4.x-compliant CSS Colors</a>
	</div>
-->
</div>
