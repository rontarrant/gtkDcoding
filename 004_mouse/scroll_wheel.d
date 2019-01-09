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
	
	///////////////////////////////////////////////
	// Look in TestRigWindow class for Test Code //
	//////////////////////////////////////////////
	
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
		
		// make the window sensitive to mouse wheel scrolling
		addOnScroll(&onScroll);
		
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

	public bool onScroll(Event event, Widget widget)
	{
		bool value = false; // assume no scrolling
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			value = true;
			writeln("scrolling down...");
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			value = true;
			writeln("scrolling up...");
		}

		return(value);

	} // onScroll()
	
	///////////////////
	// TEST CODE END //
	///////////////////

} // class myAppWindow
