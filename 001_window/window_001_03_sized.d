// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	testRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new testRigWindow();
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(300, 400);                                   // *** NEW ***

		// Show the window and its contents...
		showAll();

		sayHi();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()


	void sayHi()
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}

} // class testRigWindow
