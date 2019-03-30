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
	// initialization & creation
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBlurb = "Bye.";
	string action = " released.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse button release event (any button)
		addOnButtonRelease(&onButtonRelease);                                     // *** NEW ***
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	public bool onButtonRelease(Event event, Widget widget)        // *** NEW ***
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


	void releaseReport(uint buttonNumber)                                             // *** NEW ***
	{
		writeln("Button #", buttonNumber, " was ", action, ".");
		
	} // releaseReport()


	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln(byeBlurb);
		Main.quit();

	} // quitApp()

} // class myAppWindow
