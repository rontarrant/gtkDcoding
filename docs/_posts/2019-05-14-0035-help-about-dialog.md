---
title: "0035: Dialogs I - The About Dialog"
topic: dialog
layout: post
description: How to use a GTK AboutDialog - a D-language tutorial.
author: Ron Tarrant

---

## 0035 – Dialogs I - The About Dialog

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_01_help_about.d" target="_blank">here</a>.
	</div>
</div>

Starting today, and for the next few weeks, we'll be looking at `Dialog` windows of various types. We'll get started with one of the simpler ones, the AboutDialog, but to make it more interesting, we'll toss in a `Pixbuf`.

Let's get going by checking out…

### The Imports

These are the ones we haven’t worked with yet:

{% highlight d %}
	import gtk.AboutDialog;
	import gdk.Pixbuf;
{% endhighlight %}

Okay… `main()` is the same and we've seen `TestRigWindow` more than 30 times, and these aren't new, either:

- `AppBox`,
- `MyMenuBar`,
- `HelpHeader` (except for the name, anyway), and
- `HelpMenu`.

And that brings us to…

### The AboutItem

We have a ton of string tied around the initialization section and maybe that's so the other stray items don't wander off:

{% highlight d %}
	string itemLabel = "About";
	string sectionName = "Them What Done Stuff";
	string[] people = ["Laurence Find", "Jerome Hayward", "Dick van Puddlesopper"];
	string[] artists = ["Alice Warhol", "Salvador Deli", "My Brother-in-law, Bill"];
	string comments = "This is a fine bit of software built for the rigors of testing dialog windows.";
	string[] documenters = ["Billy Buck Thorndyke", "Phil Gates"];
	string license = "This is a FOSS Budget build of a GNOLD project";
	string programName = "About Dialog Demo";
	string protection = "Copywrong 2019 © The Three Stool Pigeons";
	Pixbuf logoPixbuf;
	string pixbufFilename = "images/logo.png";
	Window parentWindow;
	AboutDialog aboutDialog;
{% endhighlight %}

You could probably leave most of these strings empty, especially if you don't work with a team, but I filled all these in for demonstration purposes.

But as I breezed through that list of classes that hadn’t changed, there actually was one change worth mentioning…

#### Passing Down the Window

Because the `AboutDialog` (or any other dialog) needs to know who its mommy is, we gotta give it an ersatz family tree, passing down the `Window` pointer so when the `Dialog` goes up, it can go `MODAL` if it needs to. If you take a quick look through the code, you'll see this is done very much the same way we passed along the `AccelGroup` in Blog Post #32 - [Adding Accelerator Keys to MenuItems](http://gtkdcoding.com/2019/05/03/0032-accelerator-keys.html).

*Note: if you want your `Dialog` to be `MODAL`, use `DialogFlags.MODAL` which can be found in `generated/gtkd/gtk/c/types.d`.*

### Hooking up the MenuItem

In the constructor, we do this:

{% highlight d %}
	this(Window extParentWindow)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		parentWindow = extParentWindow;
		
	} // this()
{% endhighlight %}

Like any other `MenuItem`, we instantiate and hook up the callback, but then we have one more step. We assign the local pointer to the parent Window so we can use it in the callback.

The callback is quite busy:

{% highlight d %}
	void doSomething(MenuItem mi)
	{
		int responseID;
		
		writeln("Bringing up dialog...");
		
		logoPixbuf = new Pixbuf(pixbufFilename);
		
		// Although it seems we should do all this config stuff in this()
		// it has to be done here.
		AboutDialog aboutDialog = new AboutDialog();
		aboutDialog.setAuthors(people);
		aboutDialog.setArtists(artists);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setCopyright(protection);
		aboutDialog.setArtists(artists);
		aboutDialog.setComments(comments);
		aboutDialog.setLicense(license);
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setTransientFor(parentWindow);
		
		aboutDialog.run();
		aboutDialog.destroy();
		
	} // doSomething()
{% endhighlight %}

We need a `responseID` for any dialog, even if we ignore it like we do here. As we move deeper into dialogs, we'll come back to this variable and look at it more closely.

And there's the `Pixbuf` I mentioned. Here, it's used to show off the gtkDcoding logo.
 
Then we instantiate the dialog:

	AboutDialog aboutDialog = new AboutDialog();

Fill in all the fields:

{% highlight d %}
		aboutDialog.setArtists(artists);
		aboutDialog.setAuthors(people);
		aboutDialog.setComments(comments);
		aboutDialog.setCopyright(protection);
		aboutDialog.setDocumenters(documenters);
		aboutDialog.setLicense(license);
		aboutDialog.setLicenseType(licenseType);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setLogoIconName(logoIconName);
		aboutDialog.setVersion(productVersion);
		aboutDialog.setWebsite(website);
		aboutDialog.setWebsiteLabel(websiteLabel);
		aboutDialog.setTransientFor(parentWindow);
{% endhighlight %}

*Note: There may be a bug in* GTK *that (apparently) stops the website link from working with some operating systems.* Mac *was mentioned as one that falls victim to this, but it does work with Windows (it does, however, spit out a warning). I haven't tried it with* Linux.

And finally, we open it:

{% highlight d %}
	aboutDialog.run();
{% endhighlight %}

And the last statement doesn’t get called until the dialog closes and program control comes back to this object (the `AboutMenuItem` object):

{% highlight d %}
	aboutDialog.destroy();
{% endhighlight %}

All this does is destroy everything we built. And if the `Dialog` gets opened again? The entire dialog is rebuilt from scratch.

## Conclusion

And that was a quick look at a simple `Dialog`. As we go along, things could get complicated, especially when we dig into rolling our own dialog from scratch. Now, that will be an adventure.

Until next time… bye.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/10/0034-accelgroup-singleton.html">Previous: AccelGroup Singleton</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/17/0036-file-open-dialogs.html">Next: Open File Dialog</a>
	</div>
</div>
