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
	TestRigWindow myTestRig = new TestRigWindow();       // *** NEW ***
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string windowTitle = "Test Rig";
	string departingMessage = "Bye.";
	
	this(/* NO ARGS */)
	{
		// window
		super(windowTitle);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// a button that does something
		MyButton myButt = new MyButton(buttonCaption);                  // *** NEW ***
		add(myButt);                                                // *** NEW ***
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()                                                 // *** NEW ***
	{
		writeln(departingMessage);
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyButton : Button
{
	string buttonCaption = "My Butt";
	string actionMessage = "Action was taken.";
	
	this(string label)
	{
		super(label);
		addOnButtonRelease(&takeAction);                            // *** NEW ***
		
	} // this()
	
	
	bool takeAction(Event event, Widget widget)                    // *** NEW ***
	{
		writeln(actionMessage);
		
		return(false);
		
	} // takeAction()
	
} // class MyButton
