---
title: "0106: D Snippets II - A Generic Observer"
layout: post
topic: snippets
description: This GTK Tutorial covers a generic Observer pattern implemented in D.
author: Ron Tarrant

---

# 0106: D-language Snippets II - A Generic Observer

Picking up from last time...

We discussed the difference between the *Observer* and *Singleton* patterns, then took a closer look at both the generic *Singleton* and a specific example of the *Singleton* at work. This time, we’ll do the same thing with the *Observer*.

## The Observer Pattern

*Note: There is no UI for this example, just the output to the terminal.*

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-terminal">
		<figure class="right">
			<img id="img1" src="/images/screenshots/021_oop/oop_021_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/021_oop/oop_021_01_observer.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

And because there’s no UI, we’ll start with...

### The main() Function

All we do in `main()` is instantiate all the bits we need, then run the test a few times.

```d
void main()
{
	// initialize objects
	Subject subject = new Subject();
	Observer observer1 = new Observer("First Observer...", subject);
	Observer observer2 = new Observer("Second Observer..", subject);
	
	// change state
	foreach(int i; 0..4)
	{
		writeln("\nChanging state of Subject...");
		subject.change();
		observer1.reportState();
		observer2.reportState();
	}
	
} // main()
```

In the preamble, we instantiate three objects—one to be watched, and two others to do the watching. (Make sure to instantiate the subject of observation first.)

Next comes the heart of our demo, a loop that:

- toggles the state of the watched object between true and false a few times, and
- calls upon each of the *Observers* to tell us what they see.

The loop spits out proof that the dynamic between *Observers* and watched object is working.

### The Observer Class

Now we get into the actual *Observer* code, starting with the class named for the pattern:

```d
class Observer
{
	string idString;
	bool subjectState;
	
	this(string id, Subject subject)
	{
		idString = id;
		subject.addObserver(this);
		
	} // this()
	
	
	void reactToSubjectStateChange(bool newState)
	{
		subjectState = newState;
		
	} // reactToSubjectStateChange()
	
	
	void reportState()
	{
		writeln("Viewing from ", idString, ". The subject's state is now: ", subjectState);

	} // reportState()
	
} // class Observer
```

In the preamble we find an `ID`. It’s not strictly necessary for production-level code... unless you need to track which observer is watching at any given time. For a demonstration such as this, it can also give us proof that the mechanism is working.

In the `reactToSubjectStateChange()` function the `Observer`'s `subjectState` *Boolean* is the only thing we update, but it stands in for whatever housekeeping the *Observer* would ordinarily do when the watched object reports changes.

*Note: this function is never called by anything other than the watched object. This is because we only want an `Observer` to react to changes reported by the watched object... in other words, only when new information comes straight from the horse's mouth.*

Now let’s look at...

### The Subject/Watched/Observed Class

In a nutshell, any watched object will have:

- one or more dynamic properties,
- a mechanism for adding (and, in real-world use cases, perhaps, removing) *Observers*, and
- a second mechanism for reporting to the *Observers* any time a change takes place in one of its dynamic properties.

#### Preamble

```d
bool switcherState;
Observer[] observers;
```

So, as expected, we have a bit of data that the *Observers* want to track and an array that will hold a list of those *Observers*.

#### The Constructor

This constructor is pretty straightforward:

```d
this()
{
	switcherState = false;
	
} // this()
```

As can be seen, it just sets the initial state of the data.

#### The addObserver Function

```d
void addObserver(Observer observer)
{
	observers ~= observer;
	observer.reactToSubjectStateChange(switcherState);
	
} // addObserver()
```

Here we add a new *Observer* to the watched object’s list and get it up to speed right away as to the state of the `switcherState` property. If we had a bunch of properties that `Observer`s needed to be aware of, we can pass as many as necessary to the `reactToSubjectStateChange()` function. 

#### The updateAll Function

```d
void updateAll()
{
	foreach(observer; observers)
	{
		observer.reactToSubjectStateChange(switcherState);
			
	}
		
} // updateAll()
```

This steps through the list of *Observers* and informs them of the change. *Observers* can have different implementations of `reactToSubjectStateChange()` which allows each to react in its own unique way to changes in the watched object.

#### The change Function

And finally, we have:

```d
void change()
{
	if(switcherState == true)
	{
		switcherState = false;
	}
	else
	{
		switcherState = true;
	}
	
	updateAll();
	
} // change()
```

This is our change-for-change’s-sake function and is here for demonstration purposes only. It forces a change that the entire system then reacts to.

## Conclusion

This article is running long, so we’ll have to wait until next time to look over the *Observer* at work example.

Take care, and see you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/03/23/0105-dlang-ui-snippets-i.html">Previous: D Snippets I - Singleton vs. Observer</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/04/14/0107-dlang-ui-snippets-iii.html">Next: D Snippets III - Working Observer</a>
	</div>
-->
</div>
