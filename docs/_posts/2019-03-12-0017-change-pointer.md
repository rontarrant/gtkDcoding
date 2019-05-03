---
title: 0017 - Mouse Pointer
layout: post
description: Changing the shape of the mouse pointer based on which widget it's over.
author: Ron Tarrant
keywords:
- GtkD
- GTK+ 3
- dlang
- D language
- Graphical User Interface
- signal
- event
- callback
- mouse pointer
---

## 0017 - Mouse Pointer

How many programmers does it take to change a mouse pointer?

I don't have an answer, but I can tell you how many functions it takes: one. And we'll be dealing with two such masterful functions this time, `setCursor` and `resetCursor` which are available to all *Widgets*.

Their use is straightforward.

### Code Breakdown

First, here's [the Change Mouse Pointer example]( https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_07_change_pointer.d).

We need quite a list of imports to do this:

	import std.stdio;

	import gtk.MainWindow;
	import gtk.Main;
	import gtk.Widget;
	import gtk.Button;
	import gdk.Event;
	import gdk.Cursor;
	import gtk.Layout;

The most obvious new addition is `gdk.Cursor` (as before, note the ‘*d*’ in ‘*gdk*’). But in this example, the `Cursor` class is only needed for instantiation. The `CursorType` enum is found in `gtk.c.types` as mentioned in the comment below the import statements.

And there’s quite an array of cursor shapes available, too, all that you’d expect to see plus several dozen more. I picked a few for this demo: `HEART`, `GUMBY`, and `HAND1`.

### Other Differences in the Code

I made an arbitrary change to how the buttons are added. Because there are three, I stuffed them into an array of `Button`s and used a `foreach()` to pop them into the `Layout`, increasing the `y` location each time by 80 pixels:

	this()
	{
		super(null, null);
		
		HandButton handButton = new HandButton();
		HeartButton heartButton = new HeartButton();
		GumbyButton gumbyButton = new GumbyButton();

		buttons = [handButton, heartButton, gumbyButton];
		
		foreach(button; buttons)
		{
			put(button, x, y);
			y += 80;
		}

	} // this()

Because they're widgets at heart, we can declare the array as an array of widgets as is done at the top of the `MyLayout` class:

	Widget[] buttons;

We could also have made this an array of buttons, but it's good to keep in mind that we can include other widgets in an array like this and get them into the GUI without writing out individual `put()` statements.

With minor differences, all three derived button classes are the same, so we’ll examine only one. And since Gumby (probably a registered trademark) is the more cartoon-like, let’s go there:

	class GumbyButton : Button
	{
		string title = "Gumby Over";
		
		this()
		{
			super(title);
			
			addOnEnterNotify(&onEnter);
			addOnLeaveNotify(&onLeave);
			
		} // this()
		
	
		public bool onEnter(Event event, Widget widget)
		{
			bool value = true;
			
			Cursor myCursor = new Cursor(CursorType.GUMBY);
			setCursor(myCursor);
	
			return(value);
			
		} // onEnter()
	
	
		public bool onLeave(Event event, Widget widget)
		{
			bool value = true;
			
			resetCursor();
	
			return(value);
			
		} // onLeave()
	
	} // class GumbyButton

### Disecting Gumby

In the constructor, all we do is call the parent class to create the button, then hook up the `Enter` and `Leave` signals.

The `onEnter()` function is no stranger. It expects a *Boolean* return value which (thinking back) we know can be used for chaining signals. We don’t in this case. From there, we create and change the cursor shape.

`onLeave()` is simpler. All it does is reset the cursor to the default shape.

And that’s it.

### Bonus Code Example: All Actions

Okay, not all, but quite a few. There are other signals you could hook up. If you want to play around, I encourage you to take a look at the `GdkEventType` enum starting on line number 947 of [the gdk types.d file]( https://github.com/gtkd-developers/GtkD/blob/master/generated/gtkd/gdk/c/types.d).

[The code file can be found here]( https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_08_all_actions.d).

So, happy D-coding and may the Widgets be with you, as always.

