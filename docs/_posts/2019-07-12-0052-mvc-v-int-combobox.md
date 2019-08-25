---
title: "0052: MVC V – A ComboBox with Integers"
layout: post
topic: mvc
description: Tutorial on creating a ComboBox with integers.
author: Ron Tarrant

---

## 0052: MVC V – A ComboBox with Integers

This time around, we’re going to change things up in two ways:

- the `ListStore` will have two columns, but only one will be visible in the `ComboBox`, and
- we’ll be displaying integers instead of text in the `ComboBox`.

### A Two-column ListStore

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_07_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_07_combobox_int_2_column.d" target="_blank">here</a>.
	</div>
</div>

I talked about the two-column `ListStore` in [the introduction to this series]() and touched on the requirements for `ListStore`s in general [last time](), but here’s a brief review…

A `ListStore` needs:

- data to stuff into rows, and
- an array of data types, one for each column.

So what we did last time, we just do it twice to get two columns. And what’s the second column for if we don’t see it in the `ComboBox`? Whatever extra data you may want to have associated with the items that do show. Here’s the `DayListStore` class:

```d
class DayListStore : ListStore
{
	string[] days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	int[] dayNumbers = [1, 2, 3, 4, 5, 6, 7];
	GType[] columnTypes = [GType.STRING, GType.INT];
	TreeIter treeIter;
	int dayColumn = 0, numberColumn = 1;

	this()
	{
		string day;
		int number;
		
		super(columnTypes);
		
		for(int i; i < days.length; i++)
		{
			day = days[i];
			number = lettersInDays[i];
			
			treeIter = createIter();
			setValue(treeIter, dayColumn, day);
			setValue(treeIter, numberColumn, number);
		}

	} // this()

} // class DayListStore
```

We have three arrays in the initialization section:

- `days` - our string data,
- `dayNumbers` – the integer data, and
- `columnTypes` – an array of `GType` data types.

The constructor is pretty much the same as before except that in the `for()` loop we extract a bit of data from each of the two data arrays and make the call to `setValue()` twice, once for each column.

### The DayComboBox

In the initialization section of the `DayComboBox`, we have:

```d
class DayComboBox : ComboBox
{
	private:
	bool entryOn = false;
	DayListStore _dayListStore;
	CellRendererText cellRendererText;
	int visibleColumn = 1;
	int activeItem = 0;
```

A couple of things I’ll point out here…

First...

Even though the data in our `ListStore` is integers, we’re using a `CellRendererText`. We follow through in the initialization section where we declare it:

```d
CellRendererText cellRendererText;
```

And in these three lines from the constructor where we instantiate it, pack it into the `ComboBox`, and deal with the attributes:

```d
cellRendererText = new CellRendererText();
packStart(cellRendererText, false);
addAttribute(cellRendererText, "text", visibleColumn);
```

Second…

In the initialization section, the `visibleColumn` variable is set to `1`, not `0` as it was before. This is where the decision is made as to which column is shown in the `ComboBox`.

And if you look at those lines from the constructor, you’ll see that `addAttribute()` is where the visible column is set.

The rest of the constructor is the same and the callback is almost identical except that it calls an extra function to write to the terminal. Because there’s nothing remarkable about it, I’ll leave you to explore it on your own if you’re so inclined.

## Conclusion

And that’s how to use integers in a `ComboBox`. Join us next time for a peek into the mysteries of `ComboBox`es with images.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/09/0051-mvc-iv-combobox-text.html">Previous: ComboBox with Text</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/16/0053-mvc-vi-image-combobox.html">Next: ComboBox with Images</a>
	</div>
</div>