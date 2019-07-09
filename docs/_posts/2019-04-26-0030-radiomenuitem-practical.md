---
title: "0030: Menus V - A More Practical RadioMenuItem"
topic: menu
layout: post
description: How to use a GTK RadioMenuItem, a more practical solution - a D language tutorial.
author: Ron Tarrant

---

# 0030 – Menus V - A More Practical RadioMenuItem

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_012_12.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_012_12_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_12_observed_radiomenuitems.d" target="_blank">here</a>.
	</div>
</div>

Today let’s look at an example that can perhaps be adapted for everyday use.

Herein we set a bit of data with our `RadioMenuItem`s and track it with an observed object. And when the application terminates, it spits out a report about the state of all options in the set. This example is patterned after [the second CheckMenuItem example from two posts ago](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_10_multiple_checkmenuitems.d), so a lot of this ground [was covered there](http://gtkdcoding.com/2019/04/19/0028-checkmenuitems.html).

Just a quick reminder (if you aren’t flipping back to the previous post) that we created an observed object in `TestRigWindow` which got handed down through the hierarchy. We do the same here, but because we're dealing with `RadioMenuItem`s and not `CheckMenuItem`s, there will be a different approach.

The differences are in:

- how the `FileMenu` adds items,
- where features are turned on or off during signal-handling/callback, and
- (of course) we have mutual exclusivity here which we didn’t in the `CheckMenuItem` example.

Let’s go through them…

## A Busier FileMenu Class

Most of the differences (compared to the `CheckMenuItem` example) are in the constructor. But there are differences throughout, so let’s look at this thing in chunks:

### Chunk #1

{% highlight d %}
	class FileMenu : Menu
	{
		FeatureRadioMenuItem[] featureItemArray;
		FeatureRadioMenuItem featureItem;
		ExitItem exitItem;
		
		ListSG group;
{% endhighlight %}

- Instead of giving each item it’s own name here, we’re creating an array (naming is deferred and we'll see that in a moment),
- the `featureItem` string will serve as a temporary name within the `foreach` loop used to create the items, and
- `group` is declared here, but will be defined during creation of the first item.

### Chunk #2

{% highlight d %}
	this(ObservedFeaturesList extObservedList)
	{
		super();

		foreach(itemName; extObservedList.featureNames)
		{
			if(itemName == extObservedList.featureNames[0])
			{
				featureItem = new FeatureRadioMenuItem(group, extObservedList, itemName);
				group = featureItem.getGroup();
			}
			else
			{
				featureItem = new FeatureRadioMenuItem(group, extObservedList, itemName);
			}

			featureItemArray ~= featureItem;
			append(featureItem);
		}
{% endhighlight %}

This is the first part of the constructor and includes the `foreach` loop used to create the `RadioMenuItem`s. We step through the `featureNames` string array (a part of the `ObservedFeatureList` object) to get label text for each item. The strings in `featureNames` decide the item names, and the number of strings decides how many items will be in the set.

- the `if` statement takes care of the first item, the one that also defines the `group` variable,
- note that even though we pass the group variable to the RadioMenuItem constructor, it comes back as `null` and only takes on a value when `group = featureItem.getGroup()` is executed,
- the `else` statement passes the now-defined `group` along to all other items as they’re created so they become a set, and
- at the end of the `foreach`, we concatenate the item into our array of items before appending it to the `FileMenu`.

### Chunk #3

{% highlight d %}
			extObservedList.setFeatureDefault();
			
			foreach(item; featureItemArray)
			{
				if(item.getLabel() == extObservedList.getDefaultFeature())
				{
					item.setActive(true);
				}
				else
				{
					item.setActive(false);
				}
			}
	
			exitItem = new ExitItem(extObservedList);
			append(exitItem);
			
		} // this()
		
	} // class FileMenu
{% endhighlight %}

This part is where we set the default item and make sure the states of all items in `ObservedFeaturesList` agree with the `RadioMenuItem` set.

Since these things take place in the `ObservedFeaturesList` class, we’ll cover them when we get there.

Finally, we drop the `ExitItem` onto the end of the menu and bail:

{% highlight d %}
	exitItem = new ExitItem(extObservedList);
	append(exitItem);
			
	} // this()
{% endhighlight %}

Now let’s look at…

## Mutual Exclusion in the ObservedFeaturesList Class

Again, we’ll look at this in chunks…

### Chunk #1

{% highlight d %}
	class ObservedFeaturesList
	{
		bool[string] features;
		string[] featureNames;
		string defaultFeatureName;
{% endhighlight %}

These variables are:

- `features` : an associative array with Boolean flags for tracking which item is active; text strings used as item names double as keys in the key/value pairs,
- `featureNames` : an array of strings used to name the `RadioMenuItem`s; they do double duty when building the `features` associative array, and
- `defaultFeatureName` : this string needs to match one of those in `featureNames` and is used to set the default item on startup.

### Chunk #2

{% highlight d %}
	this()
	{
		defaultFeatureName = "Large";
		featureNames = ["Small", "Medium", "Large", "Extra Large"];
		
	} // this()
{% endhighlight %}

Earlier I mentioned that the naming of `RadioMenuItem`s is deferred. Well, this is where it's done. All we do in the constructor is define which item will be the default and then fill in the array naming all the `RadioMenuItem`s in the set. This list can be extended or truncated to change the number of items in the set.

*Note: Don't forget to double-check that `defaultFeatureName` appears verbatim in the `featureNames` array.*

### Chunk #3

{% highlight d %}
	void setFeatureDefault()
	{
		for(int i = 0; i < featureNames.length; i++)
		{
			string featureName = featureNames[i];
			
			if(featureName == defaultFeatureName)
			{
				features[featureName] = true;
			}
			else
			{
				features[featureName] = false;
			}
		}

	} // setFeatureDefault()
{% endhighlight %}

This is the function called from `FileMenu`’s constructor, the one that—as the name implies—sorts out which `RadioMenuItem` will be turned on by default.

### Chunk #4

{% highlight d %}
	void setFeature(string featureName)
	{
		foreach(feature, state; features)
		{
			if(feature == featureName)
			{
				features[feature] = true;
			}
			else
			{
				features[feature] = false;
			}
		}
		
	} // setFeature()
{% endhighlight %}

When an item in the set is selected by the user, this function is called by the callback to keep the `ObservedFeaturesList` in sync with the state of the `RadioMenuItem` set.

### Chunk #5

{% highlight d %}
		string getDefaultFeature()
		{
			return(defaultFeatureName);
		}	
		
		
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
{% endhighlight %}

These functions do the following:

- `getDefaultFeature() `is called from the second half of `FileMenu`’s constructor to sync up the flags in the `features` associative array with the state of the `RadioMenuItem` set, and
- `getFeatureState()` is unused in this example, but is here as a placeholder. It returns the Boolean value of the named feature. It can be tested like this (perhaps from somewhere near the end of the `setFeature()` function):

{% highlight d %}
	writeln("The state of ", featureName, ": ", getFeatureState(featureName));
{% endhighlight %}

## And Finally: the FeatureRadioMenuItem Class

This is a lot of stuff we’ve seen before, but one thing I’d like to point out is this: The callback is triggered whether the `RadioMenuItem` is going into an *on* state or an *off* state. That’s why there’s also an `if` statement in there to test the state of the `RadioMenuItem`. I would assume you could also have an `else` for doing some type of clean-up or what-have-you when an item is deselected.

{% highlight d %}
	class FeatureRadioMenuItem : RadioMenuItem
	{
		string labelText;
		ObservedFeaturesList observedList;
	   
		this(ListSG group, ObservedFeaturesList extObservedList, string extLabelText)
		{
			labelText = extLabelText;
			super(group, labelText);
	
			observedList = extObservedList;
			addOnToggled(&toggleFeature);
			
		} // this()
		
		
		void toggleFeature(CheckMenuItem mi)
		{
			if(getActive() == true)
			{
				observedList.setFeature(labelText);
			}
			
		} // toggleFeature()
		
	} // class FeatureRadioMenuItem
{% endhighlight %}

We could also have used the `onActivate` signal instead of `onToggled`, but the results are pretty much the same either way.

Now, since this looks to be the longest blog post I've done to date, pay no attention while I beat a hasty exit, stage right.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/23/0029-radiomenuitem.html">Previous: RadioMenuItem</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/30/0031-imagemenuitem.html">Next: ImageMenuItem</a>
	</div>
</div>
