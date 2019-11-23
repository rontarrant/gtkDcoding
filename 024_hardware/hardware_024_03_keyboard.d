// This source code is in the public domain.

// capture keyboard input

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

import gdk.Device;
import gdk.Display;
import gdk.Event;
import gdk.Keymap;
import gdk.Seat;
import gdk.Window;
import gdk.Rectangle;
import gdk.MonitorG;

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
	Device _keyboard;
	Keymap keymap;
	
	this(string title)
	{
		super(title);

		myDisplay = Display.getDefault();
		seat = myDisplay.getDefaultSeat();
		_keyboard = seat.getKeyboard();
		keymap = Keymap.getDefault();

		addOnDestroy(&quitApp);
		addOnKeyPress(&onKeyPress);
		
	} // this()
	
	
	bool onKeyPress(GdkEventKey* eventKey, Widget widget)
	{
		string pressedKey;
		int keys;
		
		pressedKey = keymap.keyvalName(eventKey.keyval);
		writeln("The keyval is: ", eventKey.keyval, " which means the ", pressedKey, " was pressed.");

		return(true);
		
	} // onKeyPress()
	

	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow
