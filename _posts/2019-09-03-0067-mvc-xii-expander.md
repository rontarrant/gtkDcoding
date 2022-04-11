---
title: "0067: The Expander"
layout: post
topic: container
tag: container
description: GTK Tutorial covering the basics of using an Expander widget.
author: Ron Tarrant

---

# 0067: The Expander

Today’s widget example is similar to a `TreeView` with a `TreeStore` model, but with only two hierarchy levels, a parent with a single child. It's also much simpler to use, but if we want to use it to its full potential, we'll need to do more preparation, code-wise, but let’s start with the dead-simple version and go from there.

## A Simple Expander

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/014_container/container_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/014_container/container_03_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_03_simple_expander.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->


For those times when you need to hide/show things, but you don’t want the full-on features of a `ComboBox` or a `TreeView` backed by a `TreeStore`, the `Expander` may be just the ticket. And it does the job without all the overhead of either. You can simply stuff one into a container (such as an `AppBox`) like this:

```d
class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyExpander expander;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		expander = new MyExpander();
		packStart(expander, expand, fill, localPadding);
		
	} // this()

} // class AppBox
```

Now you’ll notice I’m not using a bare-bones `Expander`, but all I’ve done is follow the convention I laid out for these blog examples and derive `MyExpander` from `Expander` so as to keep all the details in an easily-managed class/object... like this:

```d
class MyExpander : Expander
{
	string label = "An Expander";
	bool isMnemonic = false;
	Label childLabel;
	
	this()
	{
		super(label, isMnemonic);
		
		childLabel = new Label("Child of expander");
		add(childLabel);
		
	} // this()
	
} // class MyExpander
```

The `Expander` is derived from the `Bin` widget which means working with `add()` and `remove()` to stuff things in and—if necessary—yank them out.

The only thing we haven’t seen before is the call to the `Expander` constructor whose arguments are:

- `label` – the child you want to reveal when the `Expander` is expanded, and
- `isMnemonic` – a *Boolean* that controls whether or not the user can hit an **Alt**+**key** combination to expand/contract the `Expander`.

Can’t get much simpler than that, but you can get more complicated if you want to reveal more than a single widget when the child container is visible.

### A Note about the getExpanded() Function

Naturally, if you want to trigger a callback, you’ll be working with the `onActivate` signal, but like any engineer will say about the flow of electricity in the real world: it works the opposite of what you may expect.

Hooking up the signal is the same as always, but polling `getExpanded()` to find the `Expander`’s state means the callback will need to be written like this:

```d
	void doSomething(Expander expander)
	{
		writeln("Expander was clicked and...");
		
		if(getExpanded == false)
		{
			writeln("Expander is expanded, child revealed.");
		}
		else
		{
			writeln("Expander child is now hidden.");
		}
		
	} // doSomething()
```

Intuitively you might think expanded means the `Expander` is... well, expanded, but it doesn’t. I don’t know if there’s a reason for this, but if I find out there is one, I’ll let you know.

## A More Crowded Expander

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/014_container/container_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/014_container/container_04_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/014_container/container_04_extended_expander.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->


To stuff more widgets into an `Expander`’s child area, I opted for the `Grid` as a container. Stick a `Grid` in there and follow [the guidelines I laid out in the post covering customized `Dialog` windows](/2019/06/07/0042-custom-dialog-i.html) and you should have no trouble getting a decent layout happening.

Here’s the derived `Grid` I used (it’s based on the `PadGrid` from [the custom `Dialog` example](https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_10_custom_content_area.d)):

```d
class ExpanderChildGrid : Grid
{
	int leftStartColumn = 0, topStartRow = 0, extendToRight = 1, extendToDown = 1;
	int borderWidth = 10;
	uint globalPadding = 0, localPadding = 0;
	PadLabel childLabel01, childLabel02;
	BoxJustify bJustify = BoxJustify.LEFT; 
	string labelText01 = "Child of expander", labelText02 = "Another child of expander";
	
	this()
	{
		super();
		
		childLabel01 = new PadLabel(bJustify, labelText01);
		attach(childLabel01, leftStartColumn, topStartRow, extendToRight, extendToDown);
		
		childLabel02 = new PadLabel(bJustify, labelText02);
		attach(childLabel02, leftStartColumn, topStartRow + 1, extendToRight, extendToDown);
		
		setMarginLeft(10);
		
	} // this()
	
} // class ExpanderChildGrid
```

When I borrowed this piece of code, the other thing I changed was that ‘`pJustify`’ became ‘`bJustify`’ because it makes more sense... considering that it’s a `BoxJustify` variable. (I don’t remember why I originally called it ‘`pJustify`,’ but likely because I first called it 'PadJustify'. Not important, but there it is.)

If you also grab the `PadLabel` and `HPadBox` classes from the custom `Dialog` example, along with the `BoxJustify` enum, you’ll be all set to cram whatever you want into the `Expander`’s child `Bin`.

## Conclusion

And there you have it, yet another way to hide child widgets inside a parent widget, this one seemingly with one foot in the `ComboBox` camp and the other in the `TreeView`/`TreeStore` camp and yet, easier to use than either.

Hope you found this as revealing as I did (no pun intended... honest). Until next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/08/30/0066-toolbar-basics.html">Previous: Toolbar Basics</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/09/06/0068-multi-level-treestore.html">Next: Multi-level TreeStore</a>
	</div>
-->
</div>
