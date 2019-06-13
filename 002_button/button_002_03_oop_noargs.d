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
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig OOP";
	
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
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class testRigWindow


class MyButton : Button                                // *** NEW ***
{
	string label = "Click this";
	 
	this()
	{
		super(label);
		addOnClicked(&buttonAction);
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		writeln("Action taken.");
		
	} // buttonAction()
	
} // class MyButton
