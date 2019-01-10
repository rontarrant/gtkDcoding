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
		
		// make the window sensitive to mouse clicking (any button)
		addOnEnterNotify(&onEvent);                                 // *** NEW ***
		addOnLeaveNotify(&onEvent);                                 // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()


	public bool onEvent(Event event, Widget widget)                // *** NEW ***
	{
		bool value = false;
		
		writeln(event.type());

		return(value);
		
	} // onEvent()

} // class myAppWindow
