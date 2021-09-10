---
title: "0113: GTK GIO Application IDs and Signals"
layout: post
topic: button
description: This GTK Tutorial covers a D-specific implementation of Scale Widget controlling placement of a graphic element.
author: Ron Tarrant

---

# 0113: Application IDs and Signals

Continuing from last time when we started looking at GTK/GIO Applications, today let's look at...

## Application IDs

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/020_app/app_020_02_barebones_with_id.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/020_app/app_020_02_barebones_with_id_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_02_barebones_with_id.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Every `Application` has to have an `ID`, even if—as in our example from last time—it’s `null`. The intention is that each `Application` can be singled out for inter-process communication, even across the vastness of the Internet. This may seem like overkill, but if you think about it, how else can we guarantee finding a single remote application among the (possibly) millions that may be accessible online? This also serves as a first line of defence against hacking that can be built into every `Application` we write. It's not a great defence, but while hackers are guessing the ID, they aren't messing with our application.   

You may wonder how we can be sure that the `ID` we give our `Application` hasn’t been used before by every Thomas, Richard, and Harold on the planet. The solution is rather ingenious and so simple, I wish I'd thought of it...

The `ID` starts with a reverse-order URL. And if you don’t own a URL you can use an email account or the full URL of any online code repository you have read/write privileges for.

Then, we tack on a unique string identifier. And as long as we keep track of which identifiers we give to which application, there should never be a problem.

Here are the choices I had when naming the example used here, each based on a URL I have access to and the unique string is just the name of the code file:

- **blog**: com.gtkdcoding.app.app_020_02_barebones_with_id,
- **email**: com.gmail.gtkdcoding.app.app_020_02_barebones_with_id,
- **repository**: com.github.rontarrant.gtkdcoding.app.app_020_02_barebones_with_id

You’ll note that I added an extra layer (.app) between the URL and the file name. It’s not strictly necessary, but it’s part of the site organization, so I threw it in there. However, the directory where you'll find this code file is named `020_app`, not `app`. Why didn't I use the full directory name?

Because we have...

### Other Naming Conventions We Need to Follow

Interestingly enough, these conventions are similar to those used to name variables (as if we didn't see *that* coming):

- the `ID` must be made up of at least two elements separated by a dot (element.element),
- elements can be made up of:
	- alpha-numeric characters (a-z/A-Z, 0-9),
	- underscores (_), and
	- hyphens (-),
- the first character in an `ID` cannot be:
	- a digit (0-9), or
	- a dot (.),
- the first character in an *element* cannot be a digit (0-9),
- putting two dots together (..) is not allowed,
- the `ID` can’t start or end with a dot (.), and
- the full length of the ID can’t be more than 255 characters.

So, naming the ID looks like this:

```d
string id = "com.gtkdcoding.app.app_020_02_barebones_with_id"; // rules
```

As you can see, this ends up looking like a *D*-language import statement. We can simply use the file or project name and substitute a dot for a directory separator. And when it's time to update the project to a new version, just toss in a version number... as long as it's done in such a way that we don't violate any of the naming conventions.

All this takes place in our derived class, `MyApplication` (derived from `GtkApplication` which, if you remember, is an alias of `gtk.Application` and is, in turn, derived from `gio.Application`).

Now, let’s move on to...

## Application Signals

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/020_app/app_020_03_adding_signals.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/020_app/app_020_03_adding_signals_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_03_adding_signals.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->


The two most obvious signals that every `Application` might have are:

- `startup`, and
- `shutdown`.

So much might be done to prepare for running an `Application` or to clean up before exiting. A few things that come to mind are:

- loading and saving a configuration file,
- on shutdown, check for unsaved changes and see if the user wants to save before exiting, or
- on start-up, pop open a splash screen.

Hooking them up is no biggie. We just do the same thing we always do:

```d
addOnStartup(&onStartup);
addOnShutdown(&onShutdown);
```

And the callback functions, in their simplest form, might look like:

```d
void onStartup(GioApplication app) // non-advanced syntax
{
	writeln("triggered onStartup...");
	writeln("\tThis is where you'd read a config file.");
		
} // onStartup()


void onShutdown(GioApplication app) // non-advanced syntax
{
	writeln("triggered onShutdown...");
	writeln("\tThis is where you'd write a config file.");

} // onShutdown()
```

## Conclusion

And that wraps it up for another day. Next time, we'll tackle *GIO*/*GTK* flags. Until then—to paraphrase Les Nessman of *WKRP*, may the good code be yours.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2021/09/03/0112-gtk-gio-application-barebones.html">Previous: GTK GIO Applications - Introduction</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2021/09/17/0114-gtk-gio-app-flags-and-cl.html">Next: GTK/GIO Application III - Flags & the Command Line</a>
	</div>
-->
</div>
