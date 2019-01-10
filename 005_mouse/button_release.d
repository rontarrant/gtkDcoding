// hook up the mouse button release signal

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
		
		// make the window sensitive to mouse button release event (any button)
		addOnButtonRelease(&onButtonRelease);                                     // *** NEW ***
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();

	} // quitApp()


	public bool onButtonRelease(Event event, Widget widget)        // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				rightRelease();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middleRelease();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftRelease();
				value = true;
			}
		}

		return(value);
		
	} // onButtonRelease()


	void leftRelease()                                             // *** NEW ***
	{
		writeln("Left Button released.");
		
	} // leftRelease()


	void middleRelease()                                           // *** NEW ***
	{
		writeln("Middle Button released.");
		
	} // middleRelease()


	void rightRelease()                                            // *** NEW ***
	{
		writeln("Right Button released.");
		
	} // rightRelease()

} // class myAppWindow
