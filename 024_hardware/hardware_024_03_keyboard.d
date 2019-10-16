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
	Device keyboard;
	Keymap keymap;
	GdkRectangle rectangle;
	
	this(string title)
	{
		super(title);

		myDisplay = Display.getDefault();
		seat = myDisplay.getDefaultSeat();
		keyboard = seat.getKeyboard();
		keyboardReport();
		keymap = Keymap.getDefault();
		addOnDestroy(&quitApp);
		addOnKeyPress(&onKeyPress);
		
	} // this() CONSTRUCTOR
	
	
	bool onKeyPress(GdkEventKey* eventKey, Widget widget)
	{
		string pressedKey;
		int keys;
		
		pressedKey = keymap.keyvalName(eventKey.keyval);
		writeln("The keyval is: ", eventKey.keyval, " which means the ", pressedKey, " was pressed.");
		keys = keyboard.getNKeys();
		writeln("Number of Keys: ", keys);

		return(true);
		
	} // onKeyPress()
	
// grab() - redirect all input from the device to the running application until it's ungrabbed

// getKey() - get a pressed key and any modifiers
// getNKeys() - how many keys the device has
	void keyboardReport()
	{
		string keyboardName;
		
		keyboardName = keyboard.getName();
		writeln("Your keyboard is a ", keyboardName);
		
	} // keyboard()


	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow
