---
title: "0016: Scroll Wheel and More Button Stuff"
topic: mouse
layout: post
description: Getting feedback from the mouse's scrollwheel in GTK - a D language tutorial.
author: Ron Tarrant

---

## 0016 - Scroll Wheel and More Button Stuff

Time to get down to the nitty gritty of harnessing the mouse wheel with [Mouse Scroll Wheel example](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_05_scroll_wheel.d).

Got a 3D object you need to zoom in on? How about lines and lines of text that need to be scrolled through? Yeah, that’s what we’re laying groundwork for today. Here’s the constructor:

	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse wheel scrolling
		addOnScroll(&onScroll);
		
		// Show the window and its contents...
		showAll();
		
	} // this()

This should be pretty familiar by now, hook up a signal to a callback using one of the `addOnXxxxx()` functions, in this case `addOnScroll()` and here’s the callback:

	public bool onScroll(Event event, Widget widget)
	{
		bool value = false; // assume no scrolling
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			value = true;
			writeln("scrolling down...");
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			value = true;
			writeln("scrolling up...");
		}

		return(value);

	} // onScroll()

Again, we have to dig a bit to find the data we want: the direction the mouse wheel is turning. The `ScrollDirection` *enum* in `gtk.c.types` (that’s *generated/gtkd/gtk/c/types.d* if you want to see for yourself) provides us with `UP` and `DOWN` so we can check. Makes it easy. I’ve added in a bit of return value roughage so we know for sure we’re done with any signal chain that might end up being processed at the same time.

### Left, Middle, Right

Let’s throw caution to the wind and put a `Button` back in the window, just one, and give it something interesting to do…

When I was writing out these examples, I’d forgotten I’d already talked about differentiating between mouse buttons, so I wrote [a second one](https://github.com/rontarrant/gtkDcoding/blob/master/005_mouse/mouse_005_06_left_middle_right.d). This one, though, does process things in a different way:

	public bool onButtonRelease(Event event, Widget widget)
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			mouseRelease(buttonEvent.button);

			value = true;
		}

		return(value);
		
	} // onButtonRelease()

From here, you could look at the button data, a *uint*, to see which button was pressed. We handle this with the `mouseRelease()` function:

	void mouseRelease(uint mouseButton)
	{
		writeln("The ", mouseButtons[mouseButton], " was released.");
		
	} // mouseRelease()

Which translates the *uint* to plain English using the `mouseButtons` array defined at the top of the `MyLMRButton` class:

	string[] mouseButtons = ["None", "Left", "Middle", "Right"];

You may wonder why there’s a `“None”` element in this array, but it’s there because there is no mouse button #0. It keeps us from having to subtract ‘1’ each time to find our way to the correct array element.

And so we come to the end of another blog post. Be kind to each other and we’ll talk again soon.


<BR>
<div style="float: left;">
	<a href="https://gtkdcoding.com/2019/03/05/0015-enter-leave.html">Previous: Entering and Leaving</a>
</div>
<div style="float: right;">
	<a href="https://gtkdcoding.com/2019/03/12/0017-change-pointer.html">Next: Mouse Pointer</a>
</div>
<BR>
