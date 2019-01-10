// using a Box to get more buttons in the window
// with the Box.add() function

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.Box;                                                   // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	ActionButton button01 = new ActionButton("Button 01");         // *** NEW ***
	auto button02 = new ActionButton("Button 02");                 // *** NEW ***
	auto button03 = new ActionButton("Button 03");                 // *** NEW ***
	
	ActionButton[] buttons = [button01, button02, button03];       // *** NEW ***
	
	AddBox myBox = new AddBox(buttons);                            // *** NEW ***
	myTestRig.add(myBox);                                          // *** NEW ***

	// Show the window and its contents...
	myTestRig.showAll();
	
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AddBox : Box                                                // *** NEW ***
{
	this(ActionButton[] buttons)
	{
		super(Orientation.VERTICAL, 5);
		
		foreach(Button button; buttons)
		{
			add(button);
		}
		
	} // this()
	
} // class AddBox


class ActionButton : Button                                       // *** NEW ***
{
	this(string labelText)
	{
		super(labelText);
		addOnButtonRelease(&doSomething);
		
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		writeln(getLabel(), " was pressed.");
		
		return(true);
		
	} // doSomething()
	
} // class ActionButton
