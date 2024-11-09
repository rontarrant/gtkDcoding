---
title: "0028: Menus III - CheckMenuItems"
topic: menu
tag: menu
layout: post
description: How to use a GTK CheckMenuItem - a D language tutorial.
author: Ron Tarrant

---

# 0028: Menus III - CheckMenuItems

Today we’ll cover another type of `MenuItem`, the `CheckMenuItem`. This post is longer than usual because after doing the simple version, I wanted to do a multiple `CheckMenuItem` version as well and that led to a whole can of worms dumped on my desktop. Anyway, let’s get on with it...

## Single CheckMenuItem

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_09_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_09_single_checkmenuitem.d" target="_blank">here</a>.
	</div>
</div>

For the most part, this is very much the same as other `MenuItem`s. It’s created by calling for a new `CheckMenuItem` and it’s appended to a `Menu` in the same way, but where it strays from the norm is:

- you need to decide the default state of the `CheckBox`, is it checked or not, and
- the callback needs to handle both checked and unchecked states because it’s triggered by toggling the `CheckBox` and *not *just by setting it to an active state.

The beauty of this last point is that we can set up the callback to perform two different actions, one when the `CheckBox` is activated, another when it's deactivated. (A similar behaviour is inherited by the `RadioMenuItem` as we’ll see in the next blog post.)

The simplest way to write the callback is to check the state of the `CheckBox` with `getActive()` and decide what to do from there:

```d
void choose(CheckMenuItem mi)
{
	if(getActive() == true)
	{
		keepItFancy();
	}
	else
	{
		makeItPlain();
	}
	
} // choose()
```

While digging into this widget, I found myself unable to resist doing a more complex version with multiple `CheckMenuItem`s, so here we go...

## Multiple CheckMenuItems and Tracking Their States

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/012_menus/menu_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/012_menus/menu_10_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_10_multiple_checkmenuitems.d" target="_blank">here</a>.
	</div>
</div>

Before we look at the `CheckMenuItem`s themselves...

### The ObservedFeaturesList Object

This example spotlights an imaginary object and the features controlled with the `CheckMenuItem`s. Here’s the code to define this imaginary object:

```d
class ObservedFeaturesList
{
	bool[string] features;

	this()
	{
		features = ["Fancy" : true, "Fortified" : false, "Extra Large" : false, "Soft & Fluffy" : true];
		
	} // this()
	
	
	void setFeature(string featureName, bool state)
	{
		features[featureName] = state;
		
	} // setFeature()
	
	
	bool getFeature(string featureName)
	{
		return(features[featureName]);
		
	} // getFeature()
	
	
	void listFeatures()
	{
		foreach(name, feature; features)
		{
			writeln(name, " = ", feature);
		}
		
	} // listFeatures()
	
} // class ObservedFeaturesList
```

This is a different approach than we’ve taken before. This class keeps track of:

- the number of features,
- their names, and
- their states (on or off, signified by true or false)

The `features` associative array is the only part of the code we need to fiddle with when deciding which features are turned on by default, another reason why using a generic approach to coding other classes makes sense.

Also, the key names are used as labels when creating the `CheckMenuItem`s, so there’s another thing we only have to deal with here in this one place.

This `ObservedFeaturesList` object is instantiated in...

## Back to the Top

Jumping back to the `TextRigWindow` class, we see some changes to our usual code:

```d
class TestRigWindow : MainWindow
{
	string title = "CheckMenuItem Example";
	ObservedFeaturesList observedList;

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		observedList = new ObservedFeaturesList();
		
		AppBox appBox = new AppBox(observedList);
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		observedList.listFeatures();
		
		Main.quit();
		
	} // quitApp()
	
} // TestRigWindow
```

Because all of the `CheckMenuItem`s need access to the `ObservedFeaturesList` and I also wanted to duplicate `Exit` `MenuItem` action when the user clicks the window’s *Close* button, I created the observed object here and passed it down through the hierarchy.

## The FileMenu Class

Here, because the `CheckMenuItem`s are all so similar, we can get away grabbing the names (`itemKey`) from within a `foreach` loop to create the items:

```d
class FileMenu : Menu
{
	FeatureCheckMenuItem[] featureItemArray;
	FeatureCheckMenuItem featureItem;
	ExitItem exitItem;
	
	this(ObservedFeaturesList extObservedList)
	{
		super();
		
		foreach(itemKey, itemValue; extObservedList.features)
		{
			featureItem = new FeatureCheckMenuItem(extObservedList, itemKey);
			featureItemArray ~= featureItem;
			append(featureItem);
		}
		
		exitItem = new ExitItem(extObservedList);
		append(exitItem);
		
	} // this()

} // class FileMenu
```

Note that when using an associative array with a `foreach` loop, we need to name a pair of iterators, a `key` and a `value`, as well as the associative array even though we don't actually use `itemValue`. Within the loop, we do the standard stuff:

- grab the item's name from `features`,
- create the `CheckMenuItem`,
- add it to the local array of `FeatureCheckMenuItem`s, and
- append it to the `Menu`.

Once we’re done with those, it’s back to adding the `exitItem` in the usual way.

One last bit to look at...

## The FeatureCheckMenuItem Class

There’s a little more going on here than with other types of `MenuItem`. Here’s the code:

```d
class FeatureCheckMenuItem : CheckMenuItem
{
	string labelText;
	ObservedFeaturesList observedList;
   
	this(ObservedFeaturesList extObservedList, string extLabelText)
	{
		labelText = extLabelText;
		super(labelText);

		observedList = extObservedList;
		addOnToggled(&toggleFeature);
		setActive(observedList.getFeature(labelText));
		
	} // this()
	
	
	void toggleFeature(CheckMenuItem mi)
	{
		if(getActive() == true)
		{
			observedList.setFeature(labelText, true);
		}
		else
		{
			observedList.setFeature(labelText, false);
		}
		
	} // toggleFeature()
	
} // class FeatureCheckMenuItem
```

Because the individual `CheckMenuItem`s differ only in label text, we can get away with this being a generic class and deal with the naming step up in the `FileMenu` class we just looked at. The constructor gets access to the `ObservedFeaturesList` object like everyone else.

After calling the super-class constructor and setting a couple of local variables, the callback is attached and then we come to:

```d
setActive(observedList.getFeature(labelText));
```

As mentioned above in the section on The `ObservedFeaturesList` object, this function defers the decision about the `CheckMenuItem`’s state to the observed list object.

Next time, we’ll do pretty much the same thing except with `RadioMenuItem`s. However, the mutual-exclusivity of `RadioMenuItem`s demands a different approach in a few areas.

Until then, happy coding, happy hunting, happy birthday, or happy New Year, whatever’s your poison.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/16/0027-mnemonic-shortcut-key.html">Previous: Mnemonics</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/23/0029-radiomenuitem.html">Next: RadioMenuItem</a>
	</div>
</div>
