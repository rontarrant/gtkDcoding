---
title: CheckMenuItems
layout: post
description: How to use a CheckMenuItem.
author: Ron Tarrant
keywords:
- GtkD
- GTK+ 3
- dlang
- D language
- MenuBar
- MenuItem
- Menu
- Widget
- Event
- CheckMenuItem

---

## 0028 – CheckMenuItems

Today we’ll cover another type of `MenuItem`, the `CheckMenuItem`. This post is longer than usual because after doing the simple version, I wanted to do a multiple `CheckMenuItem` version as well and that led to a whole can of worms dumped on my desktop. Anyway, let’s get on with it…

### Single CheckMenuItem

[Here’s the first example file]( https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_09_single_checkmenuitem.d).

For the most part, this is very much the same as other `MenuItem`s. It’s created by calling for a new `CheckMenuItem` and it’s appended to a `Menu` in the same way, but where it strays from the norm is:

- you need to decide the default state of the `CheckBox`, is it checked or not, and
- the callback needs to handle both checked and unchecked states because it’s triggered by toggling the `CheckBox` and *not *just by setting it to an active state.

The beauty of this last point is that we can set up the callback to perform two different actions, one when the `CheckBox` is activated, another when it's deactivated. (A similar behaviour is inherited by the `RadioMenuItem` as we’ll see in the next blog post.)

The simplest way to write the callback is to check the state of the `CheckBox` with `getActive()` and decide what to do from there:

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
		
	} // exit()

While digging into this widget, I found myself unable to resist doing a more complex version with multiple `CheckMenuItem`s, so here we go...

### Multiple CheckMenuItems and Tracking Their States

[Here’s the code file]( https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_10_multiple_checkmenuitem.d), but before we look at the `CheckMenuItem`s themselves…

### The ObservedFeaturesList Object

This example spotlights an imaginary object and the features controlled with the `CheckMenuItem`s. Here’s the code to define this imaginary object:

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

This is a different approach than we’ve taken before. This class keeps track of:

- the number of features,
- their names, and
- their states (on or off, signified by true or false)

The `features` associative array is the only part of the code we need to fiddle with when deciding which features are turned on by default, another reason why using a generic approach to coding other classes makes sense.

Also, the key names are used as labels when creating the `CheckMenuItem`s, so there’s another thing we only have to deal with here in this one place.

This `ObservedFeaturesList` object is instantiated in…

### Back to the Top

Jumping back to the `TextRigWindow` class, we see some changes to our usual code:

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

Because all of the `CheckMenuItem`s need access to the `ObservedFeaturesList` and I also wanted to duplicate `Exit` `MenuItem` action when the user clicks the window’s *Close* button, I created the observed object here and passed it down through the hierarchy.

### The FileMenu Class

Here, because the `CheckMenuItem`s are all so similar, we can get away grabbing the names (`itemKey`) from within a `foreach` loop to create the items:

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

Note that when using an associative array with a `foreach` loop, we need to name a pair of iterators, a `key` and a `value`, as well as the associative array even though we don't actually use `itemValue`. Within the loop, we do the standard stuff:

- grab the item's name from `features`,
- create the `CheckMenuItem`,
- add it to the local array of `FeatureCheckMenuItem`s, and
- append it to the `Menu`.

Once we’re done with those, it’s back to adding the `exitItem` in the usual way.

One last bit to look at…

### The `FeatureCheckMenuItem` Class

There’s a little more going on here than with other types of `MenuItem`. Here’s the code:

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

Because the individual `CheckMenuItem`s differ only in label text, we can get away with this being a generic class and deal with the naming step up in the `FileMenu` class we just looked at. The constructor gets access to the `ObservedFeaturesList` object like everyone else.

After calling the super-class constructor and setting a couple of local variables, the callback is attached and then we come to:

	setActive(observedList.getFeature(labelText));

As mentioned above in the section on The `ObservedFeaturesList` object, this function defers the decision about the `CheckMenuItem`’s state to the observed list object.

Next time, we’ll do pretty much the same thing except with `RadioMenuItem`s. However, the mutual-exclusivity of `RadioMenuItem`s demands a different approach in a few areas.

Until then, happy coding, happy hunting, happy birthday, or happy New Year, whatever’s your poison.
