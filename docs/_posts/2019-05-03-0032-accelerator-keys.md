---
title: "0032: Menus VII - Adding Accelerator Keys to MenuItems"
topic: menu
layout: post
description: How to add Accelerator keys to a GTK MenuItem - a D language tutorial.
author: Ron Tarrant

---

# 0032 – Menus VII - Adding Accelerator Keys to MenuItems

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_012_16.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_012_16_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_16_accel_menus.d" target="_blank">here</a>.
	</div>
</div>

## Imports

First things first… We need the `AccelGroup` class and a couple of `enum`s, so we bring them in:

{% highlight d %}
	import gtk.AccelGroup;
	import gdk.c.types;
{% endhighlight %}

Make note: That’s another **`gdk`** not `gtk` library and from that we get these `enum`s:

### AccelFlags

- `VISIBLE` (shows on the `MenuItem`), and
- `LOCKED` (can’t be remapped on the fly).

### ModifierType

- `SHIFT_MASK` (Shift key),
- `LOCK_MASK` (usually the Caps Lock key),
- `CONTROL_MASK` (Control Key), and
- `MOD1_MASK` (usually the Alt key).

We’ll get to their use in a moment, but right now let’s take a quick look at…

## The AccelGroup

Because all accelerator keys are used when the `Window` has focus, the `AccelGroup` needs to be declared in, instantiated in, and added to the `Window` object:

{% highlight d %}
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
{% endhighlight %}

Notice also that it gets passed to the `AppBox` constructor which passes it along to the `MyMenuBar` constructor, then `FileMenuHeader`, `FileMenu`, `EditMenu`, etc. down the line until it’s available to each individual `MenuItem` constructor like this:

{% highlight d %}
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
{% endhighlight %}

A less cumbersome way to do this would be with a singleton, but we'll have that discussion next week.

*Another thing to note: Instead of connecting the callback here, we pass it to the super-class. I left the `addOnActivate()` line there—just commented out—as a reminder. Naturally, you can un-comment it to see what happens.*

## What are all those Arguments?

The major departure from earlier examples is, as mentioned, the call to the super-class. One by one, they are...

### Delegate

This is exactly the same argument we would pass to a signal hook-up function, which is the name of the callback function, preceded by an ampersand (&).

{% highlight d %}
	void delegate(MenuItem) dlg
{% endhighlight %}

In this case, it's: `&doSomething`.

### Label

This is the text that’ll appear on the `MenuItem`:

{% highlight d %}
	string label
{% endhighlight %}

And for us (have a look at the initialization section of this class) it ends up being `"Exit"`.

### Action

This next argument takes the place of assigning a signal when dealing with a `MenuItem`:

{% highlight d %}
	string action
{% endhighlight %}

I can think of no reason to use any signal other than `“activate”`... although you might. (And if you do, please post about it either on [the D Language forum](https://forum.dlang.org/) or [the GtkD forum](https://forum.gtkd.org/groups/GtkD/) so we can all add a new technique to our toolbox.)

### Mnemonic

No need to get deep here, just set this to `true`:

{% highlight d %}
	bool mnemonic
{% endhighlight %}

### AccelGroup

This is what we passed down from the `RigTestWindow`, the object that connects all the keyboard shortcuts to the application's `Window`:

{% highlight d %}
	AccelGroup accelGroup
{% endhighlight %}

### The Keyboard Shortcut Itself

This is the letter key used in combination with `ModifierType` (the next argument) to designate the entire keyboard shortcut:

{% highlight d %}
	char accelKey
{% endhighlight %}

And for our example here, it's `'x'`.

### ModifierType

This decides which qualifier key is held while pressing the letter key:

{% highlight d %}
	ModifierType.<MODIFIER>
{% endhighlight %}

These take the form of `ModifierType.CONTROL_MASK` or `ModifierType.SHIFT_MASK` and can be **OR**’ed together like this: `ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK | ModifierType.MOD1_MASK` if you want someone to hold down **Ctrl-Alt-Shift-KEY**. We looked at the possible values for `ModifierType` right at the beginning of this post (in case you need to refer back).

### AccelFlags

And lastly, the `AccelFlags` argument:

{% highlight d %}
	AccelFlags.VISIBLE
{% endhighlight %}

This flag is optional and you can actually leave it out. It's main use seems to be `AccelFlags.LOCKED` which is used when you don’t want users messing with your shortcut keys.

## Conclusion

So, yeah, it takes a bit of extra coding to make these work:

- from stuffing an `AccelGroup` into your main `Window`,
- passing it all the way down to the `MenuItem` objects so they have access when they instantiate, and
- coming up with that long list of arguments to pass to the super-class constructor.

But your users will thank you. And speaking of thanks...

Thanks for reading and do please come back for the next post. Until then...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/30/0031-imagemenuitem.html">Previous: ImageMenuItem</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/07/0033-fake-image-menu-and-accel.html">Next: Fake ImageMenuItem</a>
	</div>
</div>
