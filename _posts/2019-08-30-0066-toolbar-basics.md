---
title: "0066: How to Tool Up a Toolbar"
layout: post
topic: bar
tag: bar
description: GTK Tutorial on building a Toolbar.
author: Ron Tarrant

---

# 0066: How to Tool Up a Toolbar

The old way of doing a *GTK* `Toolbar` is falling out of favour, mostly because the `StockID`s (such as `COPY`, `CUT`, `PASTE`, etc.) once used to put icons in a `ToolButton` are all deprecated.

So, that leaves us with two choices, either the `IconTheme` route—which looks daunting—or rolling our own... sort of. Because everything we need to know to use the second option has been covered already, I’ve chosen to go that route.

But, there’s really no bad news here. We still get a usable `Toolbar` that looks like a `Toolbar` and we also get to use whatever images suit our purposes.

So without further ado, here’s...

## The Basics of Building a Toolbar

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/bar_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/bar_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/bar_02_toolbar_basic.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Before we start, I'll mention that a `ToolButton` is a container that holds a standard `Button` and a standard `Label`.

To populate a `Toolbar`:

- build one or more `ToolButton`s,
- stuff the `ToolButton`(s) with standard `Button`s and text strings to be passed along to the `Label`(s), and
- `insert()` the `ToolButton` into the `Toolbar`.

And that’s all there is to it.

### A Standard Button

Would look like this:

```d
class PasteButton : Button
{
	Image image;
	string imageFilename = "images/edit-paste-symbolic.symbolic.png";
		
	this()
	{
		super();
		
		image = new Image(imageFilename);
		add(image);
		
	} // this()
	
} // class PasteButton
```

And it gets stuffed into...

### The ToolButton

Which looks like this:

```d
class PasteToolButton : ToolButton
{
	PasteButton pasteButton;
	string actionMessage = "Paste operation.";

	this()
	{
		pasteButton = new PasteButton();
		super(pasteButton, "Paste");		
		addOnClicked(&doSomething);
		
	} // this()


	void doSomething(ToolButton b)
	{
		writeln(actionMessage);
		
	} // doSomething()

} // class PasteToolButton
```

Notice that we hook up the signal to the `ToolButton` and *not* the imbedded `Button`. The `ToolButton` doesn’t inherit the `getChild()` function, so to find out if the embedded Button is reacting to a signal would take extraneous code. Also, hooking up the `ToolButton`'s signal means a click on the `Label` is as good as a click on the embedded `Button`.

*Note: There are two other overloads of the `ToolButton` constructor, but as mentioned earlier, because the `StockID` enum has been deprecated, they won’t do much to future-proof applications. And since* GTK 4.0 *might be just around the corner, we’re better off leaving them alone.*

### The Toolbar Class

Here’s what it looks like:

```d
class MyToolbar : Toolbar
{
	ToolButton cutToolButton, copyToolButton, pasteToolButton;

	this()
	{
		super();
		setStyle(ToolbarStyle.BOTH);

		cutToolButton = new CutToolButton();
		insert(cutToolButton);

		copyToolButton = new CopyToolButton();
		insert(copyToolButton);
		
		pasteToolButton = new PasteToolButton();
		insert(pasteToolButton);
		
	} // this()
	
} // class MyToolbar
```

Pretty straightforward... all we do is:

- decide whether we want icons, text, or both and call `setStyle()` (options are, oddly enough: `ICONS`, `TEXT`, or `BOTH`),
- instantiate a bunch of `ToolButton`s, and
- `insert()` them into the `Toolbar`.

As for adding a `Toolbar` to our hierarchy of application classes, it’s no different than most other things:

```d
class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyToolbar myToolbar;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myToolbar = new MyToolbar();
		
		packStart(myToolbar, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox
```

Although, you’ll want to give the `AppBox` an `Orientation.VERTICAL` so as to keep the `Toolbar` below the `Menu` and above the working area of your application... unless you're going for a unique layout, that is.

## Conclusion

And those are the mysteries of the `Toolbar`.

Later on, we’ll look at how to hook up `ToolButton`s to the singleton `AccelGroup` we built for a `Menu` system so we have a `ToolButton`, `MenuItem` and accelerator key all calling a single callback.

And next time around, we'll look at the `Expander`.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/27/0065-mvc-x-treestore-basics.html">Previous: MVC - TreeStore Basics</a>
	</div>
	<div style="float: right;">
		<a href="/2019/09/03/0067-mvc-xii-expander.html">Next: MVC - Expander</a>
	</div>
</div>
