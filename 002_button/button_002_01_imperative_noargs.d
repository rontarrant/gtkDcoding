// This source code is in the public domain.

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
	string title = "Button in a Window - Inperative";
	string buttonText = "Label Text";
	
	Main.init(args);
	MainWindow testRigWindow = new MainWindow(title);
	testRigWindow.addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	Button button = new Button(buttonText);                      // *** NEW ***
	button.addOnClicked(delegate void(Button b) { quitApp(); });
	testRigWindow.add(button);

	testRigWindow.showAll();
		
	Main.run();
	
} // main()


void quitApp()
{
	string exitMessage = "Bye.";
	
	writeln(exitMessage);
	
	Main.quit();
	
} // quitApp()
