// hook two signals to a single button so it tells us which signal is being processed

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;


void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, bye.";
	string messageStart = "We've experienced ";
	
	this()
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnEnterNotify(&onEvent);                                 // *** NEW ***
		addOnLeaveNotify(&onEvent);                                 // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onEvent(Event event, Widget widget)                // *** NEW ***
	{
		bool value = false;
		string article;
		
		if(event.type() == EventType.ENTER_NOTIFY)
		{
			article = "an ";
		}
		else
		{
			article = "a ";
		}
		
		writeln(messageStart, article, event.type(), " event.");

		return(value);
		
	} // onEvent()

} // class myAppWindow
