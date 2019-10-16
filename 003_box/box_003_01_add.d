// This source code is in the public domain.

// using a Box to get more buttons in the window
// using the Box.add() function

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.Box;                                                   // *** NEW ***

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Box Example with add()";
	string unhello = "Good-bye";
	AddBox addBox;
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		addBox = new AddBox();
		add(addBox);

		showAll();

	} // this()
	
	
	void quitApp()
	{
		writeln(unhello);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AddBox : Box
{
	int globalPadding = 5;
	string[] labels = ["Button 01", "Button 02", "Button 03"];
	ActionButton[] buttons;
	
	this()
	{
		int buttonCount = 0;
		
		super(Orientation.VERTICAL, globalPadding);
		// super(Orientation.HORIZONTAL, globalPadding);

		foreach(label; labels)
		{
			ActionButton button = new ActionButton(label);
			buttons ~= button;
			add(buttons[buttonCount]);
			buttonCount += 1;
		}
		
	} // this()
	
} // class AddBox


class ActionButton : Button
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
