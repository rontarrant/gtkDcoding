---
title: "0036: Dialogs II - Opening a Single File"
topic: dialog
layout: post
description: How to retrieve a single filename using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

# 0036 – Dialogs II - Opening a Single File

Today we’re working with a more useful dialog, one that opens a file.

But we’re concentrating on just the surface stuff here. Latter in this series, we’ll get down to how to do the actual file loading (which is really a *D* thing rather than a *GtkD* thing). For now, we’ll just be grabbing a file name and echoing it to the terminal to verify that we’re actually selecting a file to work with.

## The Open File Dialog

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_02_file_open_single.d" target="_blank">here</a>.
	</div>
</div>

Onward to the particulars…

## Imports

We need to add something to our list of imports:

{% highlight d %}
	import gtk.FileChooseDialog;
{% endhighlight %}

That’ll get us access to a pre-rolled *GTK* file dialog. It’s won’t be specific to the OS you’re running (with the possible exception of *Linux*) but it'll work and that's what counts, so let’s carry on.

Since we went over how the window is handed down in [the previous post](http://gtkdcoding.com/2019/05/14/0035-help-about-dialog.html), there’s no need to cover it again. So, let’s just get to the business of the day…

## The FileOpenItem

We’ll look at this in chunks. Here’s the first chunk:

{% highlight d %}
	class FileOpenItem : MenuItem
	{
		string itemLabel = "Open";
		FileChooserDialog fileChooserDialog;
		Window parentWindow;
{% endhighlight %}

Before the constructor, we define two new variables:

- the dialog, and
- the window we’re going modal on.

{% highlight d %}
		this(Window extParentWindow)
		{
			super(itemLabel);
			addOnActivate(&doSomething);
			parentWindow = extParentWindow;
			
		} // this()
{% endhighlight %}

Then in the constructor, we:

- pass in the top-level window,
- set up the `MenuItem` by calling the super-class and connecting the signal (`onActivate`), and
- assign the parent window to a locally-accessible variable.

## The Callback

Now let’s look at this `MenuItem`’s workhorse function:

{% highlight d %}
	void doSomething(MenuItem mi)
	{
		int response;
		string filename;
		FileChooserAction action = FileChooserAction.OPEN;
		
		FileChooserDialog dialog = new FileChooserDialog("Open a File", parentWindow, action, null, null);
		response = dialog.run();
		
		if(response == ResponseType.OK)
		{
			filename = dialog.getFilename();
			openFile(filename);
		}
		else
		{
			writeln("cancelled.");
		}

		dialog.destroy();
		
	} // doSomething()
{% endhighlight %}

We set up a few variables before we get going:

- `response` – to track the dialog’s return value,
- `filename` – that which we’re going to all this trouble for, and
- `action` – the flag that decides if this file dialog is an 'innie' or an 'outie' (ie. `OPEN` dialog or `SAVE` dialog).

Next, we create the dialog with a call to its constructor. The arguments are:

- `“Open a File”` - a string to drop into the title area,
- `parentWindow` – discussed above, the window we’ll be going modal on,
- `action` – what the dialog is intended for (in this case, opening a file),
- `null` – this could also be an array of string labels if we’d prefer custom buttons, and
- `null` – an array of `ResponseType` (found in **gtk.c.types.d**) responses for the custom buttons.

*Note: If you decide to go with your own custom buttons, make sure the two arrays (label text and `ResponseType`) are the same length.*

Now we get to actually opening the dialog. As with the `AboutDialog`, once the dialog is open, we do nothing until it closes and sends back a response.

## Checking the Response

First, we make sure the user didn’t cancel by checking against `ResponseType.OK`. Had it been cancelled, response would be `ResponseType.CANCEL`, but we only need to check for that if we have something special to do in that situation.

So, if the user selected a file, we grab it using `dialog.getFilename()` and pass it along to the `openFile()` function.

{% highlight d %}
		void openFile(string filename)
		{
			writeln("file to open: ", filename);
			
		} // openFile()
		
	} // class FileOpenItem
{% endhighlight %}

Had this been a production-ready example, we’d do something besides spit out the filename to the terminal.

## Conclusion

That’s it for today. Next time, we’ll tackle opening multiple files. Until then…

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/14/0035-help-about-dialog.html">Previous: About Dialog</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/21/0037-file-open-multiple.html">Next: Dialog - Open Multiple Filesas</a>
	</div>
</div>
