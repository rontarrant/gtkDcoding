// Window Close button and GUI button trigger same action

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
// START // button creation, pass args
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
// START // button class
///////////


class MyButton : Button
{
	this(string label)
	{
		super(label);
		addOnButtonRelease(&takeAction);
		
	} // this()
	
	
	bool takeAction(Event event, Widget widget)
	{
		writeln("Action was taken.");
		
		return(false);
		
	} // takeAction()
	
} // class MyButton

///////////
//  END  //
///////////
