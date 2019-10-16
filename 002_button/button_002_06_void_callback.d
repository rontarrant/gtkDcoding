// This source code is in the public domain.

// Example of:
//  a plain button
//  coded in the OOP paradigm
//  command line args are passed to a void callback

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
	
	testRigWindow = new TestRigWindow(args);
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Pass Terminal Args to void Callback";
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		MyButton button = new MyButton(args);
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
	string label = "Click This...";
	
	this(string[] args)
	{
		super(label);
		// Either of the two following lines will do the job at hand.
		// The first shows the actual syntax while the second shows
		// the same thing, but using type inference.
		//addOnClicked(delegate void(Button b) { buttonAction(args); });
		addOnClicked(delegate void(_) { buttonAction(args); });
		
	} // this()
	
	
	void buttonAction(string[] args)
	{
		writeln("The command line arguments are:");

		foreach(arg; args)
		{
			writeln("\t", arg);
		}
		
	} // buttonAction()
	
} // class MyButton
