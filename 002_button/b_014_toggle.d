// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.ToggleButton;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////
void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	/////////////////////
	// Test Code Start //
	/////////////////////
	

	
	///////////////////
	// Test Code End //
	///////////////////

	// Show the window and its contents...
	myTestRig.showAll();
	
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
	} // this() CONSTRUCTOR
	
	
	void sayHi()
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyToggleButton : ToggleButton
{
	this()
	{
		super();
		
		
	} // this()
	
	
	report()
	{
		if(getMode() == true)
		{
			writeln("Toggle is on.");
		}
		else
		{
			writeln("Toggle is off.")
		}
		
	} // report()
	
} // class MyToggleButton
