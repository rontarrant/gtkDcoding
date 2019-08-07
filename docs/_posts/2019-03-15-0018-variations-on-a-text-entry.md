---
title: "0018: Variations on a Text Entry Widget"
topic: text
layout: post
description: How to obfuscate text in a GTK Entry widget and how to make it non-editable - a D language tutorial.
author: Ron Tarrant

---

# 0018: Variations on a Text Entry Widget

## The Simple Entry

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/006_text/text_006_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/006_text/text_006_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_01_entry.d" target="_blank">here</a>.
	</div>
</div>

Let’s move away from buttons for the moment, both mouse and GUI, and look at the `Entry` widget… yeah, the one used for gathering a small bit of text from the user.

This is pretty much the easiest widget to use and the code amounts to this:

{% highlight d %}
	entry = new Entry();
	add(entry); // depending on the container type, of course
{% endhighlight %}

And to bring the entered text into your program is dead simple:

{% highlight d %}
	entry.getText()
{% endhighlight %}

Assign it to a variable, stick it in a `writeln()` function, whatever’s your poison.

Moving right along…

## Non-editable Entry

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/006_text/text_006_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/006_text/text_006_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_02_no_edit_entry.d" target="_blank">here</a>.
	</div>
</div>

Sometimes, you may want the user to enter text, but once it’s entered, you don’t want it changed. In this example, I’ve set up a `CheckButton` to control editability:

{% highlight d %}
	class EntryBox : Box
	{
		int globalPadding = 5;
		Entry entry;
		CheckButton checkButton;
		string checkText = "Editable";
		
		this()
		{
			super(Orientation.VERTICAL, globalPadding);
			entry = new Entry();
			entry.setEditable(false);
			
			checkButton = new CheckButton(checkText);
			checkButton.addOnToggled(&entryEditable);
			checkButton.setActive(false);
					
			add(entry);
			add(checkButton);
			
		} // this()
		
		
		void entryEditable(ToggleButton button)
		{
			entry.setEditable(button.getActive());
			
			if(button.getActive() == true)
			{
				writeln(checkText);
			}
			else
			{
				writeln("Not ", checkText);
			}
			
		} // entryEditable()
	
	} // class EntryBox
{% endhighlight %}

Rather than sub-classing the `Entry` and `CheckButton`, I used a sub-class of `Box` as a way to track the data and hand it around as needed. In effect, the `Box` acts as a parent handing out the goodies.

Note that both the `Entry` and `CheckButton` states are set to `false` which means if you compile and run this example, you won’t be able to type into the `Entry` until you check the `CheckButton`.

## Obfuscation

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/006_text/text_006_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/006_text/text_006_03_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_03_obfuscated_entry.d" target="_blank">here</a>.
	</div>
</div>

Now let’s think about what else text `Entry` widgets are used for. One thing that comes to mind is collecting login information. In our third example, we’ll mimic a login with a `Username` field left in the clear (readable, in other words) and an obscured `Password` field. The `LoginBox` class serves as the parent handing out candy, so we need an extra `Entry` widget with `Visibility` set to `false`, which means our constructor now looks like this:

{% highlight d %}
	this()
	{
		super(Orientation.VERTICAL, globalPadding);

		usernameEntry = new Entry();
		passwordEntry = new Entry();
		passwordEntry.setVisibility(false);
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&passwordVisibility);
		checkButton.setActive(false);
		
		add(usernameEntry);
		add(passwordEntry);
		add(checkButton);
		
	} // this()
{% endhighlight %}

We set `Visibility` to `false` for the `Password` `Entry` and then in the callback function `passwordVisibility()`, we make allowances for finding either `true` or `false`:

{% highlight d %}
	void passwordVisibility(ToggleButton button)
	{
		string messageEnd;
		
		bool answer = button.getActive();
		
		if(button.getActive() == true)
		{
			messageEnd = " I can shoulder-surf your password.";
		}
		else
		{
			messageEnd = " I canNOT shoulder-surf your password.";
		}
		
		passwordEntry.setVisibility(button.getActive());
		writeln("With ", button.getLabel(), " set to ", button.getActive(), messageEnd);
		
	} // passwordVisibility()
{% endhighlight %}

And just before the callback finishes up, we cobble together a message for the user about computer security. I could tell you what the messages say, but I think it’ll be more educational if you compile the code for the obfuscated Entry example and run it yourself.

Next time, we’ll continue with two more variations on the `Entry` widget. Until then, happy D-coding and may the `Widgets` find room in your top pocket.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/12/0017-change-pointer.html">Previous: Mouse Pointer</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/19/0019-disappearing-text-entry.html">Next: Disappearing Text Entry</a>
	</div>
</div>
