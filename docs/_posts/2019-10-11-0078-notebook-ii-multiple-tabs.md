---
title: "0078: Notebook II – Multiple Tabs, Reordering & Image Tabs"
layout: post
topic: container
description: This GTK Tutorial covers using multiple tabs in a Notebook.
author: Ron Tarrant

---

# 0078: Notebook II – Multiple Tabs, Reordering & Image Tabs

A single tab in a `Notebook` has limited value, so today we’ll start by adding more. Then we'll look at how to turn on the reorder mechanism, and finish off by replacing the `Label` contained in the tab with an `Image`.

Because the `CSS` we worked with last time gave us fully-visible tabs, let’s continue with that for now.

## Multiple Tabs

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_014_13.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_014_13_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_13_notebook_multi_tab.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Not much has to change to have more tabs. Just add more strings for tab names, more `Label`s, and more `TextView`s… or whatever you’re cramming in there. Your class preamble might look like this:

```d
CSS css; // need to see tab shapes against the bg
PositionType tabPosition = PositionType.TOP;
Label tabLabelOne, tabLabelTwo, tabLabelThree;
string textOne = "Tab One", textTwo = "Tab Two", textThree = "Tab Three";
TabTextView tabTextViewOne, tabTextViewTwo, tabTextViewThree;
```

And the constructor might resemble this:

```d
this()
{
	super();
	setTabPos(tabPosition);
	css = new CSS(getStyleContext());

	tabTextViewOne = new TabTextView("Now is the witness of our discontinent.");
	tabLabelOne = new Label(textOne);
	appendPage(tabTextViewOne, tabLabelOne);

	tabTextViewTwo = new TabTextView("Four stores and seven pounds ago...");
	tabLabelTwo = new Label(textTwo);
	appendPage(tabTextViewTwo, tabLabelTwo);

	tabTextViewThree = new TabTextView("Help me open yon cantelope.");
	tabLabelThree = new Label(textThree);
	appendPage(tabTextViewThree, tabLabelThree);
		
} // this()
```

Now, let's move on to...

## Reordering Tabs

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/014_container/container_014_14.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/014_container/container_014_14_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_14_notebook_reorder_tabs.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

This is easy, too. All we have to do is add one line each time we add a tab:

```d
setTabReorderable(textViewOne, true);
```

Which means our `Notebook` class might look like this:

```d
class MyNotebook : Notebook
{
	CSS css; // need to see tab shapes against the bg
	PositionType tabPosition = PositionType.TOP;
	Label tabLabelOne, tabLabelTwo, tabLabelThree;
	TabTextView textViewOne, textViewTwo, textViewThree;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());

		textViewOne = new TabTextView("Now is the witness of our discontinent.");
		tabLabelOne = new Label("Tab One");
		appendPage(textViewOne, tabLabelOne);
		setTabReorderable(textViewOne, true);

		textViewTwo = new TabTextView("Four stores and seven pounds ago...");
		tabLabelTwo = new Label("Tab Two");
		appendPage(textViewTwo, tabLabelTwo);
		setTabReorderable(textViewTwo, true);

		textViewThree = new TabTextView("Help me open yon cantelope.");
		tabLabelThree = new Label("Tab Three");
		appendPage(textViewThree, tabLabelThree);
		setTabReorderable(textViewThree, true);
		
	} // this()
	
} // class MyNotebook
```

No big deal.

You may wonder what would happen if you set some tabs to be reorderable while leaving others as is. It turns out, the non-reorderable tabs still move around, but only to get out of the way of the other tabs. Rather than actually being unmovable, they become passive-resistant, refusing any direct manipulation, but giving in if another tab needs it to move aside.

Now, let's look at what can be done to give tabs a bit more visual appeal.

## Images in Tabs

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/014_container/container_014_15.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal4" class="modal">																<!-- modal# -->
				<span class="close4">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img44">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal4");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img4");														// img#
			var modalImg = document.getElementById("img44");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close4")[0];										// close#
			
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
			<img id="img5" src="/images/screenshots/014_container/container_014_15_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal5" class="modal">																			<!-- modal# -->
				<span class="close5">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img55">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal5");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img5");																	// img#
			var modalImg = document.getElementById("img55");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close5")[0];													// close#
			
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

	<div class="frame-footer">																							<!---------- filename (below) ---------->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_15_notebook_tab_images.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screen shots on a single page -->

Here's the breakdown of what needs to be done:

In the preamble, we declare an `Image` widget for each tab:

```d
Image tabImageOne, tabImageTwo, tabImageThree;
```

In the constructor, we instantiate them:

```d
tabImageOne = new Image("images/green-man.png");
```

And append each `Image` to the tab just like we would a `Label`:

```d
appendPage(tabTextViewOne, tabImageOne);
```

Here’s how the `MyNotebook` class might look taking this approach:

```d
class MyNotebook : Notebook
{
	CSS css; // need to see tab shapes against the bg
	PositionType tabPosition = PositionType.TOP;
	Image tabImageOne, tabImageTwo, tabImageThree;
	TabTextView tabTextViewOne, tabTextViewTwo, tabTextViewThree;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());

		tabTextViewOne = new TabTextView("Now is the witness of our discontinent.");
		tabImageOne = new Image("images/green-man.png");
		appendPage(tabTextViewOne, tabImageOne);
		setTabReorderable(tabTextViewOne, true);

		tabTextViewTwo = new TabTextView("Four stores and seven pounds ago...");
		tabImageTwo = new Image("images/yellow-man.png");
		appendPage(tabTextViewTwo, tabImageTwo);
		setTabReorderable(tabTextViewTwo, true);

		tabTextViewThree = new TabTextView("Help me open yon cantelope.");
		tabImageThree = new Image("images/whisk.png");
		appendPage(tabTextViewThree, tabImageThree);
		setTabReorderable(tabTextViewThree, true);
		
	} // this()
	
} // class MyNotebook
```

And, voila, we’ve got reorder-able custom tabs.

## Conclusion

Another thing I got to wondering about while preparing these demos was this: is it possible to draw a more elegantly-shaped tab without resorting to an `Image`? As it turns out, the answer is yes, but there is a gotcha to consider. We’ll talk about that next time when we get to some real roll-up-your-sleeves customization.

Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/08/0077-notebook-i-basics.html">Previous: Notebook I - The Basics</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/10/15/0079-notebook-iii-custom-tabs-1.html">Next: Notebook III - Custom Tabs 1</a>
	</div>
-->