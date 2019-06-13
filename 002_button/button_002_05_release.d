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
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string windowTitle = "Test Rig";
	string departingMessage = "Bye.";
	MyButton myButton;
	
	this(/* NO ARGS */)
	{
		// window
		super(windowTitle);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// a button that does something
		myButton = new MyButton();                  // *** NEW ***
		add(myButton);                                // *** NEW ***
		
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()                                                 // *** NEW ***
	{
		writeln(departingMessage);
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyButton : Button
{
	string buttonText = "My Butt";
	string actionMessage = "Action was taken.";
	
	this()
	{
		super(buttonText);
		addOnButtonRelease(&takeAction);                            // *** NEW ***
		
	} // this()
	
	
	bool takeAction(Event event, Widget widget)                    // *** NEW ***
	{
		writeln(actionMessage);
		
		return(false);
		
	} // takeAction()
	
} // class MyButton
