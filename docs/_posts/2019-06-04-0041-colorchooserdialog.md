---
title: "0041: Dialogs VII - The ColorChooserDialog"
topic: dialog
layout: post
description: Using a standard GTK ColorChooserDialog - the Dialog behind the ColorChooserButton - a D-language tutorial.
author: Ron Tarrant

---

# 0041 – Dialogs VII - The ColorChooserDialog

We’ve actually seen today’s topic widget before, but it was part-n-parcel of the `ColorButton`, so we didn’t really look at it because it was a behind-the-scenes kind of dialog. Today, though, we're gonna roll up our sleeves and see how this sucker works.

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_07_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_07_ColorChooserDialog.d" target="_blank">here</a>.
	</div>
</div>

In this example, I’ve defined a `ColorChooserButton` based on a plain vanilla `Button` which, in effect, makes this newly-derived `ColorChooserButton` equivalent to the `ColorButton` we saw in [Blog Post #23]( http://gtkdcoding.com/2019/04/02/0023-radio-and-color-buttons.html) (and [the code file for that can be found here]( https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_02_colorbutton.d), if you care to have another look at it).

## The Button that Opens the Dialog

However, there are differences, so let’s look at what we’ve got here in this new button: 

{% highlight d %}
	class ColorChooserButton : Button
	{
		private:
		string labelText = "Ask for a Color";
		
		MyColorChooserDialog colorChooserDialog;
		Window _parentWindow;
		
		public:
		this(Window parentWindow)
		{
			super(labelText);
			addOnClicked(&doSomething);
			_parentWindow = parentWindow;
			
		} // this()
		
		
		void doSomething(Button b)
		{
			colorChooserDialog = new MyColorChooserDialog(_parentWindow);
			
		} // doSomething()
	
	} // class: ColorChooserButton
{% endhighlight %}

Here—because we’re driving the boat, as it were—we have to declare our own dialog which we didn’t have to do with the `ColorButton`. And naturally, we’ve got to hook up a signal too, so that clicking on the button opens the dialog. Then there’s the whole modal rigmarole to deal with, so we have to pass a pointer to the parent window along to our dialog object…

## And Now, the Dialog

For which the code looketh thus like:

{% highlight d %}
	class MyColorChooserDialog : ColorChooserDialog
	{
		private:
		string title = "I am the Chooser";
		DialogFlags flags = GtkDialogFlags.MODAL;
		RGBA selectedColor;
	
		public:
		this(Window _parentWindow)
		{
			super(title, _parentWindow);
			addOnResponse(&doSomething);
			run(); // no response ID because this dialog ignores it
			destroy();
			
		} // this()
	
		protected:
		void doSomething(int response, Dialog d)
		{
			getRgba(selectedColor);
			writeln("New color selection: ", selectedColor);
			
		} // doSomething()
		
	} // class MyColorChooserDialog
{% endhighlight %}

As you can see, this is a derivation of the `ColorChooserDialog`, mostly because I wanted to illustrate a couple of points:

- first, I’ve used the `addOnResponse()` function to hook up the signal, same as with the `MessageDialog`, but different from the `FileChooserDialog` (for which we used: `addOnActivate()`),
- second, the *response ID* for the dialog is ignored.

Yup, this is one dialog that doesn’t care which button you click to close it. And why? Because it’s got a default color already picked out for you: white (255, 255, 255) so there’s always a color available when you call `getRbga()`, even if you don’t explicitly pick a new one.

So, what if you pick a new color, let’s say `rgb(245, 121, 0)`, a nice middle-of-the-road orange, but then next time you open the dialog, you hit the cancel button. Does the orange remain as the default pick?

Nope. It goes back to white.

## Which is Best?

You may wonder which of these methods of picking a color is best, the `ColorChooserDialog` or the `ColorButton`… It depends on the circumstances you find yourself in while designing an application:

- if you plan to have access through a menu, you’ll want to use the dialog,
- for access from menu, toolbar and button, again: dialog, but
- for accessing the dialog only from a button, the `ColorButton` will do fine.

Another thing to take into consideration is whether or not you want that default white color haunting your application. You could deal with it by using an `ObservedColor` object like we did in [the ColorButton example]( https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_02_colorbutton.d). And even if you decide to go with the `ColorChooserDialog`, an `ObservedColor` can still be nudged in the right direction so as to serve your purposes.

And that’s the `ColorChooserDialog`.

Take care and see you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/31/0040-messagedialog.html">Previous: MessageDialog</a>
	</div>
	<div style="float: right;">
		<a href="/2019/06/07/0042-custom-dialog-i.html">Next: Dialog Aesthetics</a>
	</div>
</div>
