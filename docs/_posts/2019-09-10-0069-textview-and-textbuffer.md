---
title: "0069: TextView and TextBuffer"
layout: post
topic: text
description: GTK Tutorial covering the basics of using a TextView widget and it's companion, the TextBuffer.
author: Ron Tarrant

---

# 0069: TextView and TextBuffer

These two widgets, working together, give us the basis for text/code editors, word processors, and other DTP software. The `TextView` not only shows us what’s contained in the `TextBuffer`, it gives us access so we can edit, append, etc.

## A Simple Text Editor

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/006_text/text_006_08.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/006_text/text_006_08_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_08_textview.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

To get the `TextView` into a `Window` in any kind of useful way also means using a `ScrolledWindow` as an intermediary container. After all, there’s no point in having hundreds of lines of text if you only have visual access to the first dozen. (There’s nothing like typing blind to keep you both focused and stressed.)

So, we stuff a `ScrolledWindow` into our usual `AppBox`, and stuff the `TextView` into the `ScrolledWindow`… like this:

```d
class AppBox : Box
{
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	ScrolledTextWindow scrolledTextWindow;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		scrolledTextWindow = new ScrolledTextWindow();
		
		packStart(scrolledTextWindow, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class AppBox


class ScrolledTextWindow : ScrolledWindow
{
	MyTextView myTextView;
	
	this()
	{
		super();
		
		myTextView = new MyTextView();
		add(myTextView);
		
	} // this()
	
} // class ScrolledTextWindow
```

### TextBuffer

We don’t have to instantiate the `TextBuffer` because the `TextView` already has one associated with it when it’s instantiated. But, there is some flexibility here. We could end up with this association between a `TextView` and a `TextBuffer` in a few different ways:

- instantiate a `TextView` and grab a pointer to its `TextBuffer` (as we're doing in this example),
- instantiate the `TextBuffer` first and pass it to the `TextView`’s overloaded constructor—which doesn’t seem all that useful to me unless you…
- instantiate one `TextView` and pass its `TextBuffer` along to the constructors for one or more other `TextView`s so they can share.

But in this example, we’ll do it the simplest way:

```d
class MyTextView : TextView
{
	TextBuffer textBuffer;
	string content = "Now is the English of our discontent.";
	
	this()
	{
		super();
		textBuffer = getBuffer();
		textBuffer.setText(content);

	} // this()

} // class MyTextView
```

Within the `MyTextView` constructor, a quick call to `getBuffer()` gives us access and from there, we give it some content with `setText()`.

But for thoroughness sake, let’s also look at a shared `TextBuffer`…

## TextViews with a Shared TextBuffer

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/006_text/text_006_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/006_text/text_006_09_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_09_shared_textbuffer.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

Now, this gets a bit more complex. At some point in the hierarchy, we’ve got to establish a pointer to the first `TextView`'s `TextBuffer` and pass it along to the others. I decided to do this at the `AppBox` level which makes the most sense to me:

```d
class AppBox : Box
{
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	ScrolledTextWindow scrolledTextWindow;
	TextView masterTextView;
	DependentTextView dependentTextView;
	TextBuffer sharedTextBuffer;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		scrolledTextWindow = new ScrolledTextWindow();
		packStart(scrolledTextWindow, expand, fill, localPadding); // TOP justify
		
		// grab the TextBuffer pointer
		masterTextView = cast(TextView)scrolledTextWindow.getChild();
		sharedTextBuffer = masterTextView.getBuffer();
		dependentTextView = new DependentTextView(sharedTextBuffer);
		packStart(dependentTextView, expand, fill, localPadding);
		
	} // this()

} // class AppBox
```

Grabbing a pointer to the first `TextView`'s `TextBuffer` proves to be a two-step operation because the result of `getChild()` has to be `cast()` as a `TextView`. If not, the result is a generic `Widget` which doesn't give us access to the `TextView`'s `getBuffer()` function.

And to complete this multi-association, the `DependentTextView` class looks like this:

```d
class DependentTextView : TextView
{
	this(TextBuffer sharedTextBuffer)
	{
		super(sharedTextBuffer);
		
	} // this()
	
} // class DependentTextView
```

At this level, things are dead simple. The constructor takes the `TextBuffer` pointer as an argument and passes it along to the super-constructor.

If you type, copy, cut, or paste in one `TextView`, your actions are mirrored in the other... I'm sure there are uses for this type of thing, otherwise, why have this functionality, right?

## Conclusion

And that’s the basics of the `TextView` widget and its associated `TextBuffer`. Turning them into something more useful, such as a full-blown text editor, we’ll leave for another time.

Happy coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/09/06/0068-multi-level-treestore.html">Previous: Multi-level TreeStore</a>
	</div>
	<div style="float: right;">
		<a href="/2019/09/13/0070-statusbar.html">Next: Statusbar Basics</a>
	</div>
</div>
