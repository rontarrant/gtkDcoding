# 0011 Callback Chains

I mentioned in post #0008 that we’d look at callback chains and here we are. In blog entry #0010, I covered setting up an observer pattern. Today we’ll have a bit of fun combining these two. All this code should seem quite familiar, so no need to fasten your seatbelt.

First, we’ll look at how multiple signals are chained together. It’s nothing fancy, just a few extra lines of code in the constructor of our derived button class:

	this(string[] args)
	{
		super(label);
	
		addOnClicked(&clickReport);
		addOnButtonRelease(&takeAction);
		addOnButtonRelease(delegate bool(Event e, Widget w) { showArgs(args); return(true); });
		
	} // this()

No big deal. All you gotta do is tack on a bunch of signals. You can even, as done above, mix and match the callback definitions to suit your needs.

But now let’s get to the interrupt-y bit…

[Here is the code file](https://github.com/rontarrant/gtkDcoding/blob/master/002_button/button_002_08_multiple_signals.d). 

## A Refresher

Callbacks with Boolean return values allow us to hook multiple signals into a chain with the added bonus of choosing whether or not to interrupt the chain. Here are the rules again:

- return(true): stop processing callbacks and return to the main loop, and
- return(false): more callbacks to come, keep going.

## Another Refresher

An observer pattern lets one widget keep an eye on another and change its own behaviour based on the state of the other widget.

## The Code

This time around, the `ObserverButton` keeps an eye on a `WatchedButton` derived from the `ToggleButton` class, very much like in did in the companion code for *blog entry #0010*. But the constructor is busier:

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

## The Callbacks

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

## Are we done yet?

Yeah, for now, I think so. Happy D-coding and may the moon shine bright on your widgets tonight.

