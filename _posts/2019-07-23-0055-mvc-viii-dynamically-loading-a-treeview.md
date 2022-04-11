---
title: "0055: MVC VIII – Dynamically Loading a TreeView"
layout: post
topic: mvc
tag: mvc
description: GTK Tutorial on how to dynamically load a TreeView.
author: Ron Tarrant

---

# 0055: MVC VIII – Dynamically Loading a TreeView

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_12.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_12_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/017_mvc/mvc_12_treeview_font_list.d" target="_blank">here</a>.
	</div>
</div>

This time we’re going to dynamically load the `TreeView` with a list of all fonts available on your computer. We’ll use `PgFontDescriptions` (*Pango* fonts) so we can play with not just the names, but the sizes, styles, and weights. And on top of that, we’ll use a bit of math to mix things up and give the list some variety.

## A Note for Windows Users

In the *Command Prompt* window, you may or may not see *Pango* warnings for a bunch of fonts. They still load and the fonts are certainly usable, so it's no big deal.

And now, let's dig in and start by talking about...

## The Imports

To get all this working takes a whole mess of imports:

```d
import std.stdio;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ScrolledWindow;
import gtk.TreeView;
import gtk.ListStore;
import gtk.TreeIter;
import gtk.TreePath;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;
import pango.PgFontDescription;
```

Now, since the `TreeView` and `TreeViewColumn`s are pretty much the same as what we’ve done (by now) so many times before, I’ll just comment on things that are different.

## FontTreeView Class

The constructor is very much the same as what we’ve seen before and only departs from that norm with this:

```d
fontFamilyColumn = new FontFamilyColumn(fontListStore);
appendColumn(fontFamilyColumn);
```

The zeroth column constructor (`FontFamilyColumn`) needs access to the `fontListStore` so it can pass along data from the `PgFontDescriptions` in the Model to its `CellRenderer` as it displays the names of the fonts.

### The Callback

The other thing that's done here in the constructor is, we hook up a callback to react whenever the user double-clicks on a cell in the `TreeView`. The signal is `onRowActivated` and the hook-up is the simple one we've used so often:

```d
	addOnRowActivated(&onRowActivated);
```

The purpose of the callback is to report which cell has been clicked and it looks like this:

```d
void onRowActivated(TreePath treePath, TreeViewColumn tvc, TreeView tv)
{
	int columnNumber;
	TreeIter treeIter = new TreeIter(fontListStore, treePath);
		
	// find the column number...
	if(tvc.getTitle() == "Font Family")
	{
		columnNumber = 0;
	}
	else if(tvc.getTitle() == "Size")
	{
		columnNumber = 1;
	}
	else if(tvc.getTitle() == "Pango Units")
	{
		columnNumber = 2;
	}
	else if(tvc.getTitle() == "Style")
	{
		columnNumber = 3;
	}
	else if(tvc.getTitle() == "Weight")
	{
		columnNumber = 4;
	}

	writeln("TreePath (row): ", treePath, " columnNumber: ", columnNumber);
	writeln(); // a blank line to separate each report

	auto value = fontListStore.getValue(treeIter, columnNumber);
	writeln("cell contains: ", value.getString());
```

And here’s what it does:

- use the `TreePath` to get the row number,
- also using the `TreePath`, we create a `TreeIter` as a handle for the row data (in other words, the `TreePath` gives us the visible row in the `TreeView`, the `TreeIter` gives us the corresponding row in the `ListStore`),
- look up the column number using the column’s header text,
- (purely for informational purposes) echo the row and column numbers to the terminal, and
- use the `TreeIter` (which, remember, is a handle for the row where the data is stored), and
- the `columnNumber` to grab the value of the specific cell that was clicked.

## The FontListStore Class

This class is a bit different from others we’ve used, starting with the initialization section:

```d
class FontListStore : ListStore
{
	SysFontListPango sysFontListPango;
	PgFontDescription[] fontList;
	TreeIter treeIter;
	
	enum Column
	{
		FAMILY = 0,
		SIZE,
		PANGO_SIZE,
		STYLE,
		WEIGHT,
		FONT_DESC
		
	} // enum Column
```

 We’re only working with one array, the `fontList` which is an array of *Pango* font descriptions.

