---
title: "0077: Notebook I – The Basics"
layout: post
topic: container
description: GTK Tutorial covering the basics of using a Notebook.
author: Ron Tarrant

---

# 0077: Notebook I – The Basics

Today, we’ll be digging into the *GTK* `Notebook`, the basic widget used to build a multi-document interface (MDI). Each tab in a `Notebook` can contain pretty much whatever you want from a text document to a 2D or 3D graphic, even a visual representation of an audio file or JBC&#153; (Just a Bunch of Controls).

But, enough buildup. Let’s get to it.

## A Single-tab Notebook

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_014_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_014_10_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_10_notebook_basic.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Before we construct a `Notebook`, we need to decide where the tabs will go:
- `PositionType.LEFT`,
- `PositionType.RIGHT`,
- `PositionType.TOP`, or
- `PositionType.BOTTOM`.

And, yeah, that’s the entire list of options available in the `PositionType enum`.

Let’s set up a derived class:

```d
class MyNotebook : Notebook
{
	PositionType tabPosition = PositionType.TOP;
	string tabLabel = "Demo Tab";
	Label myTabLabel;
	MyTextView myTextview;
	
	this()
	{
		super();
		setTabPos(tabPosition);

		myTabLabel = new Label(tabLabel);
		myTextview = new MyTextView();
		appendPage(myTextview, myTabLabel);
				
	} // this()
	
} // class MyNotebook
```

### Class Attributes

In the attributes list, we find our tab position followed by a bunch of other (pretty-much) self-explanatory stuff, but here’s a quick run-down, anyway:

- a string for the tab’s `Label`,
- the actual `Label` we’ll stuff into the tab, and
- a derivative of a `TextView` that we’ll stuff into the tab’s work area/page.

### The Constructor

Still following the code snippet above, after calling the super-constructor, we:

- set the tabs to appear at the top,
- instantiate the `Label` and `TextView` derivatives, and finally,
- call the `appendPage()` function to cram everything in there.

I won’t go over the `TextView` or the `Label` derivative classes here since we’ve talked about those many times in earlier posts.

And that is all there is to it.

### But Wait…

When you compile and run this demo (in *Windows*, at least) you’ll notice that the tab’s `Label` text shows along with a little blue bar underneath so we know it’s selected, but there’s no visible tab background. It doesn’t even have an outline.

Of course, if you’ve already been messing around with themes other than the default *GTK* theme available on *Windows*, your tabs might already be visible. But for those of us who haven’t, this brings us to explore a couple of solutions.

## Making Tabs Visible in Windows 10: the Universal Method

One way to go about this is to change the theme for all *GTK* apps. This is not a well-documented process, but a quick-n-dirty solution is to give your `GTK` apps a win32 theme. It’s not the best solution because it gives everything a *Windows 7* look. It also spits out warnings on the command line. One workaround for that is don't run your app from the command line, which may or may not be appealing.

Either way, here’s what you do:

- as administrator, open `C:\Program Files\Gtk-Runtime\etc\gtk-3.0\settings.ini`,
- find all lines starting with `gtk` and comment them out by typing an octothorp (#) at the begining of each (you could delete them if you want, but by commenting them out, you can easily revert... which I'm sure you will once you see the results),
- go to a new line and add this: `gtk-theme-name=win32`
- save and close the file.

Now you can open any of your GTK apps/demos and travel back in time to the *Windows 7* era.

Like I said, it’s not the best solution, but you end up with visible tabs.

And here’s another way to go about it…

## Making Tabs Visible: the Application-level Method

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/014_container/container_014_11.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/014_container/container_014_11_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_11_notebook_with_visible_tab.d" target="_blank">here</a>.
	</div>
	<div class="frame-footer">																							<!---------- filename (below) ---------->
		The CSS file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/css/visible_tabs.css" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

This isn’t an ideal solution either because we don’t get control over such things as the shape of the tabs, but we do get some control… and it looks better than a *Windows 7* theme superimposed onto a *Windows 10* application.

##### A Call for Participation
<BR>

I haven't tried this on *Linux* (or any other OS) but I'm sure it'll work. If anyone tries it, please tell us about your results (see list of contact options at the bottom of this page).

##### (now, back to our show)
<BR>

If you recall, we covered how to decorate widgets using *CSS* in [Blog Post #0073](/2019/09/24/0073-frame-part-ii.html) when we were talking about the `Frame` widget and what we did there can be adapted here. Below is the *CSS* class we used before, but with `cssPath` set to the file we're working with for this demo:

```d
class CSS // GTK4 compliant
{
	CssProvider provider;
	string cssPath = "./css/visible_tabs.css";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromPath(cssPath);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
```

So, like before, we’ll:

- create a *CSS* class (this time, specifically for tabs), and
- attach it to the `Notebook`’s `StyleContext`.

### Changes to Class Attributes

For each `Widget` where we want *CSS* styling, we add this line in the class preamble:

```d
CSS css;
```

The we go to...

### The Constructor

Here, we add this line:

```d
css = new CSS(getStyleContext());
```

And remember, this also has to be done in the constructor for each widget where CSS will be used.

One more thing to look at...

### The visible_tabs.css File

The file is short-n-sweet:

```css
tab
{
	background-color: #f2f2f2;
}
```

The *CSS Name* for tabs is `tab` and we just need to set the color.

But, there's one more way to go about this, one that appeals to me because we bring the *CSS* selector inside our *D* code file where it can't get misplaced.

## Embedding CSS in D

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/014_container/container_014_12.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/014_container/container_014_12_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_12_notebook_internal_css_tab.d" target="_blank">here</a>.
	</div>
	<div class="frame-footer">																							<!---------- filename (below) ---------->
		A variation of the example using an enum <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_014_12a_notebook_internal_css_enum_tab.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screen shots on a single page -->

The *CSS* selector can be a `string` or an `enum` (follow the second code link above and look for the CSS class at the bottom of the file) and it’s associated with the `CssProvider` using `loadFromData()` instead of `loadFromPath()`. A quick rewrite of the `CSS` class makes this happen:

```d
class CSS // GTK4 compliant
{
	CssProvider provider;
	string myCSS = "tab { background-color: #f2f2f2; }";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(myCSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
```

Nothing has to change in the class(s) using the `CSS`.

## Conclusion

Next time, we’ll carry on and look at multiple tabs (why else are we playing around with tabs?) and eventually get into:

- reordering tabs,
- customized tabs (wherein we draw our own tab shapes from scratch),
- adding and removing tabs, and
- signals associated with the `Notebook` widget and its tabs/pages.

Until then, be nice to each other.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/10/04/0076-nodes-iii-noodles-and-mouse-clicks.html">Previous: Noodles and Mouse Clicks</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/10/11/0078-notebook-ii-multiple-tabs.html">Next: Notebook II - Multiple Tabs</a>
	</div>
-->
</div>
