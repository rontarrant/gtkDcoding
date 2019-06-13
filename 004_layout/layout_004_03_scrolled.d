// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.Layout;
import gtk.ScrolledWindow;                                        // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	
	testRigWindow testRigWindow = new testRigWindow();

	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(200, 200);
		
		ScrolledWindow scrolledWindow = new ScrolledWindow();       // *** NEW ***
		add(scrolledWindow);
		
		auto myLayout = new MyLayout();
		scrolledWindow.add(myLayout);

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class testRigWindow


class MyLayout : Layout
{
	this()
	{
		super(null, null);
		setSize(400, 400);
		
		auto myButton = new MyButt();
		put(myButton, 20, 20);
		
		auto myOtherButton = new MyOtherButt();
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
