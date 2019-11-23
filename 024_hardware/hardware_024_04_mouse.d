// This source code is in the public domain.

// capture keyboard input

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

import gdk.Device;
import gdk.Display;
import gdk.Event;
import gdk.Seat;
import gdk.Screen;
import gdk.Window;
import gdk.Rectangle;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Capture Keyboard");
	
	// Show the window and its contents...
	myTestRig.showAll();
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	Seat seat;
	Display myDisplay;
	Device pointer;
	Screen screen;
	int x, y;
	
	this(string title)
	{
		super(title);

		myDisplay = Display.getDefault();
		seat = myDisplay.getDefaultSeat();
		pointer = seat.getPointer();
		
		addOnDestroy(&quitApp);
		addOnEnterNotify(&onEnterNotify);
		
	} // this()
	
	
	bool onEnterNotify(Event event, Widget widget)
	{
		Window lastEventWindow, windowAtPosition;

		pointer.getPosition(screen, x, y);
		lastEventWindow = pointer.getLastEventWindow();
		windowAtPosition = pointer.getWindowAtPosition(x, y);

		writeln("position: x = ", x, ", y = ", y); // position is in display coordinates
		writeln("lastEventWindow: ", lastEventWindow);
		writeln("windowAtPosition: ", windowAtPosition);
	
		return(true);
		
	} // onEnterNotify()
	

	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow
