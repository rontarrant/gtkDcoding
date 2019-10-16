// This source code is in the public domain.

// Center a window on the screen

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gdk.Event;
import gtk.Label;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Centered Window";
	AppBox appBox;
	int xPosition, yPosition;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		addOnConfigure(&onConfigure);
		
		appBox = new AppBox(this);
		add(appBox);
		
		showAll();

		getPosition(xPosition, yPosition);
		showWindowStats();
		
	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "At this point, we could save the window's position for next time the user runs this application.";
		writeln(exitMessage);

		showWindowStats();
		
		Main.quit();
		
	} // quitApp()


	bool onConfigure(Event event, Widget widget)
	{
		getPosition(xPosition, yPosition);
		writeln("The window is positioned at: x = ", xPosition, ", y = ", yPosition);
		
		return(false); // must be false or the window doesn't redraw properly.
		
	} // onConfigure()
	
	
	void showWindowStats()
	{
		writeln("Window stats...");
		writeln("position: xPosition = ", xPosition, ", yPosition = ", yPosition);
		
	} // showWindowStats()
	
} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	Label label;
	
	// add child object and variable definitions here
	
	this(TestRigWindow testRigWindow)
	{
		super(Orientation.VERTICAL, globalPadding);
		
		// instantiate child objects here
		label = new Label("This is a label");
		add(label);
		// packStart(<child object>, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox
