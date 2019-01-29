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
	
	TestRigWindow myTestRig = new TestRigWindow(args);
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig OOP - Pass Args";
	string sayBye = "Bye";
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		MyArgsButton myButton = new MyArgsButton(args);
		add(myButton);
		
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		writeln(sayBye);
		
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
	
	
	public bool buttonAction(string[] buttonArgs)                                                                // *** NEW ***
	{
		foreach(arg; buttonArgs)
		{
			if(arg != buttonArgs[0])                                               // *** NEW *** skip arg 0, it's the name of the program
			{
				writeln("\t", arg);
			}
		}

		return(true); // countermands the 'false' return of the callback definition above
		
	} // buttonAction()

} // class MyArgsButton
