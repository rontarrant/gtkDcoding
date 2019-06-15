// the window itself is sensitive to mouse button clicks.
// distingish between left, middle, and right mouse buttons
// also track where the mouse is within the window.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

// Note: EventType flags are found in gtk.c.types

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Tracking Mouse Stuff";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking and other stuff
		addOnButtonPress(&onButtonPress);
		addOnButtonRelease(&onButtonRelease);
		addOnMotionNotify(&onMotion);
		addOnScroll(&onScroll);
	
		showAll();
		
	} // this()


	public bool onScroll(Event event, Widget widget)
	{
		bool returnValue = false; // assume no scrolling
		string[] scrollMessage = ["scrolling up", "scrolling down"];
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			returnValue = true;
			
			// this implies that ScrollDirection.DOWN = 0
			writeln(scrollMessage[ScrollDirection.DOWN], "...");
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			returnValue = true;

			// this implies that ScrollDirection.UP = 1
			writeln(scrollMessage[ScrollDirection.UP], "...");
		}

		return(returnValue);

	} // onScroll()
	

	public bool onMotion(Event event, Widget widget)
	{
		if(event.type == EventType.MOTION_NOTIFY)
		{
			writeln("x = ", event.motion.x, " y = ", event.motion.y);
		}

		return(true);
		
	} // onMotion()
		
	
	public bool onButtonPress(Event event, Widget widget)
	{
		bool returnValue = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			mousePress(buttonEvent.button);

			returnValue = true;
		}

		return(returnValue);
		
	} // onButtonPress()


	public bool onButtonRelease(Event event, Widget widget)
	{
		bool returnValue = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			mouseRelease(buttonEvent.button);

			returnValue = true;
		}

		return(returnValue);
		
	} // onButtonRelease()


	void mousePress(uint buttonNumber)
	{
		writeln("Button #", buttonNumber, " was pressed.");

	} // mousePress()


	void mouseRelease(uint buttonNumber)
	{
		writeln("Button #", buttonNumber, " was released.");
		
	} // mouseRelease()


	void quitApp()
	{
		string byeBye = "Bye, bye";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class TestRigWindow
