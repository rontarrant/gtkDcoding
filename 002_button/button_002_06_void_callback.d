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
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow(args);
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig OOP";
	string departureMessage = "Bye.";
	
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
		writeln(departureMessage);
		
		Main.quit();
		
	} // quitApp()

} // class testRigWindow

 
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
	
	
	void buttonAction(string[] args)                                             // *** NEW ***
	{
		writeln("The command line arguments are:");

		foreach(arg; args)
		{
			writeln("\t", arg);
		}
		
	} // buttonAction()
	
} // class MyButton
