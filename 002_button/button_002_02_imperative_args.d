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
	string title = "Close Messages Vary";
	string buttonText = "Vary the Close Message";
	string message = "Window close button clicked.";
	string otherMessage = "Button clicked instead.";
	
	Main.init(args);
	MainWindow testRigWindow = new MainWindow(title);
	testRigWindow.addOnDestroy(delegate void(Widget w) { quitApp(message); } ); // *** NEW ***
	
	Button button = new Button(buttonText);
	button.addOnClicked(delegate void(Button b) { quitApp(otherMessage); }); // *** NEW ***
	testRigWindow.add(button);

	// Show the window and its contents...
	testRigWindow.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp(string message) // *** NEW ***
{
	string exitMessage = "Bye.";
	
	writeln(exitMessage, ": ", message);                                      // *** NEW ***
	Main.quit();
	
} // quitApp()
