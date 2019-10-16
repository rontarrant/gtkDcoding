// This source code is in the public domain.

// using a box to get more buttons in the window, but
// with the Box.packEnd() function

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
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
	string title = "Test Rig";
	string soLong = "That's it";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		PackBox myBox = new PackBox();
		add(myBox);
		
		showAll();

	} // this()
	
	
	void quitApp()
	{
		writeln(soLong);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class PackBox : Box
{
	int globalPadding = 5;
	int localPadding = 0;
	string[] labels = ["First Button", "Second Button", "Third Button"];
	ActionButton[] buttons;
	
	this()
	{
		int countButts = 0;
		
		super(Orientation.VERTICAL, globalPadding);
		
		foreach(label; labels)
		{
			ActionButton button = new ActionButton(label);
			buttons ~= button;
			packEnd(button, true, true, localPadding);
		}

	} // this()
	
} // class PackBox


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
