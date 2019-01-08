// Example of:
//  a plain button
//  coded in the OOP paradigm
//  command line args are passed to a bool callback

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

///////////
// START // additional imports
///////////

import gtk.Button;
import gdk.Event;

///////////
//  END  //
///////////

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig OOP - Pass Args", args);
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title, string[] args)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
///////////
// START // button creation, pass args
///////////
		
		// pass command line args to the button constructor
		MyArgsButton myButton = new MyArgsButton("Show Args", args);
		add(myButton);
		
		
///////////
//  END  //
///////////
	
		// Show the window and its contents...
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class TestRigWindow

///////////
// START // button sub-class
///////////

class MyArgsButton : Button
{
	// string[] buttonArgs;
	
	this(string labelText, string[] args)
	{
		super(labelText);
		// addOnButtonRelease(&onButtonRelease);
		addOnButtonRelease(delegate bool(Event e, Widget w){ buttonAction(args); return false; } );
		// buttonArgs = args;
		
	} // this()
	
	
//	public bool buttonAction(Event event, Widget widget, string[] buttonArgs)
	public bool buttonAction(string[] buttonArgs)
	{
		foreach(arg; buttonArgs)
		{
			writeln("arg: ", arg);
		}

		return(true);
		
	} // buttonAction()

} // class MyArgsButton

///////////
//  END  //
///////////
