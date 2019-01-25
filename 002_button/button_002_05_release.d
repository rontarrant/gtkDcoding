// move button creation inside the TestRigWindow class
// use the onButtonRelease signal instead of onClicked
//
//

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");       // *** NEW ***
	
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
		
		// a button that does something
		MyButton myButt = new MyButton("My Butt");                  // *** NEW ***
		add(myButt);                                                // *** NEW ***
		
		// Show the window and its contents...
//		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()                                                 // *** NEW ***
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyButton : Button
{
	this(string label)
	{
		super(label);
		addOnButtonRelease(&takeAction);                            // *** NEW ***
		
	} // this()
	
	
	bool takeAction(Event event, Widget widget)                    // *** NEW ***
	{
		writeln("Action was taken.");
		
		return(false);
		
	} // takeAction()
	
} // class MyButton
