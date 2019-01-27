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
	
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, bye";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnButtonPress(&onButtonPress);                           // *** NEW ***
		addOnButtonRelease(&onButtonRelease);                       // *** NEW ***
		addOnMotionNotify(&onMotion);                               // *** NEW ***
		addOnScroll(&onScroll);                                     // *** NEW ***
	
		showAll();
		
	} // this() CONSTRUCTOR


	public bool onScroll(Event event, Widget widget)               // *** NEW ***
	{
		bool value = false; // assume no scrolling
		string[] scrollMessage = ["scrolling up", "scrolling down"];
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			value = true;
			writeln(scrollMessage[ScrollDirection.DOWN], "..."); // this implies that ScrollDirection.DOWN = 0
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			value = true;
			writeln(scrollMessage[ScrollDirection.UP], "..."); // this implies that ScrollDirection.UP = 1
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
		
	
	public bool onButtonPress(Event event, Widget widget)          // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			mousePress(buttonEvent.button);

			value = true;
		}

		return(value);
		
	} // onButtonPress()


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


	void mousePress(uint buttonNumber)
	{
		writeln("Button #", buttonNumber, " was pressed.");

	} // mousePress()


	void mouseRelease(uint buttonNumber)                                            // *** NEW ***
	{
		writeln("Button #", buttonNumber, " was released.");
		
	} // mouseRelease()


	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class myAppWindow
