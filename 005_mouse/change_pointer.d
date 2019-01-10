// change the mouse pointer to a different shape depending on which button it's on

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;                                                             // *** NEW ***
import gdk.Cursor;                                                              // *** NEW ***
import gtk.Layout;

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
		
		// First, let's resize the window for esthetics.
		setSizeRequest(184, 254);                                                 // *** NEW ***
		
		// create an array of buttons
		// and because they're widgets at heart, we can declare the button array
		// as an array of widgets. We could also have made this an array of buttons,
		// but it's good to know just how far up the ancestor tree we can go.
		HandButton handButton = new HandButton("Hand Over");                      // *** NEW ***
		HeartButton heartButton = new HeartButton("Heart Over");                  // *** NEW ***
		GumbyButton gumbyButton = new GumbyButton("Gumby Over");                  // *** NEW ***
		Widget[] buttons = [handButton, heartButton, gumbyButton];                // *** NEW ***
		
		// create the layout, passing in the array of buttons so they can be placed.
		Layout myLayout = new MyLayout(buttons);                                  // *** NEW ***
		add(myLayout);  // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class myAppWindow


class MyLayout : Layout                                           // *** NEW ***
{
	this(Widget[] buttons)
	{
		super(null, null);
		
		int x = 40, y = 20;
		
		foreach(button; buttons)
		{
			put(button, x, y);
			y += 80;
		}

	} // this()
	
} // class MyLayout


class HandButton : Button                                         // *** NEW ***
{
	this(string title)
	{
		super(title);
		addOnEnterNotify(&onEnter);
		addOnLeaveNotify(&onLeave);
		
	} // this()
	

	public bool onEnter(Event event, Widget widget)
	{
		bool value = false;
		
		Cursor myCursor = new Cursor(CursorType.HAND1);
		setCursor(myCursor);

		return(value);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		bool value = false;
		
		resetCursor();

		return(value);
		
	} // onLeave()

} // class HandButton


class GumbyButton : Button                                        // *** NEW ***
{
	this(string title)
	{
		super(title);
		addOnEnterNotify(&onEnter);
		addOnLeaveNotify(&onLeave);
		
	} // this()
	

	public bool onEnter(Event event, Widget widget)
	{
		bool value = false;
		
		Cursor myCursor = new Cursor(CursorType.GUMBY);
		setCursor(myCursor);

		return(value);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		bool value = false;
		
		resetCursor();

		return(value);
		
	} // onLeave()

} // class GumbyButton


class HeartButton : Button                                        // *** NEW ***
{
	this(string title)
	{
		super(title);
		addOnEnterNotify(&onEnter);
		addOnLeaveNotify(&onLeave);
		
	} // this()
	

	public bool onEnter(Event event, Widget widget)
	{
		bool value = false;
		
		Cursor myCursor = new Cursor(CursorType.HEART);
		setCursor(myCursor);

		return(value);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		bool value = false;
		
		resetCursor();

		return(value);
		
	} // onLeave()

} // class HeartButton
