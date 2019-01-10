// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

////////////
// START  //
////////////

import gtk.Box;
import gtk.Button;
import gdk.Event;

///////////
//  END  //
///////////

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
////////////
// START  //
////////////
	
	ActionButton button01 = new ActionButton("Button 01");
	auto button02 = new ActionButton("Button 02");
	auto button03 = new ActionButton("Button 03");
	
	ActionButton[] buttons = [button01, button02, button03];
	
	AddBox myBox = new AddBox(buttons);
	myTestRig.add(myBox);
	
	
///////////
//  END  //
///////////

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
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow

////////////
// START  //
////////////

class AddBox : Box
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

///////////
//  END  //
///////////
