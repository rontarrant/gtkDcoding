---
title: "0098: More HeaderBar Stuff"
layout: post
topic: bar
description: This GTK Tutorial covers adding buttons to a HeaderBar and shows how to rearrange the contents of a HeaderBar.
author: Ron Tarrant

---

# 0098: More HeaderBar Stuff

Something else you can do with a `HeaderBar` is add an extra `Button` or three. Why? I’ll leave that to your imagination just as I'll leave you to ponder why you'd wanna rearrange the contents of a `HeaderBar` as will be seen in our second demo today. For now, though, let’s concentrate on getting extra widgets in there. We'll concern ourselves with rearranging stuff later.

## HeaderBar Button

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/001_window/window_001_17.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/001_window/window_001_17_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_17_headerbar_extra_button.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

If we build on what we had last time, we can just add a statement to the preamble of our `MyHeaderBar` class:

```d
HeaderBarButton headerBarButton;
```

And that gets instantiated and stuffed into our UI with these two statements in our constructor:

```d
headerBarButton = new HeaderBarButton();
packStart(headerBarButton);
```

Take note that unlike `Box.packStart()` which takes four arguments, `HeaderBar.packStart()` only takes one, a pointer to the extra `Widget` you’re stuffing in there.

There’s only one thing left to look at for this demo and that’s the `HeaderBarButton` class:

```d
class HeaderBarButton : Button
{
	string labelText = "Click Me";
	
	this()
	{
		super(labelText);
		
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button b)
	{
		writeln("HeaderBar extra button clicked");
		
	} // onClicked()
	
} // class HeaderBarButton
```

And as you can see, it’s just an ordinary `Button` dressed up for a night at the `HeaderBar`.

That gives us a `Button` to the left of the `HeaderBar`’s title and subtitle. But what if we want the `Button` to appear to the right instead?

## Buttons to the Left of Title, Buttons to the Right

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/001_window/window_001_18.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/001_window/window_001_18_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_18_headerbar_start_end_buttons.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

So, if `packStart()` will place a Button to the left of the `HeaderBar`’s title, what do you suppose `packEnd()` does?

```d
headerBarButtonRight = new HeaderBarButton(rightLabel);
packEnd(headerBarButtonRight);
```

Yup, it sticks the `Button` *after* the Title/subtitle. And there’s nothing really exciting about that, but we’ve got a whole demo dedicated to it anyway.

Oh. And like `HeaderBar.packStart()`, `HeaderBar.packEnd()` only takes one argument.

But what if we need to have our standard `Button`s move around under user control? Well, that’s covered, too... perhaps by accident, but maybe by design. Let’s have a look...

## Dynamic HeaderBar Layout

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/001_window/window_001_19.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/001_window/window_001_19_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_19_headerbar_dynamic_layout.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screen shots on a single page -->

We won’t need to change any of the preamble or constructor code for this, just add a bit of functionality to our `Button`(s) like this:

```d
class HeaderBarButton : Button
{
	string rightClose = "minimize,maximize,icon:close";
	string leftClose = "close:minimize,maximize,icon";
	HeaderBar _headerBar;
	
	this(string labelText, HeaderBar headerBar)
	{
		super(labelText);
		
		_headerBar = headerBar;
		
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button b)
	{
		writeln("HeaderBar extra button clicked");
		
		if(_headerBar.getDecorationLayout() == rightClose)
		{
			_headerBar.setDecorationLayout(leftClose);
		}
		else
		{
			_headerBar.setDecorationLayout(rightClose);
		}
		
	} // onClicked()
	
} // class HeaderBarButton
```

All we’re doing here is swapping the close, minimize, and maximize buttons from one side to the other. In the preamble, we layout the two button order strings:

```d
string rightClose = "minimize,maximize,icon:close";
string leftClose = "close:minimize,maximize,icon";
```

And then in the `onClicked()` function, we check to see which one is in use and substitute the other.

A demo like this may seem a bit silly at first glance, but the implications—when added together with `packStart()` and `packEnd()`—can open up possibilities in UI hinting. Coupled with changes in `HeaderBar` text and/or background color, these elements can help orient the user to changes in configuration or status for whatever’s going on within a `Window`.

And just to round things out, let’s take a quick look at one more thing we can do with a `HeaderBar`, something you’ve likely guessed can be done, but let’s look at the proof...

## An Image in a HeaderBar

<!-- 6, 7 -->
<!-- third occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img6" src="/images/screenshots/001_window/window_001_20.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal6" class="modal">																<!-- modal# -->
				<span class="close6">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img66">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal6");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img6");														// img#
			var modalImg = document.getElementById("img66");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close6")[0];										// close#
			
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
			<img id="img7" src="/images/screenshots/001_window/window_001_20_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal7" class="modal">																			<!-- modal# -->
				<span class="close7">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img77">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal7");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img7");																	// img#
			var modalImg = document.getElementById("img77");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close7")[0];													// close#
			
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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_20_headerbar_image.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for fourth (4th) occurrence of application and terminal screen shots on a single page -->

As mentioned earlier in this series, we aren’t restricted to using Button widgets in a `HeaderBar`, so why not an `Image`? It’s simpler than placing an image in a `DrawingArea`, in fact. All we have to do is add these lines to the constructor:

```d
headerBarImage = new Image(imageName);
packStart(headerBarImage);
```

And don’t forget to do this at the top of your code:

```d
import gtk.Image;
```

And add this to the HeaderBar preamble:

```d
Image headerBarImage;
```

## Conclusion

And that should give you an idea of how flexible the `HeaderBar` can be. When we come back to this topic, we’ll look at how they work with a `Dialog`. Until then, happy coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/01/07/0097-headerbar.html">Previous: HeaderBar</a>
	</div>
	<div style="float: right;">
		<a href="/2020/01/21/0099-sfx-button-interactions-i-text-labels.html">Next: SFX - Changing Button Text</a>
	</div>
</div>
