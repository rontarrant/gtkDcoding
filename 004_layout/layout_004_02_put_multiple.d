// Precision placement of multiple buttons using put()
// Also shows the use of auto as a substitute for naming a class during instantiation.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Layout;
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
	string title = "Put Multiple Buttons";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		auto myLayout = new MyLayout();
		add(myLayout);
		
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string quitBlurb = "I could have done something here.";

		writeln(quitBlurb);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyLayout : Layout
{
	int myButtonX = 10, myButtonY = 20;
	int myOtherButtonX = 10, myOtherButtonY = 60;
	
	this()
	{
		super(null, null);
		auto myButton = new MyButton();
		auto myOtherButton = new MyOtherButton();
		
		put(myButton, myButtonX, myButtonY);
		put(myOtherButton, myOtherButtonX, myOtherButtonY);
		
	} // this()
	
} // class MyLayout


class MyButton : Button
{
	string labelText = "Button Name";
	
	this()
	{
		super(labelText);
		addOnButtonRelease(&doSomething);
		
	} // this()
	
	
	bool doSomething(Event e, Widget w)
	{
		string message = "Something was done.";

		writeln(message);
		
		return(true);
		
	} // doSomething()

} // class MyButton


class MyOtherButton : Button
{
	string labelText = "Other Button Name";
		
	this()
	{
		super(labelText);

		addOnClicked(delegate void(_) { doSomething(); } );
		
	} // this()
	
	
	void doSomething()
	{
		string message = "Something other than that was done.";

		writeln(message);
		
	} // doSomething()

} // class MyOtherButton
