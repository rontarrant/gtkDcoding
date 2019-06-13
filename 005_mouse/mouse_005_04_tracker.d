// hook up the onMotion signal and have it report its position within the window

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

	testRigWindow testRigWindow = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Good-bye";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the callback sensitive to mouse movement
		addOnMotionNotify(&onMotion);                                             // *** NEW ***
		
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onMotion(Event event, Widget widget)                             // *** NEW ***
	{
		// make sure we're not reacting to the wrong event
		if(event.type == EventType.MOTION_NOTIFY)
		{
			writeln("x = ", event.motion.x, " y = ", event.motion.y);
		}

		return(true);
		
	} // onMotion()

} // class testRigWindow
