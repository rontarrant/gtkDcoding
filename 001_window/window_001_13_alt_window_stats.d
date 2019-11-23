// This source code is in the public domain.

// alternate way to get window stats

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
	string title = "Window Stats - Alt";
	AppBox appBox;
	int xPosition, yPosition, width = 275, height = 100;
	bool _isMaximized;
	
	this()
	{
		super(title);
		setSizeRequest(width, height);
		
		addOnDestroy(&quitApp);
		addOnConfigure(&onConfigureEvent);
		
		appBox = new AppBox(this);
		add(appBox);
		
		showAll();
		
	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Save the window stats for next time the user runs this application.";
		writeln(exitMessage);
		showWindowStats();
		checkMaxState();
		
		Main.quit();
		
	} // quitApp()


	bool onConfigureEvent(GdkEventConfigure* event, Widget widget)
	{
		int eventX, eventY, eventWidth, eventHeight;

		if(event.type is EventType.CONFIGURE)
		{
			xPosition = eventX = event.x;
			yPosition = eventY = event.y;
			width = event.width;
			height = event.height;
		}
		
		if(isMaximized())
		{
			_isMaximized = true;
		}
		else
		{
			_isMaximized = false;
		}

		writeln("Window position - x: ", xPosition, ", y: ", yPosition, ", Window area - width: ", width, ", height: ", height);

		return(false); // must be false or the window doesn't redraw properly.
		
	} // onConfigure()


	void showWindowStats()
	{
		writeln("Window stats...");
		writeln("position: xPosition = ", xPosition, ", yPosition = ", yPosition);
		writeln("size: width = ", width, ", height = ", height);
		
	} // showWindowStats()
	

	void checkMaxState()
	{
		if(_isMaximized)
		{
			writeln("Window maximized.");
		}
		else
		{
			writeln("Window NOT maximized.");
		}
		
	} // checkMaxState()

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
