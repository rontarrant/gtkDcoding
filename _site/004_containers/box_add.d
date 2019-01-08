// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Box;
import gtk.Button;
import gdk.Event;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////
void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	/////////////////////
	// Test Code Start //
	/////////////////////
	
	AddButton button01 = new AddButton("Button 01");
	auto button02 = new AddButton("Button 02");
	auto button03 = new AddButton("Button 03");
	
	AddButton[] buttons = [button01, button02, button03];
	
	AddBox myBox = new AddBox(buttons);
	myTestRig.add(myBox);
	
	
	///////////////////
	// Test Code End //
	///////////////////

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


class AddBox : Box
{
	this(AddButton[] buttons)
	{
		super(Orientation.VERTICAL, 5);
		
		foreach(Button button; buttons)
		{
			add(button);
		}
		
	} // this()
	
} // class AddBox


class AddButton : Button
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
	
} // class AddButton
