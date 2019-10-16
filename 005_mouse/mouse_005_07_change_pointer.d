// This source code is in the public domain.

// change the mouse pointer to a different shape depending on which button it's on

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;                                               // *** NEW ***
import gdk.Cursor;                                                // *** NEW ***
import gtk.Layout;

// Note: CursorType flags are found in gtk.c.types

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	MyLayout myLayout;
	string title = "Change Pointer";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		setSizeRequest(184, 254);
		
		myLayout = new MyLayout();
		add(myLayout);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		string byeBye = "Bye, bye.";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class TextRigWindow


class MyLayout : Layout
{
	int x = 40, y = 20, spacing = 80;
	Widget[] buttons;
	HandButton handButton;
	HeartButton heartButton;
	GumbyButton gumbyButton;
	
	this()
	{
		super(null, null);
		
		// Create an array of Buttons and because they're Widgets at heart, we can
		// define the Button array as an array of Widgets. We could also have made
		// this an array of Buttons, but it's good to keep this inheritance stuff
		// in mind.
		handButton = new HandButton();
		heartButton = new HeartButton();
		gumbyButton = new GumbyButton();
		buttons = [handButton, heartButton, gumbyButton];
		
		foreach(button; buttons)
		{
			put(button, x, y);
			y += spacing;
		}

	} // this()
	
} // class MyLayout


class HandButton : Button
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
		Cursor myCursor = new Cursor(CursorType.HAND1);
		setCursor(myCursor);

		return(false);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		resetCursor();

		return(false);
		
	} // onLeave()

} // class HandButton


class GumbyButton : Button
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
		Cursor myCursor = new Cursor(CursorType.GUMBY);
		setCursor(myCursor);

		return(true);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		resetCursor();

		return(true);
		
	} // onLeave()

} // class GumbyButton


class HeartButton : Button
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
		Cursor myCursor = new Cursor(CursorType.HEART);
		setCursor(myCursor);

		return(false);
		
	} // onEnter()


	public bool onLeave(Event event, Widget widget)
	{
		resetCursor();

		return(false);
		
	} // onLeave()

} // class HeartButton