In the `Column` `enum`, we take advantage of *D*’s `enum` auto-numbering which amounts to: number the first item and *D* fills in the numbers for the rest automatically.

### The FontListStore Constructor

```d
this()
{
	super([GType.STRING, GType.STRING, GType.STRING, GType.STRING, GType.STRING, PgFontDescription.getType()]);

	sysFontListPango = new SysFontListPango();
	fontList = sysFontListPango.getList();
		
	foreach(font; fontList)
	{
		treeIter = createIter();
			
		setValue(treeIter, 0, font.getFamily());
		setValue(treeIter, 1, font.getSize() / 1024);
		setValue(treeIter, 2, font.getSize());
		setValue(treeIter, 3, font.getStyle());
		setValue(treeIter, 4, font.getWeight());
		setValue(treeIter, 5, font);
	}

} // this()
```

I'll throw in a quick reminder here that  text and numbers are both rendered as strings—which explains the first five `GType`s in the array passed to the super-class constructor. But you’ll notice the last item in the array self-identifies using `PgFontDescription.getType()`.

Then we:

- instantiate a `SysFontListPango` object that we’ll look at in a moment,
- get the list of `PgFontDescriptions` from it, and
- use the data from each `PgFontDescription` in the `foreach()` loop to set up the data for the columns.

## The SysFontListPango Class

Here's the constructor (*note: all variables starting with an underscore (_) are private to this class and so is `counter`*):

```d
this()
{	
	_pgFontMap = PgCairoFontMap.getDefault();
	_pgFontMap.listFamilies(_pgFontFamilies);

	counter = 1;
	
	foreach(_font; _pgFontFamilies)
	{
		_fontDesc = new PgFontDescription(_font.getName(), _fontSize);
		_pgFontDescriptions ~= _fontDesc;

		if(fmod(counter, 4) == 0)
		{
			varyFontBySize();
		}

		if(fmod(counter, 5) == 0)
		{
			varyFontByWeight(PangoWeight.BOLD);
		}
		else if(fmod(counter, 6) == 0)
		{
			varyFontByWeight(PangoWeight.THIN);
		}

		_fontSize++;
		counter++;

		if(_fontSize > 19)
		{
				_fontSize = 9;
		}
	}

} // this()
```

We grab a list of fonts from the system and use it to create a *Pango* `FontMap` (referred to as a `PgFontMap`). From the `PgFontMap` (essentially just a list of font names) the constructor uses a `foreach()` loop to create the array of `PgFontDescriptions`.

And right in the middle of this, we see why `std.math` was imported...

The `fmod()` function is used three times so we can make:

- every 4th font italics,
- every 5th font heavy (bold), and
- every 6th font light (thin).

I’ll leave you to explore the other class functions—`varyFontBySize()`, `varyFontByWeight()`, and `getList()`—which are all straightforward.

## Reiteration of the Font-grabbing Process

Even though this example is about populating a `TreeView` on the fly and the font stuff is secondary, I'd feel remiss if I didn't go over this process in a more linear fashion to make it as clear as possible. Here's what happens:

- in the `SysFontListPango` class, we:
	- get the default font map from the system using `PgCairoFontMap.getDefault()` and
	- stuff it into a `PgFontMap`,
	- then we call `PgFontMap.listFamilies()` to stuff this list into a `PgFontFamily` array.
	- Then—in a `foreach()` loop—we use `PgFontFamily.getName()` to instantiate an array of `PgFontDescriptions`.
- That array of `PgFontDescriptions` is then accessed by the `FontListStore` class to build its model.
- Finally, the `FontTreeView` class uses the `FontListStore` model to decorate itself.

## Conclusion

A bit long this time, but it was either go long or break this out into two posts which I really didn’t want to do.

And what we’ve covered—fiddling with fonts in a `ListStore`—is really just a precursor for what we’ve got coming next time. We’ll go back to the `ComboBox` and do some serious window dressing on it, using images and `PgFontDescriptions` to make something really fancy.

Until then, happy computing.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/19/0054-mvc-vii-treeview-basics.html">Previous: TreeView Basics</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/26/0056-mvc-ix-a-combobox-with-flair.html">Next: A ComboBox with Flair</a>
	</div>
</div>
