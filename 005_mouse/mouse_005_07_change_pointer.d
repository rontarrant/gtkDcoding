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

// Note: CursorType flags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, bye.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// First, let's resize the window for esthetics.
		setSizeRequest(184, 254);                                                 // *** NEW ***
		
		Layout myLayout = new MyLayout();
		add(myLayout);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class TextRigWindow


class MyLayout : Layout                                           // *** NEW ***
{
	int x = 40, y = 20;
	Widget[] buttons;
	
	this()
	{
		super(null, null);
		
		// create an array of buttons
		// and because they're widgets at heart, we can declare the button array
		// as an array of widgets. We could also have made this an array of buttons,
		// but it's good to know just how far up the ancestor tree we can go.
		HandButton handButton = new HandButton();                      // *** NEW ***
		HeartButton heartButton = new HeartButton();                  // *** NEW ***
		GumbyButton gumbyButton = new GumbyButton();                  // *** NEW ***

		buttons = [handButton, heartButton, gumbyButton];                // *** NEW ***
		
		foreach(button; buttons)
		{
			put(button, x, y);
			y += 80;
		}

	} // this()
	
} // class MyLayout


class HandButton : Button                                         // *** NEW ***
{
	string labelText = "Hand Over";
	
	this()
	{
		super(labelText);
		
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
	string title = "Gumby Over";
	
	this()
	{
		super(title);
		
		addOnEnterNotify(&onEnter);
		addOnLeaveNotify(&onLeave);
		
	} // this()
	

	public bool onEnter(Event event, Widget widget)
	{
		bool value = true;
		
		Cursor myCursor = new Cursor(CursorType.GUMBY);
		setCursor(myCursor);

		return(value);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		bool value = true;
		
		resetCursor();

		return(value);
		
	} // onLeave()

} // class GumbyButton


class HeartButton : Button                                        // *** NEW ***
{
	string title = "Heart Over";
	
	this()
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
