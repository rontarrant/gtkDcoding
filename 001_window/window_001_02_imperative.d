// This source code is in the public domain.

// Imperative Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	string windowTitle = "Test Rig";
	string message = "Hello GtkD Imperative World";
	
	Main.init(args);
	MainWindow testRigWindow = new MainWindow(windowTitle);
	testRigWindow.addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	writeln(message);

	// Show the window and its contents...
	testRigWindow.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp()
{
	string exitMessage = "Bye.";
	
	// This exists in case we want to do anything
	// before exiting such as warn the user to
	// save work.
	writeln(exitMessage);
	Main.quit();
	
} // quitApp()
