---
title: "0021: Labels with Background Colors & Markup"
topic: text
layout: post
description: How to give a GTK Label a unique background colour - a D language tutorial.
author: Ron Tarrant

---

# 0021: Labels with Background Colors & Markup

Whenever you create a *GTK* `Button` and slap text on it, even though it’s not obvious at first glance, the text ends up on a `Label`. So, today we’re going to skip the `Button` and go straight to the `Label`.

## Label Background Color

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/008_label/label_008_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/008_label/label_008_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/008_label/label_008_01_bg_color.d" target="_blank">here</a>.
	</div>
</div>


One thing you can’t do with a `Label` is give it a colored background… unless you stick the `Label` into an `EventBox`.

## Abbreviated Intro to the EventBox

This widget was mostly invented so programmers could reanimate dead things like Labels and make them react to mouse clicks and keyboard input. An `EventBox` allows us to let loose our inner Frankenstein, but we can do more then react to events. We can also change the background colour through the use of `StateFlags` and overrides.

There is baggage, however. We need to build a colour from scratch before we engage the `EventBox`’s `overrideBackgroundColor()` function. Here’s what all that looks like:

{% highlight d %}
	class RedLabel : EventBox
	{
		Label label;
		RGBA redishColor;
		// extra spaces at start and end so it doesn't look crowded
		string labelText = "  Label with Red Background  ";
		
		this()
		{
			super();
			label = new Label(labelText);
			redishColor = new RGBA(1.0, 0.420, 0.557, 1.0);
			overrideBackgroundColor(StateFlags.NORMAL, redishColor);
			
			add(label);
			
		} // this()
		
	} // class RedLabel
{% endhighlight %}

You’ll notice that we’re deriving a new class from the `EventBox`. We could go a step further down the OOP trail and do this up as an interface and derive the `RedLabel` from there, leaving us with a pattern for creating `Label`s of other colours down the road. But for now, this’ll do.

The `labelText` string has lots of extra space on either side, but this is for aesthetic reasons. Letting the text touch the edges of the coloured area is like fingernails on a chalkboard to my inner designer. (Mad scientist, designer... yeah, it's crowded in there.)

### Color as an RGBA Object

Smack in the middle of the constructor is where we build the colour as an `RGBA` object. Keep in mind that *GTK* defines each colour with four channels:

- red,
- green,
- blue, and
- alpha.

And the values for those channels have a range from **0.0 to 1.0** rather than the **0 to 255** (or **#00 to #FF**) we may be used to seeing. You’ll need a calculator to convert from *Photoshop* or G.I.M.P. palette colours. Of course, you could also use *Blender* which would be handier because *Blender* uses that same **0.0 to 1.0** range. No conversion necessary. Besides, [*Blender*’s free](https://www.blender.org/download/).

The second-last line of the constructor calls `overrideBackgroundColor()`, telling it our customized colour goes along with the `NORMAL` state of the `EventBox`. In other words, the `EventBox` doesn’t have to be selected, checked, hovered over, or in focus for our custom colour to appear.

And finally, we drop the `Label` into the `EventBox`.

Moving right along...

## Markup on a Label

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/008_label/label_008_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/008_label/label_008_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/008_label/label_008_02_markup.d" target="_blank">here</a>.
	</div>
</div>

*GTK* patterns its markup after HTML, css, and all that web stuff, so if you’re familiar with web development at the hand-coding level, you’re well prepared.

### The MarkupSwitchButton Class

That’s this thing:

{% highlight d %}
	class MarkupSwitchButton : Button
	{
		MarkupLabel muLabel;
		
		this()
		{
			super();
			muLabel = new MarkupLabel();
			add(muLabel);
			
			addOnClicked(&switchStuff);
	
		} // this()
	
	
		void switchStuff(Button b)
		{
			muLabel.markupSwitch();
			
		} // switchStuff()
		
	} // class MarkupSwitchButton
{% endhighlight %}

The class is based on a `Button` and we drop in the fancied-up `Label`. Then we point the callback at the `markupSwitch()` function, a member function of the `MarkupLabel` class… which looks like this:

{% highlight d %}
	class MarkupLabel : Label
	{
		string markupText = "<i>Fancy</i> <b>Schmancy</b>";
		string onMessage = "Markup is ON.";
		string offMessage = "Markup is OFF.";
		string currentStateMessage;
		
		this()
		{
			super(markupText);
			setUseMarkup(true);
			currentStateMessage = onMessage;
			markupState();
			
		} // this()
		
		// a function to turn markup on and off
		void markupSwitch()
		{
			if(getUseMarkup() == true)
			{
				setUseMarkup(false);
				currentStateMessage = offMessage;
			}
			else
			{
				setUseMarkup(true);
				currentStateMessage = onMessage;
			}
	
			markupState();
	
		} // markupSwitch()
		
		
		void markupState()
		{
			writeln(currentStateMessage);
			
		} // markupState()
	
	} // class MarkupLabel
{% endhighlight %}

Most of this (as is usual by now) is standard stuff. Some notable exceptions being:

- the `markupText` string uses HTML formatting circa 1999, and
- we have to explicitly tell the `Label` to `setUseMarkup()` so the markup will show.

And the rest is a function to switch the `Label`’s appear and another to relay the `Label`’s state to the command shell.

Okay, well that was fun. Keep those cards and letters coming in and I’ll see you next time around.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/22/0020-image-buttons.html">Previous: Image Buttons</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/29/0022-grids.html">Next: Grids</a>
	</div>
</div>
