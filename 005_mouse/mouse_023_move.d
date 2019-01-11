// hook up the onMotion signal and have it report its position within the window

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
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnMotionNotify(&onMotion);                                             // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()


	public bool onMotion(Event event, Widget widget)                             // *** NEW ***
	{
		if(event.type == EventType.MOTION_NOTIFY)
		{
			writeln("x = ", event.motion.x, " y = ", event.motion.y);
		}

		return(true);
		
	} // onMotion()

} // class myAppWindow
