---
title: "0115: GTK GIO Application Flags - Opening Files"
layout: post
topic: app
description: How GTK/GIO flags that allow opening files from the command line.
author: Ron Tarrant
---
# 0115 – GTK/GIO Open Flag

The next `ApplicationFlag`, `HANDLES_OPEN`, gives us a mechanism for opening files from the command line. Such things are relatively straightforward anyway, but perhaps we’ll find an advantage or two by using what *GIO* has to offer. Let’s dig in and find out, shall we?

We’ll do this in two steps. Firstly, we’ll look at the basics—grabbing the file names from the command line—and secondly, we’ll add just enough code to open each file in its own window.

## Importing the GIO File Abstraction

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/020_app/app_020_05_open_flag.png" alt="Current example output">		<!-- img# -->
			
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
			Demonstration where multiple file names are given on the command line.
			</figcaption>
		</figure>
	</div>

	<div class="frame-terminal">
		<figure class="right">
			<img id="img1" src="/images/screenshots/020_app/app_020_05_open_flag_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
				Top: no file names given on the command line. Bottom: two file names given.
			</figcaption>
		</figure>
	</div>

	<div class="frame-footer">																								<!-- ------------- filename (below) --------- -->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_05_open_flag.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The *GIO* construct that helps us handle files is called `gio.FileIF`. It’s not really an interface, but a sort-of wrapper standing in for a *C*-language abstraction—`GFile`—which represents the vital statistics of a file. For our purposes, we don’t need to know a lot about this to use it, so we’ll skip the details. For now, just know we need this import statement to make this stuff work:

```d
import gio.FileIF;
```

## MyApplication Changes
### Raise the Flag

As we’ve done before, we declare the appropriate flag in the `MyApplication` class. And while we’re at it, let’s change the application `id` as well so it matches our current example:

```d
ApplicationFlags flags = ApplicationFlags.HANDLES_OPEN;
string id = "com.gtkdcoding.app.app_020_05_open_flag";
```

### Hook up the Callback

The initializer method needs a little something, too:

```d
addOnOpen(&onOpen);
```

Basically, just hook up the signal. Note that we don’t need the `HANDLES_COMMAND_LINE` flag to make this work, even though that might seem like the case (it did to me at first).

### Messing with the activate() Method

This is a pretty small change from our last demo. There, we passed in an array containing the dimensions of the window we were about to open. This time, we forego that in favour of passing in whatever arguments the user types on the command line. For purposes of demonstration, we hope these arguments will be valid file names so we don’t have to write `try`/`catch` statements. But feel free to add those if you want.

Anyway, `activate()` now looks like this:

```d
void activate(string filename)
{
	writeln("activate called");
	AppWindow appWindow = new AppWindow(this, filename);

} // activate()
```

We’ve dispensed with the `dimensions` argument—an array of integers—and replaced it with `filename`—a string—which is the name of the file we’ll be opening in a window instance.

This method is called once for each file name provided on the command line.

### Changes to the onActivate() Method

Here’s another small change:

```d
void onActivate(GioApplication app) // non-advanced syntax
{
	AppWindow appWindow = new AppWindow(this, null);
	writeln("triggered onActivate...");
	writeln("\tApplication ID: ", getApplicationId());
	
} // onActivate()
```

The reason we have another instantiation of `AppWindow` here is to deal with the possibility that the user gives no arguments. Note that—depending on circumstances—either `activate()` or `onActivate()` is called, but not both. Here’s the low-down:

- `activate()` is called once for each file name passed in, whether those file names are valid or not, and
- `onActivate()` is called if no arguments whatsoever are given.

*Note: If multiple non-valid file names are given, `activate()` is still called multiple times and multiple windows are opened. A little error checking will not go amiss here, but I’ll leave that to your imagination and skill.*

### A New Callback – onOpen()

It’s relatively trivial, so here’s the entire method:

```d
void onOpen(FileIF[] files, string hint, GioApplication app)
{
	writeln("triggered onOpen...");
		
	foreach(file; files)
	{
		string name = file.getPath();
		writeln("file name: ", name);
		activate(name);
	}
		
} // onOpen()
```

This simple method steps through an array of `FileIF` objects, grabs the full path of each, then calls `activate()` for each one… as mentioned above.

The second argument—`string hint`—allows for different modes when opening a file (edit, view, etc.) and it’s suggested that unless we have a specific need for this type of thing, we should just leave it be. So we will.

Let’s move on to the next step where we actually load files into these windows…

## Loading Text Files

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/020_app/app_020_06_open_and_load.png" alt="Current example output">		<!-- img# -->
			
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
			Two file names given on the command line.
			</figcaption>
		</figure>
	</div>

	<div class="frame-terminal">
		<figure class="right">
			<img id="img3" src="/images/screenshots/020_app/app_020_06_open_and_load_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
				Two file names given on the command line. (click for enlarged view)
			</figcaption>
		</figure>
	</div>

	<div class="frame-footer">																							<!--------- filename (below) ------------>
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_06_open_and_load.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

We’ve seen the *GTK* code to accomplish this before—the bits and bobs that slap a `TextView` into a `Window`—so that part, I’ll skip. If you want a refresher, take a quick look at [blog post #0069](https://gtkdcoding.com/2019/09/10/0069-textview-and-textbuffer.html).

The one thing we haven’t covered is the *D* code that opens and reads the file. Here’s what that looks like:

```d
if(filename)
{
	file = File(filename, "r");
			
	while (!file.eof())
	{
		string line = file.readln();
		content ~= line;
	}
			
	textBuffer.setText(content);
	file.close();		
}
```
 
Pretty straightforward. We start by making sure the `filename` variable contains a string, then dip into *D*’s `stdio` library to open the file in read mode.

The `while` loop reads the file one line at a time and concatenates it to the `content` variable.

Once that’s done, `content` is dumped into the `TextBuffer` and we close the file.

## Conclusion

So, now we’ve read file names from the command line and opened them, each in their own window. Next time, we’ll look at command line switches.

‘Til then, let’s all do our best to stay sane. These trying times are a challenge—like setting out to design a garbage collector on your first day with a new language while simultaneously trying to work out the plot of *Lost*—but we can survive and flourish if we all keep our heads… and our distance.

Be safe.

