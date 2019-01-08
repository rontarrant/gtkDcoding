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
	
	BoxButton myButton01 = new BoxButton("First Button");
	auto myButton02 = new BoxButton("Second Button");
	auto myButton03 = new BoxButton("Third Button");

	BoxButton[] buttons = [myButton01, myButton02, myButton03];
	
	PackBox myBox = new PackBox(buttons);
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


class PackBox : Box
{
	this(BoxButton[] buttons)
	{
		super(Orientation.VERTICAL, 5); // top to bottom, widget spacing: 5
		
		foreach(Button button; buttons)
		{
			packStart(button, true, true, 0);
		}

	} // this()
	
} // class AddBox


class BoxButton : Button
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
