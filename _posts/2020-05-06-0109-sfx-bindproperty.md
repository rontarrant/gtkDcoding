---
title: "0109: SFX – Sync Properties Over Multiple Widgets"
layout: post
topic: sfx
tag: sfx
description: This GTK Tutorial covers a D-specific implementation of the Observer pattern.
author: Ron Tarrant

---

# 0109: SFX – Using bindProperty() to Sync Properties Over Multiple Widgets

This post is the result of a discussion with Ferhat Kurtulmuş on the *D Forum*. He pointed out that `bindProperty()` can be used to sync up the sensitivity of a bunch of widgets. Change one and they all change. It sounded rather intriguing, so let’s have a look, shall we?

## Widget Sync

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/016_sfx/sfx_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/016_sfx/sfx_09_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/016_sfx/sfx_09_bindproperty.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Looking at the screen-shot, you’ll see a list of three `Switch`s and, at the bottom, a single standard `Button` that will control their sensitivity. The standard `Button` only changes the `"sensitive"` flag on the first `Switch`. The rest have theirs bound to that of the first. Anyway, let’s have a look at how it works...

### Adding Companion Widgets

The function that sets all this up is part of the `MyButton` class and looks like this:

```d
void addCompanion(Widget widget)
{
	companions ~= widget;
		
	if(companions[0] != widget)
	{
		companions[0].bindProperty("sensitive", widget, "sensitive", GBindingFlags.DEFAULT);
	}

} // addCompanion()
```

The `if()` statement makes sure the zeroeth `Switch` has already been assigned to the `companions` array before doing anything. It then names that zeroeth `Switch` as the observed `Switch`, so to speak, and binds its `sensitive` property to any other `Switch` widgets passed into the `addCompanion()` function.

This example only uses `Switch`es, but you can use anything, really, as long as you up-cast to `Widget` as you pass it to `addCompanion()`.

### Making the List of Switches Insensitive

This is done in the `onButtonPress()` callback:

```d
bool onButtonPress(Event e, Widget w)
{
	if(companions[0].getSensitive() is false)
	{
		writeln("Activating switch");
		companions[0].setSensitive(true);
		setLabel(labelText[1]);
	}
	else
	{
		writeln("Deactivating switch.");
		companions[0].setSensitive(false);
		setLabel(labelText[0]);
	}
		
	return(true);
		
} // onButtonPress()
```

This is pretty much the same as the `onButtonPress()` function we saw in the first demo we talked about in [Blog Post #0104](/2020/03/12/0104-widget-opacity-ii.html). The only difference is that we’re working with an array of companion widgets instead of just one.

The `MySwitch` class is identical, so the only thing left to look at is...

### The ButtonGrid Constructor

And really, all we’re looking at here is how these `Switch`es are all stuffed into the UI and associated, each with the first...

```d
this()
{
	switchLabel1 = new Label("Insensitize Me");
	attach(switchLabel1, 0, 0, 1, 1);
	mySwitch1 = new MySwitch();
	attach(mySwitch1, 1, 0, 1, 1);
		
	switchLabel2 = new Label("Insensitize Me, too");
	attach(switchLabel2, 0, 2, 1, 1);
	mySwitch2 = new MySwitch();
	attach(mySwitch2, 1, 2, 1, 1);
		
	switchLabel3 = new Label("Me, three!");
	attach(switchLabel3, 0, 3, 1, 1);
	mySwitch3 = new MySwitch();
	attach(mySwitch3, 1, 3, 1, 1);

	myButton = new MyButton();
	attach(myButton, 0, 4, 2, 1);
	myButton.addCompanion(cast(Widget)mySwitch1);
	myButton.addCompanion(cast(Widget)mySwitch2);
	myButton.addCompanion(cast(Widget)mySwitch3);

	setBorderWidth(borderWidth);
	setMarginBottom(10);
	setColumnSpacing(columnSpacing);
	setRowSpacing(rowSpacing);
		
} // this()
```

The first three sets of four statements each add a `Switch` along with a `Label`. The only tricky bit in there is making sure we count `Grid` rows and columns correctly. That’s something that, I’m sure, could be automated if one put some effort into it. Perhaps that’ll be the subject of a future post. Anyway...

Once we add `myButton`—the standard `Button` that triggers all this insensitivity—we drop it onto the `Grid` and then call `myButton.addCompanion()` for each `Switch`.

The rest is all stuff we’ve done before.

## Conclusion

There’s no limit to how many `Widgets`—or which type(s) of `Widgets`—we can add to the list. Since `addCompanion()` is set up to add a generic `Widget`, all you have to do is use the `cast()` function to match what `addCompanion()` needs and you’re all set. And with `ObjectG` being everybody’s great-grandparental unit, you don’t have to worry about climbing too far up the hierarchy to access the `bindProperty()` function.

That’s it for now. Take care of each other and don’t let the bad guys win.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/04/25/0108-snippets-iv-arrays.html">Previous: Snippets IV - Using Arrays in a UI Context</a>
	</div>
	<div style="float: right;">
		<a href="/2020/05/17/0110-scale-button.html">Next: The Scale Button</a>
	</div>
</div>
