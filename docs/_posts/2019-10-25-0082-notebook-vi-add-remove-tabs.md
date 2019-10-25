---
title: "0082: Notebook VI – Adding and Removing Tabs"
layout: post
topic: container
description: This GTK Tutorial covers adding and removing tabs from a Notebook.
author: Ron Tarrant

---

# 0082: Notebook VI – Adding and Removing Tabs

Today we’re going to cover adding and deleting tabs and I’ll talk a bit about how a *GTK* `Notebook` keeps track of tabs, why you don’t have to, and why you might think you do.

Rather than building a menu system for this, I decided it would be less work to just toss in a couple of `Button`s... and it was.

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_014_17.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_014_17_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_17_notebook_add_remove_tabs.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

## A Grid for Buttons

We’ll use a `Grid` derivative to hold the `Button` widgets:

```d
class ButtonGrid : Grid
{
	InsertButton insertButton;
	RemoveButton removeButton;
	
	this(MyNotebook myNotebook)
	{
		insertButton = new InsertButton(myNotebook);
		attach(insertButton, 0, 0, 1, 1);
		
		removeButton = new RemoveButton(myNotebook);
		attach(removeButton, 1, 0, 1, 1);
		
	} // this()
	
} // class ButtonGrid
```

Nothing new here, just a quick refresher on how to stuff things into a `Grid`. Create a couple of `Button` widgets and `attach()`, remembering that those arguments mean:

- first arg (`0`): the column to start in,
- second arg (`0`): the row to start in,
- third arg (`1`): number of columns this widget takes up, and
- fourth arg (`1`): number of rows this widget takes up.

The only thing of real note here is that a pointer to the `Notebook` is passed into the `Grid` and subsequently passed along to each `Button` that’s created. We’ll cover the particulars of why next as we look at…

## A Button for Inserting Tabs

We’ve seen these buttons before, so no new ground is being covered. Even the fact that we’re passing in a pointer to the `Notebook` is something we’ve seen before in the *GTK* `Menu` series ([Blog Post #34: AccelGroup as a Singleton](/2019/05/10/0034-accelgroup-singleton.html)) where we Singleton-ized our `AccelGroup` so we could tap into it from wherever without passing it down through multiple layers of objects. But this time, for simplicity sake and because there are only two levels to deal with, we'll do it the non-Singleton way:

```d
class InsertButton : Button
{
	string _buttonLabel = "Insert Page";
	TabTextView myTextView;
	MyNotebook _myNotebook;
	
	this(MyNotebook myNotebook)
	{
		super(_buttonLabel);
		
		_myNotebook = myNotebook;
		
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button button)
	{
		_myNotebook.addPage();
		
	} // onClicked()
	
} // class InsertButton
```

And why do we need the `Notebook` pointer in here? Because the `Insert Page` and `Remove Page` `Button`s need access to the `MyNotebook.addPage()` and `MyNotebook.deletePage()` functions, respectively.

And when we hook up the signals, because we’ve got a local copy of the `MyNotebook` pointer (`_myNotebook`) it's dead simple to make the calls.

The `Remove Page` `Button` is set up exactly the same way, so let’s now look at the changes in `MyNotebook`...

## MyNotebook – What’s New?

There are some pretty drastic changes in this class, so let’s look at them by section…

### The Preamble

```d
CSS css; // needed to see tab shapes against the bg
PositionType tabPosition = PositionType.TOP;
string tabLabelPrefix = "Tab ";
int _lastPageNumber = -1;
```

Here, we got rid of all the declarations for `TextView` and `Label` objects and replaced them with a single string (`tabLabelPrefix`) which we’ll use to build tab `Label`s each time `addPage()` is called.

We also have a completely new addition in `_lastPageNumber`. This will help make sure each new tab gets a unique name. This isn’t strictly necessary for a full-blown application, but I have seen it done. For our purposes, it will mainly serve to tell us which tab is being removed or what the new order of the tabs is... because we’re also keeping that reordering functionality we talked about last time.

And why is it initially set to `-1`? Because if we’re being purists, all arrays start at `0` and that leads me to a slight digression...

#### How the GTK Notebook Handles Tabs/Pages and Why it Might Not be Obvious

Each time you make a call to `Notebook.appendPage()`, it returns an integer commonly referred to in the API docs as an index or `tabIndex`. The fact that this number is returned might lead you to believe that you have to track the array of tabs, but don’t be fooled. It does keep a running tally—each subsequent call to `appendPage()` increases the index returned by this function—but my guess is this is a leftover from a time when you actually did have to keep track of the tab array.

This is why, in all the demo code I’ve written for the `Notebook`, I ignore the `appendPage()` return value. I couldn’t think of anything useful to do with the index, so I ignored it, but if you come up with something, I’d love to hear about it.

Now, back to our show...

### The Constructor

This is short and sweet:

```d
this()
{
	super();
	setTabPos(tabPosition);
	css = new CSS(getStyleContext());
	addPage();
	
} // this()
```

Here’s what we do:

- call the super-class constructor,
- set up where the tabs will appear in relation to the `Notebook` work area,
- associate our `CSS` so we have tabs with colored backgrounds, and
- add the first tab/page.

I threw in that last line to mimic what most text editors do, give you a new, blank page to work with on start-up so you don’t have to monkey around with `New` as soon as you’ve started your app.

### The addPage() Function

```d
void addPage()
{
	_lastPageNumber++; // increase the page count
	TabTextView tabTextView = new TabTextView();
	Label label = new Label("Tab " ~ _lastPageNumber.to!string());
	appendPage(tabTextView, label);
	setTabReorderable(tabTextView, true);

	showAll();
		
} // addPage()
```

This is all straightforward:

- increment the page count variable to ensure a unique tab name,
- instantiate a `TabTextView` and a `Label`,
- append the page, and
- turn on the reorderable flag.

That last line, `showAll()`, is important because with all these widgets we’re juggling, the `Notebook` needs a kick in the butt to do a redraw.

### A Note About Page Count and the tabIndex

You might think that the value returned from `appendPage()` could be used in place of `_lastPageNumber`, but here's the thing... for our purposes, we need the new page to be created with its label containing the number that's *returned* by `appendPage()`. In other words, we need the number before `appendPage()` can give it to us. And that's why this one thing, the numbering used in tab labels, is something we have to track ourselves.

## Conclusion

And so we come to the end of another post dedicated to the `Notebook`. And next time, a look at all the signals you might deal with in—yup—a `Notebook`.

Until then, happy coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/22/0081-notebook-v-custom-tabs-iii.html">Previous: Notebook V - Custom Tabs II</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/10/29/0083-notebook-vii-notebook-all-signals.html">Next: Notebook VIII - A Snoot Full of Signals</a>
	</div>
-->
</div>
