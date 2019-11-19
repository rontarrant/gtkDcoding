---
title: "0065: MVC X – TreeStore Basics"
layout: post
topic: mvc
description: GTK Tutorial covering the basics of using a TreeStore.
author: Ron Tarrant

---

# 0065: MVC X – TreeStore Basics

About a month ago, we broke away from *MVC* to talk about drawing with *Cairo*. Time to go back and pick up where we left off...

## TreeStore Modeling with append()

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_14.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_14_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_14_treestore_append.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

As mentioned in [the introduction to this series](/2019/06/28/0048-mvc-i-introduction.html), the `TreeStore` isn’t populated in quite the same way as a `ListStore` because a `ListStore` is a flat model while a `TreeStore` has a hierarchy.  But the difference isn't that drastic.

In a flat model store, each row iter is created without associating it with any other, but in a hierarchical store, we do this:

- create a row iter, and
- use that iter to create a child row iter.

And if you add a grandchild row or even more generations, it's the same process all the way down.

Of course, we also have to populate the rows as we go along, so we stuff this extra step in between the other two:

- create a row iter,
- populate it,
- use the existing iter as a parent as we create and populate the child row.

There are two approaches we can use, one with `append()` and `prepend()`, the other with `createIter()`, all of which are functions of the `TreeStore` object.

The code for a simple parent/child relationship might look like this:

```d
class DemoTreeStore : TreeStore
{
	TreeIter parentIter, childIter;
	string parentRowString = "Parent";
	string childRowString = "Child";
	 
	this()
	{
		super([GType.STRING, GType.STRING]);

		parentIter = append(null);
		setValue(parentIter, 0, parentRowString);

		childIter = append(parentIter);
		setValue(childIter, 1, childRowString);
		
	} // this()
	
} // class DemoTreeStore
```

The first step in the constructor is the same as any other store/model. The super-class constructor needs an array of types, one for each column.

But then we depart from the flat model procedure. Comparing the two calls to `append()`:

- for the parent row, `append()` is passed a `null` value, but
- for the child row, `append()` is passed the parent row's iter.

The three bits of knowledge to glean from all this are:

- `append()` always returns a `TreeIter`,
- a `null` value tells `append()` to create a top-level row, and
- a non-`null` value tells `append()` that the row being created is a child.

But, one thing we can’t do with `append(`) is populate the row, so we still need to do that with `setValue()`.

In effect, this approach allows us to use whatever `TreeIter` is returned by `append(`) to create the next generation of rows, going from parent to child to grandchild, etc.

## TreeStore with Multiple Top-level Rows

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/017_mvc/mvc_017_15.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/017_mvc/mvc_017_15_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_15_treestore_append_multiple.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screenshots on a single page -->

For completeness sake, here’s a second example that adds multiple children to each of three top-level rows. The relevant code looks like this:

```d
this()
{
	super([GType.STRING, GType.STRING]);

	parentIter = append(null); // first header row
	setValue(parentIter, parentColumn, "Mom #1");
	
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #1");
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #2");

	parentIter = append(null); // first header row
	setValue(parentIter, parentColumn, "Dad #1");
	
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #3");
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #4");

	parentIter = append(null); // first header row
	setValue(parentIter, parentColumn, "Mom #2");
	
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #5");
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #6");
	append(childIter, parentIter);
	setValue(childIter, childColumn, "Kid #7");
	
} // this()
```

This should be straightforward to work out... we’re appending a parent row followed by the children of that parent, then moving on to the next parent.

But I mentioned earlier that there’s a second way to do this, so let’s look at that...

## TreeStore Modeling with createIter()

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/017_mvc/mvc_017_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/017_mvc/mvc_017_16_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_16_treestore_createiter.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->

The main difference here is that `createIter()` doesn’t need a null to know it’s creating a top-level row. Have a look:

```d
class DemoTreeStore : TreeStore
{
	TreeIter parentIter, childIter;
	string parentRowString = "Parent";
	string childRowString = "Child";
	 
	this()
	{
		super([GType.STRING, GType.STRING]);

		parentIter = createIter();
		setValue(parentIter, 0, parentRowString);

		childIter = createIter(parentIter);
		setValue(childIter, 1, childRowString);
		
	} // this()
	
} // class DemoTreeStore
```

Everything else is the same with just that simple substitution. `append()` becomes `creatIter()`, but the `createIter()` argument is either the parent iter or nothing at all.

## Populating a TreeStore in a Loop with createIter()

<!-- 6, 7 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img6" src="/images/screenshots/017_mvc/mvc_017_17.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal6" class="modal">																<!-- modal# -->
				<span class="close6">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img66">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal6");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img6");														// img#
			var modalImg = document.getElementById("img66");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close6")[0];										// close#
			
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
			<img id="img7" src="/images/screenshots/017_mvc/mvc_017_17_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal7" class="modal">																			<!-- modal# -->
				<span class="close7">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img77">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal7");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img7");																	// img#
			var modalImg = document.getElementById("img77");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close7")[0];													// close#
			
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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_17_treestore_createiter_loop_fill.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for fourth (4th) occurrence of application and terminal screen shots on a single page -->

One last example today and it uses `createIter()` as we just did, but takes what we did with the multiple top-level rows example and shoves it into a `for()` loop. Relevant code:

```d
this()
{
	super([GType.STRING, GType.STRING]);

	for(int i = 0; i < parentHeaders.length; i++)
	{
		string parentTitle = parentHeaders[i];
		string[] childFamily = children[i];

		parentIter = createIter(); // append an empty row to the top level and get an iter back
		setValue(parentIter, 0, parentTitle);

		for(int j = 0; j < childFamily.length; j++)
		{
			childIter = createIter(parentIter); // passing in parentIter makes this a child row

			string child = children[i][j];
			setValue(childIter, 1, child);
		
		}
	}
	
} // this()
```

No real surprises here. In the outside `for()` loop...

- the parent iter is created as an empty row,
- its label is populated with `setValue()`,
- then the inner `for()` loop:
	- creates the `childIter` by passing in `parentIter`,
	- picks the appropriate string from the `children` array, and
	- does a `setValue()` to fill in the child rows.

## Conclusion

And that’s the basics of the `TreeStore` class.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/23/0064-cairo-vii-drawingarea-animation.html">Previous: Cairo DrawingArea Animation</a>
	</div>
	<div style="float: right;">
		<a href="/2019/08/30/0066-toolbar-basics.html">Next: Toolbar Basics</a>
	</div>
</div>
