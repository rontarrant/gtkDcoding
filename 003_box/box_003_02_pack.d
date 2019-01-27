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
	
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string soLong = "That's it";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		PackBox myBox = new PackBox();
		add(myBox);
		
		showAll(); // Let's try this from in here this time                       *** NEW ***

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(soLong);
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class PackBox : Box
{
	string[] labels = ["First Button", "Second Button", "Third Button"];
	ActionButton[] buttons;
	
	this()
	{
		int countButts = 0;
		
		super(Orientation.VERTICAL, 5); // top to bottom, widget spacing: 5
		
		foreach(label; labels)
		{
			ActionButton button = new ActionButton(label);
			buttons ~= button;
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
	
} // class ActionButton
