// Example of:
//  a plain button
//  coded in the OOP paradigm
//  command line args are passed to a bool callback

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig OOP - Pass Args", args);
	
	// Show the window and its contents...
	myTestRig.showAll();                                           // *** NEW ***
		
	// give control over to gtkD
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title, string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );      // *** NEW ***
		
		MyArgsButton myButton = new MyArgsButton("Show Args", args);
		add(myButton);
		
		// Show the window and its contents...
		showAll();
		
	} // this()
	
	
	void quitApp()                                                 // *** NEW ***
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class TestRigWindow

class MyArgsButton : Button                                       // *** NEW ***
{
	this(string labelText, string[] args)
	{
		super(labelText);
		// addOnButtonRelease(&onButtonRelease);                                  // *** NEW ***
		addOnButtonRelease(delegate bool(Event e, Widget w){ buttonAction(args); return false; } );               // *** NEW ***
		
	} // this()
	
	
	public bool buttonAction(string[] buttonArgs)                                // *** NEW ***
	{
		foreach(arg; buttonArgs)
		{
			writeln("arg: ", arg);
		}

		return(true);
		
	} // buttonAction()

} // class MyArgsButton
