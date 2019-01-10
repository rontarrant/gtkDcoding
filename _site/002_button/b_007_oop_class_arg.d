// Example of:
//  a plain button
//  coded in the OOP paradigm
//  an argument is passed from the button constructor to the button's callback

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

///////////
// START // additional import statements
///////////

import gtk.Button;
import gdk.Event;

///////////
//  END  //
///////////

void main(string[] args)
{
	string title = "Test Rig OOP";
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow(title);
	
///////////
// START // additional code
///////////
	
	MyButton button = new MyButton("Click this");
	myTestRig.add(button);
	
///////////
//  END  //
///////////
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow

 
class MyButton : Button
{
///////////
// START // additional code
///////////

	this(string label)
	{
		string message = "Next time, don't bring the Wookie.";
		
		super(label);
		//addOnClicked(delegate void(Button b) { buttonAction(message); });
		addOnClicked(delegate void(_) { buttonAction(message); });
		
	} // this()
	
	
	void buttonAction(string message)
	{
		writeln("The message is: ", message);
		
	} // buttonAction()
	
} // class MyButton

///////////
//  END  //
///////////
