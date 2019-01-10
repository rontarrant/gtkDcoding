// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	myTestRig.sayHi();

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

		setSizeRequest(300, 400);                                   // *** NEW ***

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()


	void sayHi()                                                   // *** NEW ***
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}

} // class myAppWindow
