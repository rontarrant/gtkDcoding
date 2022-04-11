---
title: "0053: MVC VI – A ComboBox with Images"
layout: post
topic: mvc
tag: mvc
description: Tutorial on using a ComboBox with images.
author: Ron Tarrant

---

# 0053: MVC VI - A ComboBox with Images

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_08.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_08_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_08_combobox_pixbuf.d" target="_blank">here</a>.
	</div>
</div>

And here's a [link to the zip file containing images used in this example](https://github.com/rontarrant/gtkDcoding/blob/master/downloads/_images.zip).  

So, we’ve done a two-column `ListStore`, how about one with four columns? And this time, let's throw in a `Pixbuf`... which BTW isn’t defined in the `GType enum`.

## The SignListStore Class

Here’s the initialization section:

```d
class SignListStore : ListStore
{
	string[] items = ["bike", "bump", "cow", "deer", "crumbling cliff", "man with a stop sign", "skidding vehicle"];
	int[] signNumbers = [1, 2, 3, 4, 5, 6, 7];
	string[] images = ["_images/bicycle.png",
			"_images/bump.png", 
			"_images/cattle.png", 
			"_images/deer.png", 
			"_images/falling_rocks.png", 
			"_images/road_crew.png", 
			"_images/slippery_road.png"];
	string[] descriptions = ["Bicycles present",
				"Bump ahead",
				"Cattle crossing",
				"Deer crossing",
				"Falling rocks ahead",
				"Road crew ahead",
				"Slippery when wet"];
	enum Column
	{
		THEME_COLUMN = 0,
		NUMBER_COLUMN = 1,
		IMAGE_COLUMN = 2,
		DESCRIPTION_COLUMN = 3
		
	} // enum Column
	
	TreeIter treeIter;
```

And the definitions for the four columns mean we’re working with:

- `items`: one-word text tags for each image,
- `signNumbers`: numbers associated with each image,
- `images`: relative paths and file names for each image, and
- `descriptions`: strings with more complete descriptions of each sign.

You’ll also notice there’s an `enum` (`Column`) and we’ll see in a moment how these values are used, in the constructors for both the `SignListStore` and the `SignComboBox`.

Making the `Column enum` part of `SignListStore` means that anywhere we can access the `ListStore`, we’ll be able to access these static column values. And if you take a peek at the `AppBox` class...

```d
class AppBox : Box
{
	SignComboBox signComboBox;
	SignListStore signListStore;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		signListStore = new SignListStore();
		signComboBox = new SignComboBox(signListStore);
		packStart(signComboBox, false, false, 0);
		
	} // this()

} // class AppBox
```

 ... you'll see that a pointer to `signListStore` is passed into the `SignComboBox` constructor.

Now let’s look at the `SignListStore` constructor:

```d
this()
{
	string item, imageName, description;
	int number;

	super([GType.STRING, GType.INT, Pixbuf.getType(), GType.STRING]);
		
	foreach(ulong i; 0..items.length)
	{
		item = items[i];
		number = signNumbers[i];
		imageName = images[i];
		description = descriptions[i];
			
		treeIter = createIter();
		setValue(treeIter, Column.THEME_COLUMN, item);
		setValue(treeIter, Column.NUMBER_COLUMN, number);
		setValue(treeIter, Column.IMAGE_COLUMN, new Pixbuf(imageName));
		setValue(treeIter, Column.DESCRIPTION_COLUMN, description);
	}

} // this()
```

The first thing I’ll point out is the array we’re passing to `super()`. See that `Pixbuf.getType()` argument? It needs a bit of explanation, so here goes...

### Non-GTypes

Any visible *GTK*/*GDK*/*Pango* object class—such as `Pixbuf`, `Color`, `RBGA`, `PgFontDescription`, along with a whole raft of others—can be used as `ListStore` column data types. Some—like `Color`, `RBGA`, and `PgFontDescription`—can do no more than decorate other columns, but others—like the `Pixbuf`—can be visible in the `ComboBox`. And we get the correct type to pass to the `ListStore` constructor by asking the data class—not an instantiation of the class, but the base class itself—what type it is, kind of a “who goes there” approach:

```d
Pixbuf.getType()
```

And that does the job. Include that right in the array we pass to the super-class constructor and it’s accepted as just another `GType`.

*Note: Because `getType()` is a function call, it can’t be read at compile time, so we can’t predefine the array like we can if the columns all hold standard `GTypes`. The array has to be defined in the constructor at the very earliest, or written out as it’s passed to the super-class constructor as can be seen here:*

```d
super([GType.STRING, GType.INT, Pixbuf.getType(), GType.STRING]);
```

And the `foreach()` loop that calls `setValue()` can now stuff everything into the `ListStore`:

