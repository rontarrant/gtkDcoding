// Example of:
//  a plain button
//  coded in the OOP paradigm

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
// START // add a button
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

///////////
// START // button class
///////////

class MyButton : Button
{
	this(string label)
	{
		super(label);
		addOnClicked(&buttonAction);
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		writeln("Action taken.");
		
	} // buttonAction()
	
} // class MyButton

///////////
//  END  //
///////////
