// hook up the mouse button press signal

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;                                               // *** NEW ***

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
		addOnButtonPress(&onButtonPress);                           // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()


	public bool onButtonPress(Event event, Widget widget)          // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				rightPress();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middlePress();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftPress();
				value = true;
			}
		}

		return(value);
		
	} // onButtonPress()


	void leftPress()                                               // *** NEW ***
	{
		writeln("Left Button pressed.");

	} // leftPress()


	void middlePress()                                             // *** NEW ***
	{
		writeln("Middle Button pressed.");
		
	} // middlePress()


	void rightPress()                                              // *** NEW ***
	{
		writeln("Right Button pressed.");
		
	} // rightPress()

} // class myAppWindow
