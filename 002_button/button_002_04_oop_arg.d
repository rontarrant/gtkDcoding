// This source code is in the public domain.

// Example of:
//  a plain button
//  coded in the OOP paradigm
//  an argument is passed Button's callback function

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
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Argument Passed to Callback";
	MyButton button;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);

		button = new MyButton();
		add(button);
	
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
	string labelText = "Click This";
	
	this()
	{
		string message = "Next time, don't bring the Wookie.";                    // *** NEW ***
		
		super(labelText);
		
		// The next two lines do the same thing, but the second uses shorthand in the void() definition.
		//addOnClicked(delegate void(Button b) { buttonAction(message); });
		addOnClicked(delegate void(_) { buttonAction(message); });                // *** NEW ***
		
	} // this()
	
	
	void buttonAction(string message)
	{
		writeln("The message is: ", message);
		
	} // buttonAction()
	
} // class MyButton
