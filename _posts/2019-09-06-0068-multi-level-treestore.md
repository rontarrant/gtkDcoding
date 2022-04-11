---
title: "0068: MVC XI - Multi-level TreeStore"
layout: post
topic: mvc
tag: mvc
description: GTK Tutorial covering a multi-level, multi-column TreeStore implemented as a model for a TreeView.
author: Ron Tarrant

---

# 0068: MVC XI - Multi-level TreeStore

The last time we looked at an **MVC** example, we dug into the basics of the `TreeStore`, but we didn’t look at how it deals with multi-level, multi-column data. Today we pick up where we left off and do just that.

*Note: The example used herein is based heavily on the D-language `TreeStore` example found on a [Google Sites page](https://sites.google.com/site/gtkdtutorial#chapter6) built back in 2013. I could find no credits, so to the anonymous writer of that tutorial, I thank you.*

## A Multi-level TreeStore

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_18.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_18_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/017_mvc/mvc_18_multi_level_treestore.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

### The Model

The heart of this example is the `LocationTreeStore` where we set up a three-tier hierarchy of population numbers for some of the continents, countries, and cities on our planet. The procedure is more or less the same as what we’ve done before except that some of the work is farmed out to the `addLocation()` function... which we'll look at momentarily.

In the original 2013 example, there were two functions for adding locations:

- `addLocation`, and
- `addChildLocation`.

But I wanted to bring a little something to the table, so I reworked them as a single, overloaded function called simply `addLocation()`. And while I was at it, I also added pretty-ish formatting to the numbers. Here’s how it all goes down:

First, we declare the variables:

```d
private:
TreeIter parentIterAsia, childIterChina, childIterJapan;
TreeIter parentIterEurope, childIterUK, childIterFrance;
TreeIter parentIterNorthAmerica, childIterCanada, childIterUSA;
```

Then in the constructor, we lay out the Model:

```d
super([GType.STRING, GType.STRING]);
```

Following which, we populate each hierarchy of continent, country, and city like this:

```d
parentIterNorthAmerica = addLocation("North America", cast(uint)366_496_802);
childIterCanada = addLocation(parentIterNorthAmerica, "Canada", cast(uint)37_307_925);
addLocation(childIterCanada, "Ottawa", cast(uint)1_378_151);
childIterUSA = addLocation(parentIterNorthAmerica, "United States", cast(uint)329_293_776);
addLocation(childIterUSA, "Washington, DC", cast(uint)713_244);
```

Note that the numbers are all cast as `uint` types at this stage.

### The Overloaded Function

Here are the two overloads:

```d
	// Adds a location and returns the TreeIter of the item added.
	public TreeIter addLocation(in string name, in uint population)
	{
		TreeIter iter = createIter();
		setValue(iter, 0, name);
		setValue(iter, 1, format("%,?d", ',', population));
		
		return(iter);
		
	} // addLocation()
	

	// Adds a child location to the specified parent TreeIter.
	public TreeIter addLocation(TreeIter parent, in string name, in uint population)
	{
		TreeIter childIter = createIter(parent);
		setValue(childIter, 0, name);
		setValue(childIter, 1, format("%,?d", ',', population));
		
		return(childIter);
		
	} // addLocation()
```

The first overload deals with top-tier rows. It needs two arguments, a string for the name of the continent and a `uint` for the population. And it returns a `TreeIter`.

The second overload has three arguments, a `TreeIter` for the parent that’ll “be the boss of” the child we’re creating, a string for the child’s name, and, of course, a `uint`.

*Note: When doing overloaded functions, make sure each overload's first argument is of a unique type (uint, string, etc.) so the D compiler can easily differentiate between them.*

## The View

Structurally, the view is no different than what we used in the earlier `TreeStore` example:

```d
class LocationTreeView : TreeView
{
	private:
	TreeViewColumn countryColumn, populationColumn;
	LocationTreeStore locationTreeStore;
	
	public:
	this()
	{
		super();
		locationTreeStore = new LocationTreeStore();
		setModel(locationTreeStore);

		// Add Country Column
		countryColumn = new TreeViewColumn("Location", new CellRendererText(), "text", 0);
		appendColumn(countryColumn);
		
		// Add Capital Column
		populationColumn = new TreeViewColumn("Population", new CellRendererText(), "text", 1);
		appendColumn(populationColumn);

	} // this()
	
} // class LocationTreeView
```

We simply:

- instantiate the `TreeView`,
- associate the model (`LocationTreeStore`), and
- pop in the `TreeViewColumn`s.

### Imports

The only other thing we need to do—and this, only because I wanted to prettify the numbers—is to do one extra import statement:

```d
import std.string;
```

## Conclusion

All this `TreeView`/`TreeStore` stuff is rather easy once we’ve broken it all down. Yes, there’s a lot involved, but none of it’s really a brain bender when we approach it one concept at a time.

Hope you liked the **MVC** series. Until next time, have fun coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/09/03/0067-mvc-xii-expander.html">Previous: MVC - Expander</a>
	</div>
	<div style="float: right;">
		<a href="/2019/09/10/0069-textview-and-textbuffer.html">Next: TextView and TextBuffer</a>
	</div>
</div>
