---
title: "0107: D Snippets III - A Practical Observer"
layout: post
topic: dlang
tag: dlang
description: This GTK Tutorial covers a D-specific implementation of the Observer pattern.
author: Ron Tarrant

---

# 0107: D Snippets III - A Practical Observer

Last time, we started with a look at a generic example of an *Observer* pattern. This time, we’ll pick apart a more practical example in which multiple *Observers*—a `Button`, an `Image`, and an `Entry`—change their state depending on the state of a watched object.

## The Observer at Work

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/021_oop/oop_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/021_oop/oop_04_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/021_oop/oop_04_checkbutton_observer.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

The challenge here is that the watched object needs to see all widgets as being a common type. We've got a `Button`, an `Entry`, and an `Image`, so if we write the `addObserver()` function to accept a `Button`, it’s going to have a fit if we pass it anything else. If we, instead, write it to accept a widget (the common ancestor of `Button`, `Image`, etc.) we don’t gain anything because we still have no mechanism for adding an `update()` function to each of the widgets.

Further, that `update()` function has to take on a form that’s useful for each widget type. Here's what it has to do:

- for the `Button` we need to change the label text which requires calling `setLabel()`,
- for obfuscating text in an `Entry`, we need to call `setVisibility()`, and
- to switch the graphic displayed in an `Image` widget, we need to call `setFromFile()`.

These functions aren’t interchangeable, so `update()` needs to be generic at some level so it can take specific action(s) for each widget we add it to.

What do we do? This is *OOP 101*. We make *Observer* an `interface` so we can:

- have all observing widgets inherit from the *Observer* `interface`,
- define an empty `update()` function within the `interface` which forces each inheriting widget to implement its own version of it, and
- cast all widgets to type *Observer* as we add them to the list of *Observers* so we don’t need to write an override for each widget type.

Casting everything to *Observer* like this works because the only commonality we need between *Observers* is the `update()` function and that's what's provided by the *Observer* interface.

### The Observer Interface

So, here’s what our *Observer* now looks like:

```d
interface Observer
{
	void update(bool value);
	
} // interface Observer
```

We just need to tell it what we expect for arguments and a return value for the `update()` function and that’s that.

Now let’s take a look at the watched object so we have some idea of the requirements of the `update()` function.

### The WatchedButton

Here’s the code:

```d
class WatchedButton : CheckButton
{
	string buttonText = "Switch Output";
	Observer[] observers;
	
	this()
	{
		super(buttonText);
		addOnClicked(&updateAll);
		
	} // this()
	
	
	void addObserver(Observer observer)
	{
		observers ~= observer;
		
	} // addObserver()
	
	
	void updateAll(Button b)
	{
		foreach(observer; observers)
		{
			observer.update(getActive());
			
		}
		
	} // updateAll()

} // class WatchedButton
```

The first thing you may notice is that the `change()` function is gone. We don’t need it because, instead, we’re hooking up the `updateAll()` function to the `onClicked` signal. Whenever the state of the `CheckButton` changes, `updateAll()` runs through the list of observers, calls `update()` for each, and passes along the current state of the `CheckButton`.

Now let’s look at one of the Widgets that will hear from the watched object.

### The ObserverButton - Preamble

Firstly, what’s going to react to the changing state of the watched object? Let’s make it really obvious and change the label text. For this, we can use a string array. And let's make things simple by pairing the zeroth element with the `CheckButton`’s `false` state and the first element with `true`, 0 for 0, 1 for 1:

```d
string[] labels = ["Take Action", "Don't Take Action"];
```

Naturally, one of these will need to be selected as the default and we take care of that in...

### The ObserverButton – Constructor

This is also short-n-sweet:

```d
this()
{
	super(labels[0]);
	addOnClicked(&doSomething);
		
} // this()
```

We set our default label and hook up the `Button`’s callback. Now, the callback will do something different based on which label is current, but we’ll get to that momentarily. First, let’s look at...

### The ObserverButton – update() Function

This is the locally-implemented version of the `update()` function we declared in the *Observer* interface. This is where we change the label text.

```d
void update(bool state)
{
	setLabel(labels[state]);
		
} // updateSubjectState()
```

### The ObserverButton – doSomething() Function

Okay, here it is:

```d
void doSomething(Button b)
{
	string message;

	if(getLabel() == labels[0])
	{
		message = "These aren't the droids you're looking for.";
	}
	else
	{
		message = "These aren't droids. They're monkeys in tin suits.";
	}

	writeln(message);
		
} // doSomething()
```

Based on which of the two label strings is current, we spit out a different terminal message.

Now, let’s take a quick look at how the other *Observer*-derived objects implement the `update()` function...

### ObserverEntry

We take the incoming state of the `CheckButton` and flip it so that `true` becomes `false` and vise versa:

```d
void update(bool state)
{
	state = !state;
	setVisibility(state);
		
} // update()
```

This way, visibility is turned on when the `CheckButton` is unchecked.

### ObserverImage

In the preamble we define two image paths and then write `update()` like this:

```d
void update(bool state)
{
	if(state == true)
	{
		current = monkey;
	}
	else
	{
		current = robot;
	}

	setFromFile(current);
		
} // update()
```

We hop back and forth between the two image paths, then use `setFromFile()` to make the switch.

## Conclusion

And there you have it. Each *Observer*-derived class/object deals with the state of `CheckButton` in its own way.

Next time, we’ll take a look at how to handle a list of widgets using *D*-style arrays. Sounds easy, right? We’ll see.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/04/03/0106-dlang-ui-snippets-ii.html">Previous: D Snippets II - Generic Observer</a>
	</div>

	<div style="float: right;">
		<a href="/2020/04/25/0108-snippets-iv-arrays.html">Next: Arrays in UI</a>
	</div>
</div>
