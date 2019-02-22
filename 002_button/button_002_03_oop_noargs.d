// Example of:
//  a plain button
//  coded in the OOP paradigm


import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	string title = "Test Rig OOP";
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow(title);
	
	MyButton button = new MyButton("Click this");
	myTestRig.add(button);
	
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
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyButton : Button                                // *** NEW ***
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
