// This source code is in the public domain.

// Example of:
//  a plain button
//  coded in the OOP paradigm
//  command line args are passed to a Boolean callback

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
	string title = "Pass Terminal Args to Boolean Callback";
	MyArgsButton myArgsButton;
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		myArgsButton = new MyArgsButton(args);
		add(myArgsButton);
		
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye";

		writeln(exitMessage);
		
		Main.quit();

	} // quitApp()

} // class TestRigWindow


class MyArgsButton : Button
{
	string labelText = "Show Args";
	
	this(string[] args)
	{
		super(labelText);
		
		// addOnButtonRelease(&onButtonRelease);                                                                  
		addOnButtonRelease(delegate bool(Event e, Widget w){ buttonAction(args); return(false); } );
		
	} // this()
	
	
	public bool buttonAction(string[] buttonArgs)
	{
		int appName = 0;
		
		foreach(arg; buttonArgs)
		{
			if(arg != buttonArgs[appName]) // skip arg 0; it's the name of the application
			{
				writeln("\t", arg);
			}
		}

		return(true); // this value doesn't matter; the delegate (above) overrules it
		
	} // buttonAction()

} // class MyArgsButton
