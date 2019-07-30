---
title: 0065 – MVC X – TreeStore Basics
layout: post
topic: mvc
description: GTK Tutorial covering the basics of using a TreeStore.
author: Ron Tarrant

---

#0065 – MVC X – TreeStore Basics

About a month ago, we broke away from *MVC* to talk about drawing with *Cairo*. Time to go back and pick up where we left off…

##TreeStore Modeling with append()

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screenshots on a single page -->
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
<!-- end of snippet for first (1st) occurrence of application and terminal screenshots on a single page -->

The `TreeStore`, as mentioned in the introduction to this series, isn’t populated in quite the same way as a `ListStore`. There’s all that hierarchy stuff to contend with, but it really boils down to this:

- create a row iter, and
- use that iter to create a child row iter.

Of course, we also have to populate the rows as we go along, so that changes our process to:

- create a row iter,
- populate it,
- use the existing iter as a parent as we create and populate the child row.

There are two approaches to this process, one uses `append()` and `prepend()`, the other uses `createIter()`, all of which are functions of the `TreeStore` object.

To do a simple population of a parent and child, we just:

{% highlight d %}
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
{% endhighlight d %}

So, looking at the constructor, it starts off the same as a `ListStore`, call the super-class constructor and pass it an array of types, one for each column.

But then we make a call to `append()` to set up the parent row. As you can see, append() returns a `TreeIter` and if we pass it a null value, it knows we’re creating a row at the top-level in our `TreeStore`.

But, one thing we can’t do with `append(`) is populate the row, so we still need to do that with `setValue()`.

Next, we make another call to `append(`), this time passing it the `parentIter` `append()` created the first time. This gives us two things:

- a second `TreeIter`, and
- a parent/child relationship between the first `TreeIter` and the second.

In effect, this approach allows us to use whatever `TreeIter` is returned by `append(`) to create the next generation of rows, going from parent to child to grandchild, etc.

##TreeStore with Multiple Top-level Rows

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_15_append_multiple.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screenshots on a single page -->

For completeness sake, here’s a second example that adds multiple children to each of three top-level rows. The relevant code looks like this:

{% highlight d %}
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
{% endhighlight d %}

This should be straightforward to work out… we’re appending a parent row followed by the children of that parent, then moving on to the next parent.

But I mentioned earlier that there’s a second way to do this, so let’s look at that…

##TreeStore Modeling with createIter()

<!-- 4, 5 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/018_mvc_mvc_018_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img5" src="/images/screenshots/018_mvc_mvc_018_16_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_mvc_mvc_018_16_treestore_createiter.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for third (3rd) occurrence of application and terminal screenshots on a single page -->

The main difference here is that `createIter()` doesn’t need a null to know it’s creating a top-level row. Have a look:

{% highlight d %}
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
{% endhighlight d %}

Everything is done exactly the same way and in the same order with just that simple substitution, `append()` becomes `creatIter()`, and as mentioned, no null pointer passed to `createIter()`.

##Populating a TreeStore in a Loop with createIter()

<!-- 6, 7 -->
<!-- third occurrence of application and terminal screenshots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img6" src="/images/screenshots/018_mvc/mvc_018_17.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img7" src="/images/screenshots/018_mvc/mvc_018_17_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/018_mvc/mvc_018_17_treestore_createiter_loop_fill.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for fourth (4th) occurrence of application and terminal screenshots on a single page -->

One last example today and uses `createIter()` as we just did, but take what we did with the multiple top-level rows example and shoving all that into a `for()` loop. Relevant code:

{% highlight d %}
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
{% endhighlight d %}

No real surprises here. In the outside for() loop…

- the parent iter is created as an empty row,
- its label is stuffed in there with `setValue()`,
- then the inner `for()` loop kicks in and…
o creates the `childIter` by passing in the parent iter,
o picks the appropriate string from the children array of string arrays, and
o does a `setValue()` to fill in the children.

##Conclusion

And that’s the basics of the `TreeStore` class. Next time, we’ll dig deeper and get some serious stuff happening.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/23/0064-cairo-vii-drawingarea-animation.html">Previous: Cairo DrawingArea Animation</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/08/23/0064-cairo-vii-drawingarea-animation.html">Next: Cairo DrawingArea Animation</a>
	</div>
-->
</div>
