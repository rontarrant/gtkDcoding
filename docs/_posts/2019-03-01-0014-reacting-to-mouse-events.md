# 0014 Reacting to Mouse Events

Now we start down the road toward full control of what happens when the user fiddles with mouse buttons. Sometimes we want to trigger something when a mouse button is pressed, but other times (more often, really) we want to react when the mouse button is released. This is the accepted norm in most GUI designs, so let’s not rock the boat until we have good reason to. And today, we have no excuse.

We’ve gone back to an unadorned `TestRigWindow` for this series of examples because this isn’t about Button buttons, it’s about mouse buttons. To avoid any possible confusion when I say ‘button,’ I don’t want any buttons in the GUI and that way I won’t get mixed up… and neither will you.

Today's files:

- [Mouse Button PRESS example](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_01_press.d), and
- [Mouse Button RELEASE example](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_02_release.d).

## Some New Imports

Yeah, I’m not talking about this year’s Volvo or Toyota, but import statements… these, to be exact:

	import gdk.Event;
	import gtk.c.types;

We’ve seen the first one before, but I’ve included it here to remind everyone that it’s imported from the `gdk` side of things, not `gtk`.

The second one we need so we have access to the `GdkEventType` types. With these, we can pick what we’re going to react to:

- buttons being pressed,
- buttons being released,
- the motion of the mouse pointer,
- key presses and releases,
- changes in focus,
- changes in keymaps…

…all kinds of things. They give us a serious amount of control to pass along to the user.

## Changes to the TestRigWindow Class

First, let’s look at the constructor:

	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		addOnButtonPress(&onMousePress);
		
		showAll();
		
	} // this()

The change of note is the call to `addOnButtonPress()`. This hooks our `onMousePress()` function to the `BUTTON_PRESS` event.

And that function looks like this:

	public bool onMousePress(Event event, Widget widget)
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* mouseEvent = event.button;
			pressReport(mouseEvent.button);
			value = true;
		}

		return(value);
		
	} // onMousePress()

Notice the function definition. We’re not returning a void, but a Boolean. And the arguments have changed, too. We’re passing in an event as well as the originating `Widget`, in this case it’s the Window underlying our `TestRigWindow` derivative.

We make sure we’ve actually got a new `Event` to play with, then dig into it to find its type. The only one we want to react to is `BUTTON_PRESS`. And which button was pressed? To find out, we dig a little deeper. Each `Event` carries with it a field identifying whatever bit of hardware was manipulated to cause the event.

All that stuff about a value that’s returned from this function has to do with signal chains which we covered in [blog post #0011 Callback Chains](http://gtkdcoding.com/2019/02/12/0011-callback-chains.html). Once the event has been handled, we tell `Main` we’re done handling signals and back away.

## But, wait, There’s more...

You’ve likely noticed the call to pressReport() and here’s that function:

	void pressReport(uint mouseButtonNumber)
	{
		writeln("Button # ", mouseButtonNumber, action);

	} // pressReport()

I put this in here mostly to illustrate that mouse buttons are identified by *unsigned integers*, something we may need to know sometime down the road.

And that variable *action*? It’s a string defined at the top of `TestRigWindow`. Here is a list of the variables defined there:

	string title = "Test Rig";
	string buy = "Bye";
	string action = " was pressed.";

Nothing out of the ordinary except for the playful misspellings.

## Conclusion

Next time, we’ll dig into some more mouse events. Until then, happy D-coding and may the `Widgets` be with you.

