// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.Layout;                                                // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
		// layout
		auto myLayout = new MyLayout();                             // *** NEW ***
		add(myLayout);                                              // *** NEW ***

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyLayout : Layout                                           // *** NEW ***
{
	this()
	{
		super(null, null);
		
		auto myButton = new MyButt();
		auto myOtherButton = new MyOtherButt();

		put(myButton, 20, 20);
		put(myOtherButton, 20, 100);
		
	} // this()
	
} // class MyLayout


class MyButt : Button
{
	string labelText = "Button Name";
	string actionMessage = "Something was done.";
	
	this()
	{
		super(labelText);
		
		addOnButtonRelease(&doSomething);
		
		setSizeRequest(160, 60);
				
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		writeln(actionMessage);
		
		return(true);
		
	} // doSomething()

} // class MyButt


class MyOtherButt : Button
{
	string labelText = "Other Button Name";
	string message = "Something other than that was done.";
		
	this()
	{
		super(labelText);
		
		addOnClicked(delegate void(_) { doSomething(); } );
		
		setSizeRequest(160, 60);
				
	} // this()
	
	
	void doSomething()
	{
		writeln(message);
		
	} // doSomething()

} // class MyButt
