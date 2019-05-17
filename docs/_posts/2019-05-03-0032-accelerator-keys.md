---
title: 0032 – Adding Accelerator Keys to MenuItems
layout: post
description: How to add Accelerator keys to a GTK MenuItem - a D language tutorial.
author: Ron Tarrant

---

## 0032 – Adding Accelerator Keys to MenuItems

You say: Keyboard shortcuts… I say: Accelerator keys… [Let’s code the whole thing out](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_16_accel_menus.d).

## Lots of Keyboard Shortcuts

### Imports

First things first… We need the `AccelGroup` class and a couple of `enum`s, so we bring them in:

	import gtk.AccelGroup;
	import gdk.c.types;

Make note: That’s another **`gdk`** not `gtk` library and from that we get these `enum`s:

#### AccelFlags

- `VISIBLE` (shows on the `MenuItem`), and
- `LOCKED` (can’t be remapped on the fly).

#### ModifierType

- `SHIFT_MASK` (Shift key),
- `LOCK_MASK` (usually the Caps Lock key),
- `CONTROL_MASK` (Control Key), and
- `MOD1_MASK` (usually the Alt key).

We’ll get to their use in a moment, but right now let’s take a quick look at…

### The AccelGroup

Because all accelerator keys are used when the `Window` has focus, the `AccelGroup` needs to be declared in, instantiated in, and added to the `Window` object:

	class TestRigWindow : MainWindow
	{
		string title = "Multiple Menus Example";
		AccelGroup accelGroup;
	
		this()
		{
			super(title);
			setDefaultSize(640, 480);
			addOnDestroy(&quitApp);
	
			accelGroup = new AccelGroup();
			addAccelGroup(accelGroup);
	
			AppBox appBox = new AppBox(accelGroup);
			add(appBox);
			
			showAll();
			
		} // this()
		
		
		void quitApp(Widget w)
		{
			// do other exit stuff here if necessary
			
			Main.quit();
			
		} // quitApp()
		
	} // TestRigWindow

Notice also that it gets passed to the `AppBox` constructor which passes it along to the `MyMenuBar` constructor, then `FileMenuHeader`, `FileMenu`, `EditMenu`, etc. down the line until it’s available to each individual `MenuItem` constructor like this:

	class ExitItem : MenuItem
	{
		string itemLabel = "Exit";
		char accelKey = 'x';
	   
		this(AccelGroup accelGroup)
		{
			super(&doSomething, itemLabel, "activate", true, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
			//addOnActivate(&doSomething);
			
		} // this()
		
		
		void doSomething(MenuItem mi)
		{
			writeln("Quitting... Bye.");
			
			Main.quit();
			
		} // exit()
		
	} // class ExitItem


A less cumbersome way to do this would be with a singleton, but we'll have that discussion next week.

*Another thing to note: Instead of connecting the callback here, we pass it to the super-class. I left the `addOnActivate()` line there—just commented out—as a reminder. Naturally, you can un-comment it to see what happens.*

### What are all those Arguments?

The major departure from earlier examples is, as mentioned, the call to the super-class. One by one, they are...

#### Delegate

This is exactly the same argument we would pass to a signal hook-up function, which is the name of the callback function, preceded by an ampersand (&).

	void delegate(MenuItem) dlg

In this case, it's: `&doSomething`.

#### Label

This is the text that’ll appear on the `MenuItem`:

	string label

And for us (have a look at the initialization section of this class) it ends up being `"Exit"`.

#### Action

This next argument takes the place of assigning a signal when dealing with a `MenuItem`:

	string action

I can think of no reason to use any signal other than `“activate”`... although you might. (And if you do, please post about it either on [the D Language forum](https://forum.dlang.org/) or [the GtkD forum](https://forum.gtkd.org/groups/GtkD/) so we can all add a new technique to our toolbox.)

#### Mnemonic

No need to get deep here, just set this to `true`:

	bool mnemonic

#### AccelGroup

This is what we passed down from the `RigTestWindow`, the object that connects all the keyboard shortcuts to the application's `Window`:

	AccelGroup accelGroup

#### The Keyboard Shortcut Itself

This is the letter key used in combination with `ModifierType` (the next argument) to designate the entire keyboard shortcut:

	char accelKey

And for our example here, it's `'x'`.

#### ModifierType

This decides which qualifier key is held while pressing the letter key:

	ModifierType.<MODIFIER>

These take the form of `ModifierType.CONTROL_MASK` or `ModifierType.SHIFT_MASK` and can be **OR**’ed together like this: `ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK | ModifierType.MOD1_MASK` if you want someone to hold down **Ctrl-Alt-Shift-KEY**. We looked at the possible values for `ModifierType` right at the beginning of this post (in case you need to refer back).

#### AccelFlags

And lastly, the `AccelFlags` argument:

	AccelFlags.VISIBLE

This flag is optional and you can actually leave it out. It's main use seems to be `AccelFlags.LOCKED` which is used when you don’t want users messing with your shortcut keys.


## Conclusion

So, yeah, it takes a bit of extra coding to make these work:

- from stuffing an `AccelGroup` into your main `Window`,
- passing it all the way down to the `MenuItem` objects so they have access when they instantiate, and
- coming up with that long list of arguments to pass to the super-class constructor.

But your users will thank you. And speaking of thanks...

Thanks for reading and do please come back for the next post. Until then...
