// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

////////////////////////////////////////
// Additional import statements START //
////////////////////////////////////////


//////////////////////////////////////
// Additional import statements END //
//////////////////////////////////////
void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	/////////////////////
	// Test Code Start //
	/////////////////////
	
	
	myTestRig.sayHi();
	
	
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

		/////////////////////
		// TEST CODE START //
		/////////////////////

		setSizeRequest(300, 400);

		///////////////////
		// TEST CODE END //
		///////////////////
		
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

	void sayHi()
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}

	///////////////////
	// TEST CODE END //
	///////////////////

} // class myAppWindow
