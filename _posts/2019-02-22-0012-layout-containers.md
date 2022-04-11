---
title: "0012: Layout Containers"
topic: container
tag: container
layout: post
description: How to use a GTK Layout container to organize UI widgets - a D language tutorial.
author: Ron Tarrant

---

# 0012: Layout Containers

Starting today, we’ll be looking at a few examples of using a `Layout` container. Since we’ve already covered the `Box` container, playing with `Layout` containers won’t be foreign, so we’ll throw in some extra techniques to keep it interesting, things like presenting a button vertically instead of horizontally.

Today’s example files show:

- a rotated button and
- multiple buttons in a layout.

## Why a Layout?

Placing widgets in a container using absolute coordinates is discouraged. Why? If your application is translated into another language or the user fiddles with font settings at the OS level, the beauty and balance of your layout is going out the window... so to speak.

But if you’re just writing utilities and applications for your own use, then hey: knock yourself out. (I do.) Anyway, it’s included here for completeness sake, so let’s get at it and since the `main()` function and the `TestRigWindow` class are the same as other examples, let’s look at the meat.

## Put that Widget Down

```d
class MyLayout : Layout
{
	this()
	{
		super(null, null);

		RotatedButton rotatedButton = new RotatedButton();
		put(rotatedButton, 10, 10);
		
	} // this()
	
} // class MyLayout
```

Like the `Box` we used in earlier examples, the derived `Layout` is mostly about getting the kids under control. The big difference here is that we don’t rely on the container to work out where things go. Instead, we use the `put()` function which takes a pointer to the child widget as well as the x and y coordinates where you want it placed.

Another drawback of using a `Layout`, and therefore the `put()` function, is that it’s going to take several code-compile-test cycles before you can lock down exactly what **x** and **y** should be. And these cycles increase in number with the complexity of your design. If for no other reason, you may want to let the `Layouts` lie and pack some `Box`es instead.

## Rotated Button

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/004_layout/layout_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/004_layout/layout_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/004_layout/layout_01_rotated.d" target="_blank">here</a>.
	</div>
</div>

And here’s that rotated button I mentioned earlier:

```d
class RotatedButton : Button
{
	this()
	{
		super();
		
		RotatedLabel rotatedLabel = new RotatedLabel();
		
		addOnClicked(delegate void(_) { doSomething(); } );
		add(rotatedLabel);
		
	} // this()

	
	void doSomething()
	{
		writeln("Action from a rotated button...");
		
	} // doSomething()
	
} // class rotatedButton
```

Of course, there’s nothing here to indicate it’s at a non-standard angle. Nope, it’s all pretty straightforward here. So, where is the angle set?

### The Real Rotated Widget: the Label

The rotation is in here with the `setAngle()` function:

```d
class RotatedLabel : Label
{
	string rotatedText = "My Rotated Label on a Button";
	
	this()
	{
		super(rotatedText);
		
		setAngle(90);
		
	} // this()
	
} // class RotatedLabel
```

It’s done this way because `setAngle()` is only found in the Label widget. But whatever gets the job done, right? There’s a lot of that in GUI design.

### Counter Intuitive?

Something else to keep in mind: angles go counter-clockwise. So if you want something angled 90 degrees to clockwise, you’ll have to set it to 270 degrees.

## Conclusion

And that’s pretty much it for this time. Yes, I mentioned a second code file at the beginning of this post, but all it does is `put()` a second button in the layout. Neither button is rotated, nor do they do anything we haven’t seen before, so there’s nothing new or exciting in the second example. It’s there mainly because I’d feel remiss if I didn’t show a button in a standard position/rotation.

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/004_layout/layout_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/004_layout/layout_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/004_layout/layout_02_put_multiple.d" target="_blank">here</a>.
	</div>
</div>

And with that said, *Insert vague comparison between* GTK *and popular space opera culture here.*

Bye, now.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/02/19/0011-callback-chains.html">Previous: Callback Chains</a>
	</div>
	<div style="float: right;">
		<a href="/2019/02/26/0013-scrolled-layout.html">Next: Scrolled Layout</a>
	</div>
</div>
