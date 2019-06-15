// a ScrolledWindow example

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
	
	TestRigWindow testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "ScrolledWindow Example";
	int windowWidth = 200, windowHeight = 200;
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(windowWidth, windowHeight);
		
		ScrolledWindow scrolledWindow = new ScrolledWindow();
		add(scrolledWindow);
		
		auto myLayout = new MyLayout();
		scrolledWindow.add(myLayout);

		showAll();

	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyLayout : Layout
{
	int buttonX = 20, buttonY = 20;
	int otherButtonX = 20, otherButtonY = 100;
	int layoutWidth = 400, layoutHeight = 400;
	
	this()
	{
		super(null, null);
		setSize(layoutWidth, layoutHeight);
		
		auto myButton = new MyButton();
		put(myButton, buttonX, buttonY);
		
		auto myOtherButton = new MyOtherButton();
		put(myOtherButton, otherButtonX, otherButtonY);
		
	} // this()
	
} // class MyLayout


class MyButton : Button
{
	string labelText = "Button Name";
	int width = 160, height = 60;
	
	this()
	{
		super(labelText);
		
		addOnButtonRelease(&doSomething);
		
		setSizeRequest(width, height);
				
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
		int width = 160, height = 60;
		
		super(labelText);
		
		addOnClicked(delegate void(_) { doSomething(); } );
		
		setSizeRequest(width, height);
				
	} // this()
	
	
	void doSomething()
	{
		string message = "Something other than that was done.";

		writeln(message);
		
	} // doSomething()

} // class MyButton
