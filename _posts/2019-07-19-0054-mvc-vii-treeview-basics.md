---
title: "0054: MVC VII – TreeView Basics"
layout: post
topic: mvc
tag: mvc
description: GTK Tutorial - introduction to TreeView, ListStore, and TreeViewColumn.
author: Ron Tarrant

---

# 0054: MVC VII – TreeView Basics

We’ve all been told that the `TreeView` is a complex and difficult beast to tame, but it’s not so hard once you've got a few bits of information at your fingertips. And in the previous six instalments of this series, most of those bits have been presented which means it should come as no big surprise that...

There are only three `Widgets` we need to understand in order to make a `TreeView` work:

- a `ListStore` which holds the data and acts as a `TreeModel`,
- the `TreeViewColumn` which controls the content and look of a column, and
- the `TreeView` itself.

And that’s it.


## A Single-column TreeView

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_10_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/017_mvc/mvc_10_treeview_1_column.d" target="_blank">here</a>.
	</div>
</div>

We derive a `SignTreeView` from the `TreeView` class and it looks like this:

```d
class SignTreeView : TreeView
{
	SignTreeViewColumn signTreeViewColumn;
	SignListStore signListStore;
	
	this()
	{
		super();
		
		signListStore = new SignListStore();
		setModel(signListStore);
		
		signTreeViewColumn = new SignTreeViewColumn();
		appendColumn(signTreeViewColumn);
		
	} // this()
	
} // class SignTreeView
```

Once the `TreeView` is instantiated by calling the super-class constructor, we set up and assign the Model/Store (`signListStore`), then instantiate and append one or more `TreeViewColumn`s.

## The ListStore

The `ListStore` is used the same way with a `TreeView` as it was with the `ComboBox` and so we have:

```d
class SignListStore : ListStore
{
	string[] items = ["bike", "bump", "cow", "deer", "crumbling cliff", "man with a stop sign", "skidding vehicle"];
	TreeIter treeIter;
	
	this()
	{
		super([GType.STRING]);
		
		foreach(ulong i; 0..items.length)
		{
			string message = items[i];
			treeIter = createIter();
			setValue(treeIter, 0, message);
		}

	} // this()

} // class SignListStore
```

This is the same `SignListStore` we used with a `ComboBox` in [an earlier example]( https://github.com/rontarrant/gtkd_demos/blob/master/017_mvc/mvc_06_combobox_liststore.d), thus illustrating how the same data can be used in different ways by different `Widget`s.

And that just leaves...

## The TreeViewColumn

Which looks like this:

```d
class SignTreeViewColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Sign Message";
	string attributeType = "text";
	int columnNumber = 0; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()

} // class SignTreeViewColumn
```

When we populated a `ComboBox`, a `CellRenderer` was packed directly into the `ComboBox`. But with a `TreeView`:

- each `TreeViewColumn` takes care of its own `CellRenderer`(s), and
- is appended to the `TreeView` as we saw earlier when we looked at the `TreeView` class itself. 

So, it's here in the `TreeViewColumn` constructor we deal with such things as:

- instantiating the `CellRenderer`,
- assigning a column number, and
- defining the column type as `“text”`.

On top of that, we also name the column (`columnTitle`) and give it a number. And that's pretty much it.

## Two-column TreeView

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/017_mvc/mvc_11.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/017_mvc/mvc_11_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/017_mvc/mvc_11_treeview_2_column.d" target="_blank">here</a>.
	</div>
</div>

You only have to do two things differently with a two-column `TreeView`:

- add another column (naturally), and
- decide if you want the column(s) sort-able.

And that means:
- in the `SignTreeView` class, we `appendColumn()` the second column,
- in one or both `TreeViewColumn` classes, we `setSortColumnId()` with the number of the column (starting from `0`), and
- in the `ListStore`, we add a second array of data.

### Using ListStore's set() Instead of setValue()

As mentioned in [Blog Post #0053](http://gtkdcoding.com/2019/07/16/0053-mvc-vi-image-combobox.html), as long as we’re using strings and only strings, we can get away with using `set()`. But it’s meant as a shorthand way of dealing with a single data type: the string. This means that even if you’re using numbers (which are rendered as text by `ComboBox` and `TreeView`) we still have to use `setValue()`.

## Conclusion

And that’s the basics of using the `TreeView`... create a storage model, whip up a `TreeView`, and stuff a column in there.

Next time around we’ll look at a second multi-column `TreeView` example which is dynamically loaded rather than using roll-yer-own arrays.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/16/0053-mvc-vi-image-combobox.html">Previous: A ComboBox with Images</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/23/0055-mvc-viii-dynamically-loading-a-treeview.html">Next: TreeView - Dynamic Population</a>
	</div>
</div>