```d
foreach(ulong i; 0..items.length)
{
	item = items[i];
	number = signNumbers[i];
	imageName = images[i];
	description = descriptions[i];
			
	treeIter = createIter();
	setValue(treeIter, Column.THEME_COLUMN, item);
	setValue(treeIter, Column.NUMBER_COLUMN, number);
	setValue(treeIter, Column.IMAGE_COLUMN, new Pixbuf(imageName));
	setValue(treeIter, Column.DESCRIPTION_COLUMN, description);
}
```

Two things of note here:

1. I mentioned earlier that we'd see how the `Column` enum values are used and here's the first of those uses, to identify which column is being filled for each pass through the `foreach()` loop, and
2. the call to `setValue()` that handles the `Pixbuf` column makes a call to the `Pixbuf` constructor, passing along the file name grabbed from the `imageName` array.

*Note: When your `ListStore` is to contain only string data, you can use `set()` instead of `setValue()` and thereby plug data into all the columns of a single row in one statement, but when using non-string data types, doing a `setValue()` on columns one at a time is your only option.*

## The SignComboBox Class

Rather than reproduce the entire `SignComboBox` class here, we’ll just look at the bits and pieces we haven’t seen before...

Because we want to show images instead of text, we need to declare a `CellRendererPixbuf` in the initialization section of the `SignComboBox` class:

```d
CellRendererPixbuf cellRendererPixbuf;
```

And in the constructor we have the instantiation, the packing, and the adding of attributes:

```d
cellRendererPixbuf = new CellRendererPixbuf();
packStart(cellRendererPixbuf, false);
addAttribute(cellRendererPixbuf, "pixbuf", _signListStore.Column.IMAGE_COLUMN);
```

You’ll note that whereas with the `CellRendererText` we used `“text”` as an attribute name, here we use `“pixbuf”` for the `CellRendererPixbuf`. Stands to reason, right?

*Note: There is a bit of terminology confusion with the second argument to the `addAttribute()` statement. In the `addAttribute()` function definition, this argument is called an attribute. But when you look in the online reference or one of the books written about* GTK*, they’re called properties.*

Anyway, if you’re curious about this type of attribute/property, go to the *[GTK Reference Manual](https://developer.gnome.org/gtk4/3.96/)* online and search in the page for `CellRenderer`. Click on any of them and you’ll find a *Properties* section not too far down the page.

As we encounter each type of `CellRenderer`, we’ll cover which property/attribute is used with each one.

The other thing to note about the call to `addAttribute()` is its last argument:

```d
_signListStore.Column.IMAGE_COLUMN
```

This is the second (and final) use of the `Column` enum and it's why the `Column enum` was made part of the `SignListStore` class. A pointer to the store itself gets passed into the `SignComboBox` constructor, so we have access to it here without any major fiddling around.

## Bonus Example – A 3-Column ComboBox

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/017_mvc/mvc_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/017_mvc/mvc_09_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_09_combobox_view_3_columns.d" target="_blank">here</a>.
	</div>
</div>

The [folder/directory of images](https://github.com/rontarrant/gtkDcoding/blob/master/downloads/_images.zip) is used with this example as well.

This post is running a bit long, but this example really won’t take much explanation, so here goes...

There are only two differences between this example and the last. One's in the constructor and it's merely how many `CellRenderer`s we stuff into the `SignComboBox`. It happens in these lines in the constructor:

```d
cellRendererInt = new CellRendererText();
packStart(cellRendererInt, false);
addAttribute(cellRendererInt, "text", _signListStore.Column.NUMBER_COLUMN);
	
cellRendererText = new CellRendererText();
packStart(cellRendererText, false);
addAttribute(cellRendererText, "text", _signListStore.Column.THEME_COLUMN);

cellRendererPixbuf = new CellRendererPixbuf();
packStart(cellRendererPixbuf, false);
addAttribute(cellRendererPixbuf, "pixbuf", _signListStore.Column.IMAGE_COLUMN);
```

The `ComboBox` is derived from the Bin class and so all we have to do is pack in three `CellRenderer`s, making sure we use an appropriate attribute (in this case, `“text”` for the first two columns and `“pixbuf”` for the last) and make sure they're pointing to columns with matching data.

The other difference is...

There's no `visibleColumn` variable because they're all visible.

So remember:

- you can have as many columns visible in the `ComboBox` as you wish, and
- multiple calls to `addAttribute()` will make this happen.

## Conclusion

And that wraps up our look at `ComboBox`es with images. Next time we’ll start looking at the `TreeView`.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/12/0052-mvc-v-int-combobox.html">Previous: ComboBox with Integers</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/19/0054-mvc-vii-treeview-basics.html">Next: TreeView Basics</a>
	</div>
</div>
