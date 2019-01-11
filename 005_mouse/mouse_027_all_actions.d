// the window itself is sensitive to mouse button clicks.
// distingish between left, middle, and right mouse buttons
// also track where the mouse is within the window.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;                                               // *** NEW ***

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnButtonPress(&onButtonPress);                           // *** NEW ***
		addOnButtonRelease(&onButtonRelease);                       // *** NEW ***
		addOnMotionNotify(&onMotion);                               // *** NEW ***
		addOnScroll(&onScroll);                                     // *** NEW ***
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	public bool onScroll(Event event, Widget widget)               // *** NEW ***
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
	

	public bool onMotion(Event event, Widget widget)               // *** NEW ***
	{
		if(event.type == EventType.MOTION_NOTIFY)
		{
			writeln("x = ", event.motion.x, " y = ", event.motion.y);
		}

		return(true);
		
	} // onMotion()
		
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()


	public bool onButtonPress(Event event, Widget widget)          // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				rightPress();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middlePress();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftPress();
				value = true;
			}
		}

		return(value);
		
	} // onButtonPress()


	public bool onButtonRelease(Event event, Widget widget)        // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				rightRelease();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middleRelease();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftRelease();
				value = true;
			}
		}

		return(value);
		
	} // onButtonRelease()


	void leftPress()                                            // *** NEW ***
	{
		writeln("Left Button pressed.");

	} // leftPress()


	void middlePress()                                            // *** NEW ***
	{
		writeln("Middle Button pressed.");
		
	} // middlePress()


	void rightPress()                                            // *** NEW ***
	{
		writeln("Right Button pressed.");
		
	} // rightPress()


	void leftRelease()                                            // *** NEW ***
	{
		writeln("Left Button released.");
		
	} // leftRelease()


	void middleRelease()                                            // *** NEW ***
	{
		writeln("Middle Button released.");
		
	} // middleRelease()


	void rightRelease()                                            // *** NEW ***
	{
		writeln("Right Button released.");
		
	} // rightRelease()

} // class myAppWindow
