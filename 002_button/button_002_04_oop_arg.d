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
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow();
	
	// give control over to the gtkD .
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig OOP";
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
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class testRigWindow

 
class MyButton : Button
{
	string labelText = "Click this";
	
	this()
	{
		string message = "Next time, don't bring the Wookie.";                    // *** NEW ***
		
		super(labelText);
		//addOnClicked(delegate void(Button b) { buttonAction(message); });
		addOnClicked(delegate void(_) { buttonAction(message); });                // *** NEW ***
		
	} // this()
	
	
	void buttonAction(string message)                                            // *** NEW ***
	{
		writeln("The message is: ", message);
		
	} // buttonAction()
	
} // class MyButton
