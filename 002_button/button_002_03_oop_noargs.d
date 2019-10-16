// This source code is in the public domain.

// Example of:
//  a plain button
//  coded in the OOP paradigm
// no arguments are passed to the callback function


import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Plain Button";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		MyButton button = new MyButton();
		add(button);
	
		// Show the window and its contents...
		showAll();

	} // this()
	
	
	void quitApp(Widget w)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyButton : Button
{
	string label = "Click This";
	 
	this()
	{
		super(label);
		addOnClicked(&buttonAction);
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		string message = "An action was taken.";
		
		writeln(message);
		
	} // buttonAction()
	
} // class MyButton
