---
title: "0084: Notebook VIII – Child Widgets"
layout: post
topic: container
tag: container
description: This GTK Tutorial covers accessing child widgets in a Notebook.
author: Ron Tarrant

---

# 0084: Notebook VIII – Child Widgets

Accessing any child widgets we've stuffed into `Notebook` pages—for loading or saving a document, for instance... or changing/updating the tab label—takes a bit of prep that you might not expect, but by relying on the `Notebook`’s in-built tab managing system, it’s relatively straightforward.

## Accessing the Widget in the Page

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_19.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_19_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/014_container/container_19_notebook_child_widgets.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Setting the text in a `TextView` is something we’ve seen before in [the first Notebook demo](https://github.com/rontarrant/gtkd_demos/blob/master/014_container/container_10_notebook_basic.d) and—cherry picking statements from the preamble and constructor—goes something like this:

```d
TextBuffer textBuffer;
string content = "Now is the English of our discontent.";

textBuffer = getBuffer();
textBuffer.setText(content);
```

Once everything’s prepped, a call to `setText()` does it. But what about the other way around, accessing the content of a specific `Notebook` page for the purposes of saving it?

## Retrieval of Page Content

No matter what type of `Widget` we stuffed into our `Notebook` page, the process is the same:

- ask the `Notebook` for the current page with a call to `getCurrentPage()`, and
- get a pointer to that page's child `Widget` using `getNthPage()`.

Note that we have to cast the result of `getNthPage()` because `Notebook` doesn't keep track of which type of `Widget` we stuffed in there. So if we used something more elaborate than a single `TextView` widget... say a `Grid` with five `Entry`s... and we wanted to access them, we'd have to get a pointer to the `Grid` and then access the `Entry`s using the `Grid`'s `getChildren()` function.

But in our current example, once we've got a pointer to the `TextView`, we get the text by:

- grabbing a pointer to the `TextBuffer` with `TextView.getBuffer()`, and
- yanking out the text with `TextBuffer.getText()`.

And once you’ve got that, saving the text is a matter of passing it along to an appropriate function.

### The PageInfoButton

But for this demo, we won’t go into saving. Instead, we'll just prove to ourselves that we've got access to everything by adding another `Button` to our interface and hooking up a callback that echoes all pertinent information to the command prompt window. The `PageInfoButton` class, complete with callback, looks like this:

```d
class PageInfoButton : Button
{
	string _buttonLabel = "Page Info";

	MyNotebook _myNotebook;

	this(MyNotebook myNotebook)
	{
		super(_buttonLabel);
		_myNotebook = myNotebook;
		
		addOnClicked(&onClicked);
				
	} // this()
	
	
	void onClicked(Button button)
	{
		int currentPage = _myNotebook.getCurrentPage();
		TabTextView tabTextView = cast(TabTextView)_myNotebook.getNthPage(currentPage);
		Label tabLabel = cast(Label)_myNotebook.getTabLabel(tabTextView);
		
		writeln("currentPage position in the Notebook tabs array:", currentPage);
		writeln("tabLabel: ", tabLabel.getText());
		writeln("tabTextView contents: ", tabTextView.getBuffer().getText()); 
		
	} // onClicked()
	
} // class PageInfoButton
```

And in the `onClicked()` callback, you can see the steps outlined in the previous section. For completeness sake, we also:

- grab a pointer to the tab’s label, and because we know it to be a `Label` `Widget` (that's with an uppercase ‘L’) we cast it as such, and
- from there, we can use `Label.getText()` to retrieve the text visible in the tab.

So, now we know how to set/get text from a `TextView` embedded in a `Notebook` page as well as how to get text from a `Notebook` tab. And we also know how to initialize the tab text when we’re creating the `Label`, but...

What if we wanna reset the tab text programmatically?

### The SetTabTextButton

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/014_container/container_20.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/014_container/container_20_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/014_container/container_20_notebook_set_tab_text.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

This we’ll do from another callback. Setting up the `Button` is exactly the same, so I won’t go over it here, but let’s look at the `SetTabTextButton`’s callback:

```d
void onClicked(Button button)
{
	TextIter startIter, endIter;
	int currentPage;
	TabTextView tabTextView;
	TextBuffer textBuffer;
	Label tabLabel;
	string newLabelText;
		
	currentPage = _myNotebook.getCurrentPage();
	tabTextView = cast(TabTextView)_myNotebook.getNthPage(currentPage);
	textBuffer = tabTextView.getBuffer();
	tabLabel = cast(Label)_myNotebook.getTabLabel(tabTextView);
		
	if(textBuffer.getSelectionBounds(startIter, endIter))
	{
		newLabelText = textBuffer.getText(startIter, endIter, false); // false: do NOT include hidden characters
		tabLabel.setText(newLabelText);
	}
		
	writeln("currentPage position in the Notebook tabs array:", currentPage);
	writeln("tabLabel: ", tabLabel.getText());
	writeln("tabTextView contents: ", tabTextView.getBuffer().getText()); 
		
} // onClicked()
```

Rather than have the `Button` pop open a dialog with a text `Entry` and all the related dialog `Button`s that go along with gathering text from a user, I opted instead for a simpler approach for this demonstration.

Here's how it works... The user selects a chunk of text in the `TextView`. Then a click on this button grabs the selected text and stuffs it into the tab label. Here are the steps:

- get the current page/tab,
- get a pointer to the `TextView` and, after that, its `TextBuffer`,
- grab a pointer to the tab’s label (and in this case, it's a lowercase 'l', so not a `Label` Widget),
- check to see if some text is selected in the `TextView` and, if it is...
- create a string from the selected text, and
- call `setText()`.

The rest is the same as what we had in today’s first demo.

## Conclusion

So, now we’ve got a handle on `Notebook` page/tab input/output and that's just about as far as we'll be going for now. Next time, we'll jump back 
into the *Nodes-n-noodles* series.

Until then, have fun.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/29/0083-notebook-vii-notebook-all-signals.html">Previous: Notebook VII - A Snoot Full of Signals</a>
	</div>
	<div style="float: right;">
		<a href="/2019/11/05/0085-nodes-iv-node-drawing.html">Next: Nodes IV - Drawing a Node</a>
	</div>
</div>
