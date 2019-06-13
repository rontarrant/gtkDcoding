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
	string title = "Test Rig";
	string buy = "Bye";
	string action = " was pressed.";
	
	this()
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnButtonPress(&onMousePress);                           // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln(buy);
		
		Main.quit();

	} // quitApp()


	public bool onMousePress(Event event, Widget widget)          // *** NEW ***
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


	void pressReport(uint mouseButtonNumber)                                               // *** NEW ***
	{
		writeln("Button # ", mouseButtonNumber, action);

	} // pressReport()
	
} // class TestRigWindow
