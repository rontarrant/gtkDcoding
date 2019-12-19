// This source code is in the public domain.

// Presize the window

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	int width = 300, height = 400;
	string title = "Pre-sized Window";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(width, height);                                   // *** NEW ***

		// Show the window and its contents...
		showAll();

		sayHi();

	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye.";
		
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln(exitMessage);
		Main.quit();
		
	} // quitApp()


	void sayHi()
	{
		string message = "Hello GtkD World";
		
		writeln(message); // appears in the console, not the GUI
		
	} // sayHi()

} // class TestRigWindow
