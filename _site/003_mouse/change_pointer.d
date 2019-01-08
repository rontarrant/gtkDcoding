// Test Rig Foundation for Learning GtkD Coding
// distingish between left, middle, and right mouse buttons
// In this demo, the window itself is sensitive to mouse
// button clicks.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

////////////////////////////////////////
// Additional import statements START //
////////////////////////////////////////

import gtk.Button;
import gdk.Event;
import gtk.c.types;
import gdk.Cursor;
import gtk.Layout;

//////////////////////////////////////
// Additional import statements END //
//////////////////////////////////////

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	///////////////////////////////////////////////
	// Look in TestRigWindow class for Test Code //
	//////////////////////////////////////////////
	
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
		
		/////////////////////
		// TEST CODE START //
		/////////////////////

		// First, let's resize the window for esthetics.
		setSizeRequest(184, 254);
		
		// create an array of buttons
		// and because they're widgets at heart, we can declare the button array
		// as an array of widgets. We could also have made this an array of buttons,
		// but it's good to know just how far up the ancestor tree we can go.
		HandButton handButton = new HandButton("Hand Over");
		HeartButton heartButton = new HeartButton("Heart Over");
		GumbyButton gumbyButton = new GumbyButton("Gumby Over");
		Widget[] buttons = [handButton, heartButton, gumbyButton];
		
		// create the layout, passing in the array of buttons so they can be placed.
		Layout myLayout = new MyLayout(buttons);
		add(myLayout); 
		
		///////////////////
		// TEST CODE END //
		///////////////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class myAppWindow

	/////////////////////
	// TEST CODE START //
	/////////////////////

class MyLayout : Layout
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


class HandButton : Button
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


class GumbyButton : Button
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


class HeartButton : Button
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
