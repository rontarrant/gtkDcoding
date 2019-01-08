// Test Rig Foundation for Learning GtkD Coding
// distingish between left, middle, and right mouse buttons
// In this demo, the window itself is sensitive to mouse
// button clicks.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

////////////////////////////////////////
// Additional import statements START //
////////////////////////////////////////

import gtk.Button;
import gdk.Event;
import gtk.c.types;

//////////////////////////////////////
// Additional import statements END //
//////////////////////////////////////

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	////////////////////////////////////////////
	// Look in TestRigWindow class for Test Code
	///////////////////////////////////////////
	
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
		
		/////////////////////
		// TEST CODE START //
		/////////////////////
		
		// make the window sensitive to mouse button release event (any button)
		addOnButtonRelease(&onButtonRelease);
		
		///////////////////
		// TEST CODE END //
		///////////////////
	
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

	/////////////////////
	// TEST CODE START //
	/////////////////////

	public bool onButtonRelease(Event event, Widget widget)
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


	void leftRelease()
	{
		writeln("Left Button released.");
		
	} // leftRelease()


	void middleRelease()
	{
		writeln("Middle Button released.");
		
	} // middleRelease()


	void rightRelease()
	{
		writeln("Right Button released.");
		
	} // rightRelease()

	///////////////////
	// TEST CODE END //
	///////////////////

} // class myAppWindow
