// Example of:
//  a plain button
//  coded in the OOP paradigm
//  an argument is passed in the constructor to the button's callback

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

 
class MyButton : Button
{
	this(string label)
	{
		string message = "Next time, don't bring the Wookie.";                                // *** NEW ***
		
		super(label);
		//addOnClicked(delegate void(Button b) { buttonAction(message); });
		addOnClicked(delegate void(_) { buttonAction(message); });                                // *** NEW ***
		
	} // this()
	
	
	void buttonAction(string message)                                // *** NEW ***
	{
		writeln("The message is: ", message);
		
	} // buttonAction()
	
} // class MyButton
