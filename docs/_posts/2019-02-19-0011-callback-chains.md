---
title: "0011: Callback Chains"
topic: button
layout: post
description: How GTK signals are chained together - a D language tutorial.
author: Ron Tarrant

---

## 0011 - Callback Chains

I mentioned in [post #0008](http://gtkdcoding.com/2019/02/08/0008-callbacks.html) that we’d look at callback chains and here we are. In blog [entry #0010](http://gtkdcoding.com/2019/02/15/0010-checkbutton.html), I covered setting up an observer pattern. Today we’ll have a bit of fun combining these two. All this code should seem quite familiar, so no need to fasten your seat belt. However, there is a surprise in store, so you still might wanna hold onto your hat...

First, we’ll look at how multiple signals are chained together. It’s nothing fancy, just a few extra lines of code in the constructor of our derived button class:

	this(string[] args)
	{
		super(label);
	
		addOnClicked(&onClicked);
		addOnPressed(&onPressed);
		addOnReleased(&onReleased);
		addOnButtonRelease(&onRelease);
		addOnButtonRelease(delegate bool(Event e, Widget w) { showArgs(args); return(false); });
		
	} // this()

No big deal. All you gotta do is tack on a bunch of signals. You can even, as done above, mix and match the callback definitions to suit your needs.

But now let’s get to the interrupt-y bit…

[Here is the code file](https://github.com/rontarrant/gtkDcoding/blob/master/002_button/button_002_08_multiple_signals.d). 

### A Refresher

Callbacks with *Boolean* return values allow us to hook multiple signals into a chain with the added bonus of choosing whether or not to interrupt the chain. Here are the rules again:

- `return(true)`: stop processing callbacks and return to the main loop, and
- `return(false)`: more callbacks to come, keep going.

But here's the surprise...

### Signal Handling Order

If you look at the order in which the callback signals are hooked up, you'll see:

- `onClicked`,
- `onPressed`,
- `onReleased`,
- `onButtonRelease`, and
- `onButtonRelease` again.

Further, notice that the first three are defined as being void, but the last two return *Boolean* values.

And when you run the example, you'll find the signals fire, *NOT* in the order they're defined in, but in this order:

- `onPressed`,
- `onButtonReleased` (1),
- `onButtonReleased` (2),
- `onClicked`, and
- `onRelease`.

And that's because for each event, all Boolean value signals fire first and void signals fire last. Here are the events:

- a button is pressed,
- a button is released.

So only one signal is hooked up to the first event (`onPressed`), three are hooked up to the second (`onRelease`). But what about `onClicked`? Well, the answer there is that it can't fire until completion of the event that triggers it and that event is the `Button` being pressed *and* released. And the `onRelease` signal fires last because of all the signals with void return values, it's hooked up last.

Now let's move on to example #2...

## Observed and Observer `Button`s with Signals

[Here's the second code file](https://github.com/rontarrant/gtkDcoding/blob/master/003_box/box_003_05_signal_chain.d).

### Another Refresher

An observer pattern lets one widget keep an eye on another and change its own behaviour based on the state of the other widget.

### The Code

This time around, the `ObserverButton` keeps an eye on a `WatchedButton` derived from the `ToggleButton` class, very much like it did in the companion code for [entry #0010](http://gtkdcoding.com/2019/02/15/0010-checkbutton.html). But the constructor is busier:

	this(WatchedButton extWatched)
	{
		super(label);
		watchedButton = extWatched;
		addOnButtonRelease(&takeAction);
		addOnButtonRelease(&outputSomething);
		addOnButtonRelease(&clickReport);
		addOnButtonRelease(&endStatement);

	} // this()

Lots of signals being hooked up. We’re keeping the hook-ups simple so we don’t get bogged down in details unnecessary to the objective, to interrupt the signal chain.

### The Callbacks

The first two callbacks do pretty standard things. They write messages to the command shell. It’s when we get to the third callback, `takeAction()`, that we see something interesting.

	bool takeAction(Event event, Widget widget)
	{
		bool continueFlag = true;
		
		writeln("Action was taken.");
		
		if(watchedButton.getMode() == true)
		{
			continueFlag = false;
			writeln("A value of 'false' keeps the signal chain going.");
		}
		else
		{
			continueFlag = true;
			writeln("A value of 'true' tells the chain its work is done.\n");
		}

		return(continueFlag);
		
	} // takeAction()

This is where the signal chain gets interrupted. We check the `WatchedButton` (remember, it’s a `ToggleButton` at heart) to see what its mode is. If the toggle is on, we change `takeAction()`’s return value to false. If it’s off, we change `takeAction()`’s return value to true. It almost seems backwards returning `false` if we’re not done with the signal chain, but the extra little message printed out for each mode state should help you clarify this in your mind. 

Now take a look at this one (it should be no trouble to work out what’s going on here):

	bool outputSomething(Event event, Widget widget)
	{
		write("observedState = ", watchedButton.getMode(), ": ");
		
		if(watchedButton.getMode()) // if it's 'true'
		{
			writeln("Walls make good neighbours, eh.");
		}
		else
		{
			writeln("Berlin doesn't like walls.");
		}

		return(false);
		
	} // outputSomething()

Again, the state of the underlying `ToggleButton` is checked and this time, we spit out a different message depending on what mode state we find.

The `WatchedButton` class, derived as it is from a `ToggleButton`, is almost identical to the one we used in the [ToggleButton example code](https://github.com/rontarrant/gtkDcoding/blob/master/003_box/box_003_04_togglebutton.d), so no need to go over that.

### Are we done yet?

Yeah, for now, I think so. Happy D-coding and may the moon shine bright on your widgets tonight.


<BR>
<div style="float: left;">
	<a href="/2019/02/15/0010-checkbutton.html">Previous: CheckButton</a>
</div>
<div style="float: right;">
	<a href="/2019/02/22/0012-layout-containers.html">Next: Layout Containers</a>
</div>
<BR>
