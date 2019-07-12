---
title: "0037: Dialogs III - Opening Multiple Files"
topic: dialog
layout: post
description: How to retrieve multiple file names using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

## 0037 – Dialogs III - Opening Multiple Files

This is a companion to the previous post, [File Dialog - Open a Single File](/2019/05/17/0036-file-open-dialogs.html). If you have yet to read the other post, it may clarify things that won't make sense otherwise. 

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_03_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_03_file_open_multiple.d" target="_blank">here</a>.
	</div>
</div>

Whereas last time we used a dialog to open a single file, this time we’ll do the multi-select version. But again, this isn’t a production-ready example, so we’ll just be spitting the file names out to the terminal like last time.

### Imports

On top of the extra imports we did with the version for opening a single file, we’ve got two more this time:

{% highlight d %}
	import sdt.conv;
	import glib.ListSG;
{% endhighlight %}

You’ll see when we get there, but for now just know that these are needed for converting the singly-linked list of `ListSG` nodes to an array of strings… which will end up being our list of file names.

Now, let’s skip to where the differences are between this example and the last…

### The Callback

Nothing changes until after we define the dialog, then we have this line:

{% highlight d %}
	dialog.setSelectMultiple(true);
{% endhighlight %}

It’s sandwiched between the line that defines the dialog and the one that opens it. *And* it's is the line that tells the dialog to expect multiple-selection of file names while it’s open.

The next difference is inside the `if` statement block:

{% highlight d %}
	if(response == ResponseType.OK)
	{
		ListSG list = dialog.getFilenames();
			
		if(list.next is null)
		{
			openFile(to!string(cast(char*)list.data));
		}
		else
		{
			fileList = list.toArray!string();
				
			foreach(string filename; fileList)
			{
				openFile(filename);
			}
		}
	}
{% endhighlight %}

The `if` still does the same test. Do we have an `OK` response? But from there, it veers off to call a different dialog function with a different return value:

{% highlight d %}
	ListSG list = dialog.getFilenames();
{% endhighlight %}

The list is the singly-linked list we talked about a moment ago.

The next step is to deal with the possibility that the user only selected one file even though multi-select is available:

{% highlight d %}
	if(list.next is null)
{% endhighlight %}

If only one file name is selected and we don't do this test, things could get ugly when we ask `list.toArray()` to chew on our list of files.

Carrying on, if `list.next` isn’t `null`, then we have a true list which we process in the `else` part of the block:

{% highlight d %}
	fileList = list.toArray!string();
{% endhighlight %}

This statement is why we imported `std.conv`. It converts the `ListSG`’s `char*` to an array of strings, each element of which will be a full-path file name. (Compile and run the example, then watch terminal output to see this in action.) 

Once we have the array of file names (`fileList`) the rest is easy. A `foreach()` steps through the list and each one is handed to `openFile()` for processing.

And as usual, once we’re done with the dialog, we blow it up and move on.

Next time, we'll tackle a `Dialog` for saving files. Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/17/0036-file-open-dialogs.html">Previous: Open File Dialog</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/24/0038-file-save-dialog.html">Next: Save File Dialog</a>
	</div>
</div>
