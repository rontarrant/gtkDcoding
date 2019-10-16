// This source code is in the public domain.

// Center a window on the screen

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gdk.Event;
import gtk.Container;

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
	int xPosition, yPosition, width = 320, height = 400;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		addOnCheckResize(&onCheckResize);
		addOnConfigure(&onConfigure);

		appBox = new AppBox(this);
		add(appBox);
		
		showAll();
		
	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Save the window stats for next time the user runs this application.";
		writeln(exitMessage);
		writeln("xPosition: ", xPosition, ", yPosition: ", yPosition, ", width: ", width, ", height: ", height);
		Main.quit();
		
	} // quitApp()


	void onCheckResize(Container container)
	{
		getSize(width, height);

		writeln("width: ", width, ", height: ", height);
		
	} // onCheckResize()
	
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
		writeln("size: width = ", width, ", height = ", height);
		
	} // showWindowStats()
	
} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	
	// add child object and variable definitions here
	
	this(TestRigWindow testRigWindow)
	{
		super(Orientation.VERTICAL, globalPadding);
		
		// instantiate child objects here
		
		// packStart(<child object>, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox
