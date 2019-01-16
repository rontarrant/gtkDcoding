// Example of:
//  a plain button
//  coded in the imperative paradigm
//  no args passed to the button's callback

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

import gtk.Button;                                                // *** NEW ***
import gdk.Event;                                                 // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	MainWindow myTestRig = new MainWindow("Test Rig");
	myTestRig.addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	Button button = new Button("Label Text");                      // *** NEW ***
	button.addOnClicked(delegate void(Button b) { quitApp(); });
	myTestRig.add(button);

	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp()
{
	// This exists in case we want to do anything
	// before exiting such as warn the user to
	// save work.
	writeln("Bye.");
	Main.quit();
	
} // quitApp()
