---
title: "0105: D Snippets I - Observer vs. Singleton"
layout: post
topic: snippets
description: This GTK Tutorial covers ghosting and disabling a Widget.
author: Ron Tarrant

---

# 0105: D Snippets I - Observer vs. Singleton

When it comes to building a UI, it isn’t always about the Widgets. Often, you need to find ways to handle Widgets in non-Widget-y ways just to keep things manageable.

For instance, over the last year, I’ve touched on a few design patterns—sometimes, quite sloppily—while incorporating such things as OS detection, accelerator keymaps, fonts, and groups of Widgets such as `Radio`- or `ToggleButton`s.

So, we’ll start off with a couple of more strictly-built (read: adhering more to the strict definitions) design patterns and, over the next while, we’ll go over other bits of *D*-specific code that will help in various ways when building a UI. So, without further ado, let’s dig in...

## Singleton vs. Observer

First, what’s the difference between the two?

The *Singleton* assures us that we have one instance of an object. Because of the way the *Singleton* is structured, no matter how many times we create new pointers to it, they'll always point to the same *Singleton*.

The *Observer*, on the other hand, allows a single object to be monitored by multiple other objects.

In both cases, we’re talking about a one-to-many relationship—one Singleton with multiple pointers... one object monitored by multiple others. The difference from a number-of-objects point of view is the *direction* of the one-to-many relationship.

Another difference can be found by thinking about the definition of the *Observer* pattern—a single object is monitored by multiple others. Why do they need to monitor it? Because the observed object is dynamic. It changes over the lifetime of the application.

The *Singleton*, on the other hand, remains static. That's why we see use cases such as a print spooler, a window manager, a font list, or other OS-specific stuff. In other words, things we expect to remain static during the application’s lifetime.

So in a nutshell, a *Singleton* is used to encapsulate a *static* resource and *Observers* encapsulate objects that keep an eye on a *dynamic* resource.

The rest of this post will first present the general specs for a *Singleton* in *D*, then look at a working example.

## The Singleton – a Generic Example

Note: There is no UI for this example. You’ll have to run it in a terminal.

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-terminal">
		<figure class="right">
			<img id="img1" src="/images/screenshots/021_oop/oop_021_02_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/021_oop/oop_021_02_singleton.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Here’s what the `DSingleton` preamble looks like:

```d
class DSingleton
{
	private:
	// Cache instantiation flag in thread-local bool
	static bool instantiated_;

	// Thread global
	__gshared DSingleton instance_;
```

These two properties work together to make the *Singleton* thread-safe. In essence, they allow us to work with the *Singleton* whether we're working with a single- or multi-threaded application. The mechanism is a bit more complex than that, but for our purposes, this is deep as we need to dig.

Next, the constructor...

```d
this() {}
```

In other words, we don’t really have a constructor. It won't always be empty, but for this demo, we don't need it to do anything. (In our next example, it'll be used for setting a static variable.)

Note also that the constructor definition is in the part of the class marked private which means no outsider can call it. Why? Because the work of the constructor should only be carried out once during the life of the application and we don't want anyone calling it by accident and screwing up our nefarious plan. And why don't we want anyone to call it?

Besides, we don't instantiate the `DSingleton` with a direct call to the constructor. We pass all requests for instantiation through a getter instead:

```d
static DSingleton get()
{
	if(!instantiated_)
	{
		synchronized(DSingleton.classinfo)
		{
			if(!instance_)
			{
				instance_ = new DSingleton();
				write("Creating the singleton and");
			}

			instantiated_ = true;
		}
	}
	else
	{
		write("Singleton already exists, so just");
	}

	writeln(" returning an instance.");
		
	return(instance_);
		
} // get()
```

All those writeln() calls are there just as proof that the system works. They can be safely axed when you're doing a production-ready *Singleton*.

Wherever your code needs access to the *Singleton*, you start by calling `get()`. In the guts of the `get()`, there’s a bit of *D*-language hocus pocus going on to assure that multi-threaded applications won't end up with a new *Singleton* in every thread. It checks to see if an instance of the *Singleton* already exists either locally (in the current thread) or globally (in any possible thread) before deciding whether or not to create one.

### The getInstance Function

Don't let the name fool you. This isn't another getter:

```d
DSingleton* getInstance()
{
	writeln("the Singleton instance at ", &instance_);
	return(&instance_);

} // getInstance()
```

It spits out the *address of the pointer* to the *Singleton* and then returns the *address of the Singleton* itself so we know, even though we may have multiple pointers to the `DSingleton` scattered throughout our code, they all point to the same instance of the `DSingleton`.

## The Singleton at Work

*Note: As with the last example, there is no UI for this. You’ll have to run it in a terminal.*

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-terminal">
		<figure class="right">
			<img id="img3" src="/images/screenshots/021_oop/oop_021_03_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/021_oop/oop_021_03_os_detection.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

Detecting the user’s OS—something that’s definitely not expected to change while the application is running—is a quintessential example of the *Singleton* at work.

How we get from the generic example to this specific one comes down to this:

- add a `string` property in the preamble to store the OS type,
- add code to the constructor that detects and stores the OS type, and
- because `getInstance()` is really just for testing purposes, replace it with `getOS()`.

It’s also a good idea to rename the *Singleton* to reflect what we’re dealing with. (Don't forget to edit all those places in the code where we refer to it by name.)

So, all that boils down to:

- change the name from `DSingleton` to `S_DetectedOS` (I'm here using the leading ‘S’ as a naming convention to indicate this is a *Singleton* class/object),
- edit all references to `DSingleton` throughout the code to reflect the name change,
- add the property string `_os_type`, and
- rewrite the constructor to set this new variable:

```d
this()
{
	version(Windows)
	{
		_os_type = "Windows";
	}
	else version(OSX)
	{
		_os_type = "OSX";
	}
	else version(Posix)
	{
		_os_type = "Posix";
	}

} // this()
```

The `version()` function, if you hadn't guessed, is *D*'s way of finding out which OS it's running on.

Our replacement for `getInstance()`—because we really don't care about the address of the *Singleton* as long as it does its job—looks like this:

```d
string getOS()
{
	return(_os_type);
		
} // getOS()
```

## Conclusion

Next time, we’ll start by taking a closer look at the *Observer*.

Until then, happy coding.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/03/12/0104-widget-opacity-ii.html">Previous: Widget Opacity II</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/04/03/0106-dlang-ui-snippets-ii.html">Next: D Snippets II - A Generic Observer</a>
	</div>
-->
</div>
