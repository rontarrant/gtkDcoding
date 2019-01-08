// Just a button that doesn't do anything

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.CheckButton;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Button;

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
	
	
	Button myButt = new MyCheckButton();
	myButt.setLabel("My Butt");
	myTestRig.add(myButt);
	
	
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

} // class myAppWindow

/////////////////////
// Start Test Code //
/////////////////////

class MyCheckButton : CheckButton
{
	super("Visible", &checkItOut);

	void checkItOut(CheckButton button)
	{
		writeln("Button checked or unchecked.");
		
	} // entryVisible()

} // class MyCheckButton

///////////////////
// End Test Code //
///////////////////
