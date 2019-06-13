// Precision placement of buttons using put()

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
	
	testRigWindow testRigWindow = new testRigWindow();

	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig";
	string quitBlurb = "I could have done something here.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		auto myLayout = new MyLayout();
		add(myLayout);
		
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(quitBlurb);
		
		Main.quit();
		
	} // quitApp()

} // class testRigWindow


class MyLayout : Layout
{
	this()
	{
		super(null, null);
		auto myButton = new MyButt();
		auto myOtherButton = new MyOtherButt();
		
		put(myButton, 10, 20);                                                    // *** NEW ***
		put(myOtherButton, 10, 60);                                                 // *** NEW ***
		
	} // this()
	
} // class MyLayout


class MyButt : Button
{
	string labelText = "Button Name";
	string doSomethingText = "Something was done.";
	
	this()
	{
		super(labelText);
		addOnButtonRelease(&doSomething);
		
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		writeln(doSomethingText);
		
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
		
	} // this()
	
	
	void doSomething()
	{
		writeln(message);
		
	} // doSomething()

} // class MyButt
