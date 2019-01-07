// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

///////////
// START //
///////////

///////////
//  END  //
///////////
void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	///////////
	// START //
	///////////
	
	myTestRig.sayHi();
	
	///////////
	//  END  //
	///////////

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
		
		addOnDestroy(&quitApp);
		
	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

	void sayHi()
	{
		writeln("Hello GtkD OOP."); // appears in the console, not the GUI
	}

} // class myAppWindow
