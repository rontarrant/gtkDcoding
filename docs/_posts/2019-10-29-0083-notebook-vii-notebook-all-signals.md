---
title: "0083: Notebook VII – A Snoot Full of Signals"
layout: post
topic: container
description: This GTK Tutorial covers Notebook signals.
author: Ron Tarrant

---

# 0083: Notebook VII – A Snoot Full of Signals

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_014_18.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_014_18_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_18_notebook_all_signals.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

This time around, we'll just reuse the same code we looked at last time, but with more signals hooked up. So, let’s look at what we have.

## In the Constructor

The `Notebook` constructor gets a bit crowded:

```d
this()
{
	css = new CSS(getStyleContext());

	TabTextView tabTextView = new TabTextView();
	Label label = new Label("Tab " ~ _lastPageNumber.to!string());
	appendPage(tabTextView, label);
	setTabReorderable(tabTextView, true);

	popupEnable();
		
	addOnSwitchPage(&onSwitchPage);
	addOnPageRemoved(&onPageRemoved);
	addOnPageReordered(&onPageReordered);
	addOnPageAdded(&onPageAdded);

	addOnMoveFocusOut(&onMoveFocusOut); // key-binding signals //
	addOnChangeCurrentPage(&onChangeCurrentPage);
	addOnReorderTab(&onReorderTab);
	addOnSelectPage(&onSelectPage);
	addOnFocusTab(&onFocusTab);

} // this()
```

You’ll notice that the signals are hooked up in two groups:

- the first group is for mouse-oriented actions, and
- the second is for keyboard shortcuts only.

Most of the callbacks included here do no more than identify the signal that was triggered and report which page/tab is current, so there’s no point in going over them in detail. Instead, let’s look at what actions trigger those signals. Here’s a list:

- `Insert Page` Button: `onPageAdded` (no explanation needed),
- `Remove Page` Button: `onSwitchPage` (because the page is removed, a new page becomes the current page),
- `Tab` key: *NO SIGNAL* (moves from one widget to the next),
- `Ctrl-Page Down`/`Ctrl-Page Up`: `onChangeCurrentPage` AND `onSwitchPage` are both triggered (these key combinations move from page to page, forward or backward), and
- `Alt-Left Arrow`/`Alt-Right Arrow`: `onReorderTab` AND `onPageReordered` (moves the selected tab left or right)

The signals I didn’t witness being triggered are:

- `onSelectPage`, and
- `onFocusTab`.

I’m sure these get triggered somehow and their names do have certain implications. However, after digging around for a few hours and seeing no sign of them reacting to any action I took, I just moved on.

## Bonus: the Popup Tab Menu

You may have noticed this statement in the middle of the `MyNotebook` constructor:

```d
popupEnable();
```

So innocuous sitting there, but it gives us one more bit of functionality. Right-click on any tab and you’re presented with a list of all the tabs in your application which will come in handy if ever we have so many tabs open that they stretch beyond the `Window`'s visible area. If we leave things the way they are now and keep adding tabs, the window will get wider to accomodate them all. And that means we’ve got one more thing to look at…

## How to Manage an Overabundance of Tabs

That’s the second statement right below the one that turns on the popup menu:

```d
setScrollable(true);
```

It’s that simple. Set to true, we get horizontal scrolling which means once the window’s width is taken up with tabs, it no longer grows in size each time we add a new one.

## Conclusion

We aren't done with the *GTK* `Notebook`. Next time around, we’ll dive into how to identify and communicate with child widgets in a Notebook and look at a quick-n-dirty way to change the text label for a tab.

Until then, happy coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/25/0082-notebook-vi-add-remove-tabs.html">Previous: Notebook VI - Add and Remove Tabs</a>
	</div>
	<div style="float: right;">
		<a href="/2019/11/01/0084-notebook-viii-child-widgets.html">Next: Notebook VIII - Child Widgets</a>
	</div>
</div>
