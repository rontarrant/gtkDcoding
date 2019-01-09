// connect multiple signals to a single button

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
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
///////////
// START // create a button
///////////
		
		// a button that does something
		MyButton myButt = new MyButton("My Butt");
		add(myButt);
		
///////////
//  END  //
///////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow

///////////
// START // derived button class
///////////

class MyButton : Button
{
	this(string label)
	{
		super(label);
		addOnClicked(&clickReport);
		addOnButtonRelease(&takeAction);
		
	} // this()
	
	
	void clickReport(Button button)
	{
		writeln("Reporting a click.");
		
	} // clickReport()
	
	
	bool takeAction(Event event, Widget widget)
	{
		writeln("Action was taken.");
		
		return(false);
		
	} // takeAction()
	
} // class MyButton

///////////
//  END  //
///////////
