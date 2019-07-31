---
title: "0025: Creating and Using a LinkButton"
topic: button
layout: post
description: How to use a GTK LinkButton, with and without a visible URL - a D language tutorial.
author: Ron Tarrant

---

# 0025 - Creating and Using a LinkButton

Today’s buttons are simple, a button to click to follow a link and another one with a pretty face and a link. So, what’s the difference?

## A LinkButton

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/011_odd/odd_011_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/011_odd/odd_011_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/002_button/button_002_10_linkbutton.d" target="_blank">here</a>.
	</div>
</div>

At its simplest, a `LinkButton` has a link that takes the user to a website. And on its face, the `LinkButton` shows the URL for that site.

And because this example is so simple, I’ve dumped it all into the `TestRigWindow` object:

{% highlight d %}
	class TestRigWindow : MainWindow
	{
		string title = "LinkButton without Text";
		string link = "http://gtkDcoding.com";
		string message = "The text entry box holds: ";
		LinkButton linkButton;
		
		this()
		{
			super(title);
			addOnDestroy(&endProgram);
			
			linkButton = new LinkButton(link);
			add(linkButton);
			
			showAll();
			
		} // this()
		
		
		void endProgram(Widget w)
		{
			writeln(message, linkButton.getUri());
			
		} // endProgram()
		
	} // class TestRigWindow
{% endhighlight %}

Nothing to it, really, define the link, instantiate the `LinkButton` object, add it, and the rest is taken care of for you. You won’t have to figure out anything else because it hooks into the OS to grab the default browser and passes it the URL.

But what if you don’t want the URL to show on the button? Perhaps your URL is something long and ugly or you want to take the user to a specific page that would end up looking like:

	http://gtkdcoding.com/2019/01/11/0000-introduction-to-gtkDcoding.html

That ain’t gonna look so pretty on a button, so you might instead consider…

## A LinkButton with a Pretty Face

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/011_odd/odd_011_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/011_odd/odd_011_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/002_button/button_002_11_linkbutton_labeled.d" target="_blank">here</a>.
	</div>
</div>

Not a lot changes:

{% highlight d %}
	class TestRigWindow : MainWindow
	{
		string title = "LinkButton with Text";
		string link = "http://gtkdcoding.com/2019/01/11/0000-introduction-to-gtkDcoding.html";
		string linkText = "GTK D-coding";
		string message = "The text entry box holds: ";
		LinkButton linkButton;
		
		this()
		{
			super(title);
			addOnDestroy(&endProgram);
			
			linkButton = new LinkButton(link, linkText);
			add(linkButton);
			
			showAll();
	
		} // this()
		
		
		void endProgram(Widget w)
		{
			writeln(message, linkButton.getUri());
			
		} // endProgram()
		
	} // class TestRigWindow
{% endhighlight %}

It’s all in the arguments sent to `LinkButton`’s constructor:

- Send it one argument, a URL, and it’s happy to slap that onto the face of the button.
- Send it two arguments, a URL and a nicely-formatted string, and that button ends up all cute and cuddly.

On the downside, the `LinkButton` spits out a warning to the *Command Prompt* window every time you use it. My research has turned up no reasonable explanation and it’s been going on since the release of *GTK 3.0*. The good news is that the message is of no consequence and it seems safe to ignore.

And that’s it for this time, a short post for a short day. Come on back sometime and we'll do this again.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/05/0024-switch-and-light-switch.html">Previous: Switch</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/12/0026-menu-basics.html">Next: Menu Basics</a>
	</div>
</div>
