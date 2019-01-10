// connect multiple signals to a single button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

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
	this(string title)                                             // *** NEW ***
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// a button that does something
		MyButton myButt = new MyButton("My Butt");                  // *** NEW ***
		add(myButt);
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyButton : Button                                           // *** NEW ***
{
	this(string label)                                             // *** NEW ***
	{
		super(label);
		addOnClicked(&clickReport);                                 // *** NEW ***
		addOnButtonRelease(&takeAction);                            // *** NEW ***
		
	} // this()
	
	
	void clickReport(Button button)                                // *** NEW ***
	{
		writeln("Reporting a click.");
		
	} // clickReport()
	
	
	bool takeAction(Event event, Widget widget)                    // *** NEW ***
	{
		writeln("Action was taken.");
		
		return(false);                                              // *** NEW ***
		
	} // takeAction()
	
} // class MyButton
