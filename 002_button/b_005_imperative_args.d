// Example of:
//  a plain button
//  coded in the imperative paradigm
//  a different argument passed if button is clicked instead of window's close widget

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	string message = "Window close button clicked.";               // *** NEW ***
	string otherMessage = "Button clicked instead.";               // *** NEW ***
	
	Main.init(args);
	MainWindow myTestRig = new MainWindow("Test Rig");
	myTestRig.addOnDestroy(delegate void(Widget w) { quitApp(message); } ); // *** NEW ***
	
	Button button = new Button("Label Text");
	button.addOnClicked(delegate void(Button b) { quitApp(otherMessage); }); // *** NEW ***
	myTestRig.add(button);

	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp(string message) // *** NEW ***
{
	// This exists in case we want to do anything
	// before exiting such as warn the user to
	// save work.
	writeln("Bye.", message);                                      // *** NEW ***
	Main.quit();
	
} // quitApp()
