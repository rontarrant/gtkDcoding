// Just a button with an image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Button;
import gtk.Image;

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
	
	
	Button myButt = new Button();
	Image myImage = new Image("images/apples.jpg");
	myButt.add(myImage);
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
