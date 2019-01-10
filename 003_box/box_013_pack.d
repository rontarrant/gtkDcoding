// using a box to get more buttons in the window, but
// with the Box.pack() function

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	ActionButton myButton01 = new ActionButton("First Button");
	auto myButton02 = new ActionButton("Second Button");
	auto myButton03 = new ActionButton("Third Button");

	ActionButton[] buttons = [myButton01, myButton02, myButton03];
	
	PackBox myBox = new PackBox(buttons);                          // *** NEW ***
	myTestRig.add(myBox);
	
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


class PackBox : Box
{
	this(ActionButton[] buttons)
	{
		super(Orientation.VERTICAL, 5); // top to bottom, widget spacing: 5
		
		foreach(Button button; buttons)
		{
			packStart(button, true, true, 0);                        // *** NEW ***
		}

	} // this()
	
} // class AddBox


class ActionButton : Button
{
	this(string buttonLabel)
	{
		super(buttonLabel);
		addOnButtonRelease(&doSomething);
		
		
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		writeln("Button pressed: ", getLabel());
		
		return(true);
		
	} // doSomething()
	
} // class AddButton
