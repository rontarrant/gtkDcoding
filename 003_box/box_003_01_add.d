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
	
	TestRigWindow myTestRig = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string unhello = "Good-bye";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		AddBox myBox = new AddBox();                            // *** NEW ***
		add(myBox);                                             // *** NEW ***

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(unhello);
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AddBox : Box                                                // *** NEW ***
{
	string[] labels = ["Button 01", "Button 02", "Button 03"];
	ActionButton[] buttons;
	
	this()
	{
		int buttonCount = 0;
		
		super(Orientation.VERTICAL, 5);

		foreach(label; labels)
		{
			ActionButton button = new ActionButton(label);
			buttons ~= button;
			add(buttons[buttonCount]);
			buttonCount += 1;
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
