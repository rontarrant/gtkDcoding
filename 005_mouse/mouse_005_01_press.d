// This source code is in the public domain.

// hook up the mouse button press signal

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

// Note: EventType flags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Mouse Button Press";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnButtonPress(&onMousePress);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		string buy = "Bye";

		writeln(buy);
		
		Main.quit();

	} // quitApp()


	public bool onMousePress(Event event, Widget widget)
	{
		bool returnValue = false;

		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* mouseEvent = event.button;
			pressReport(mouseEvent.button);
			returnValue = true;
		}

		return(returnValue);
		
	} // onMousePress()


	void pressReport(uint mouseButtonNumber)
	{
		string action = " was pressed.";

		writeln("Button # ", mouseButtonNumber, action);

	} // pressReport()
	
} // class TestRigWindow
