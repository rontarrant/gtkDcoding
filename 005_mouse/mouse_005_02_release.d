// hook up the mouse button release signal

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
	string title = "Mouse Button Release";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse button release event (any button)
		addOnButtonRelease(&onButtonRelease);
	
		showAll();
		
	} // this()


	public bool onButtonRelease(Event event, Widget widget)
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;
			releaseReport(buttonEvent.button);
			value = true;
		}

		return(value);
		
	} // onButtonRelease()


	void releaseReport(uint buttonNumber)
	{
		string action = " released.";

		writeln("Button #", buttonNumber, " was ", action, ".");
		
	} // releaseReport()


	void quitApp()
	{
		string exitMessage = "Bye.";

		writeln(exitMessage);
		Main.quit();

	} // quitApp()

} // class TestRigWindow
