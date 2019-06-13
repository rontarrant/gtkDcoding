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
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow(args);
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig OOP - Pass Args";
	string sayBye = "Bye";
	MyArgsButton myArgsButton;
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(args); } );
		
		myArgsButton = new MyArgsButton(args);
		add(myArgsButton);
		
		showAll();
		
	} // this()
	
	
	void quitApp(string[] args)
	{
		writeln(sayBye);
		
		foreach(arg; args)
		{
			writeln("arg: ", arg);
		}

		Main.quit();

	} // quitApp()

} // class testRigWindow


class MyArgsButton : Button
{
	string labelText = "Show Args";
	
	this(string[] args)
	{
		super(labelText);
		
		// addOnButtonRelease(&onButtonRelease);                                                                  
		addOnButtonRelease(delegate bool(Event e, Widget w){ buttonAction(args); return(false); } );
		
	} // this()
	
	
	public bool buttonAction(string[] buttonArgs)                                                                // *** NEW ***
	{
		foreach(arg; buttonArgs)
		{
			if(arg != buttonArgs[0])
			{
				writeln("\t", arg);
			}
		}

		return(true); // countermands the 'false' return of the callback definition above
		
	} // buttonAction()

} // class MyArgsButton
