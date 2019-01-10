// Precise placement of buttons using put()

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Layout;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		auto myButton = new MyButt("Button Name");
		auto myOtherButton = new MyOtherButt("Other Button Name");
		
		// layout
		auto myLayout = new MyLayout(myButton, myOtherButton);
		add(myLayout);
		
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


class MyLayout : Layout
{
	this(MyButt myButton, MyOtherButt otherButton)
	{
		super(null, null);
		put(myButton, 10, 20); // *** NEW ***
		put(otherButton, 10, 60); // *** NEW ***
		
	} // this()
	
} // class MyLayout


class MyButt : Button
{
	this(string labelText)
	{
		super(labelText);
		addOnButtonRelease(&doSomething);
		
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		writeln("Something was done.");
		
		return(true);
		
	} // doSomething()

} // class MyButt


class MyOtherButt : Button
{
	this(string labelText)
	{
		super(labelText);
		string message = "Something other than that was done.";
		addOnClicked(delegate void(_) { doSomething(message); } );
		
	} // this()
	
	
	void doSomething(string messageText)
	{
		writeln(messageText);
		
	} // doSomething()

} // class MyButt
