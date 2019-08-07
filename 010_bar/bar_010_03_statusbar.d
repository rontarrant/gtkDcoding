// Description of example

import std.stdio;
import std.string;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.DrawingArea;
import cairo.Context;
import gdk.Event;
import gtk.Statusbar;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "<Insert Title>";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);

		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyDrawingArea myDrawingArea;
	MyStatusbar myStatusbar;
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myStatusbar = new MyStatusbar();

		myDrawingArea = new MyDrawingArea(myStatusbar);
		packStart(myDrawingArea, true, true, 0);
		
		packStart(myStatusbar, true, true, 0);
		
	} // this()


} // class AppBox


class MyDrawingArea : DrawingArea
{
	//              R    G    B    Alpha
	float[] rgba = [0.3, 0.6, 0.2, 0.9];
	MyStatusbar _myStatusbar;
	
	this(MyStatusbar myStatusbar)
	{
		_myStatusbar = myStatusbar;

		setSizeRequest(640, 360);

		addOnDraw(&onDraw);
		addOnMotionNotify(&onMotion);
		
	} // this()
	
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceRgba(rgba[0], rgba[1], rgba[2], rgba[3]);
		context.paint();

		return(true);
		
	} // onDraw()


	public bool onMotion(Event event, Widget widget)
	{
		// make sure we're not reacting to the wrong event
		if(event.type == EventType.MOTION_NOTIFY)
		{
			// note: format() sees double variables as strings
			_myStatusbar.push(_myStatusbar.contextID, "Mouse position: " ~ format("%s, %s", event.motion.x, event.motion.y));
		}

		return(true);
		
	} // onMotion()
	
} // class MyDrawingArea


class MyStatusbar : Statusbar
{
	uint contextID;
	string contextDescription = "Mouse position within the DrawingArea";
	
	this()
	{
		contextID = getContextId(contextDescription);
		
	} // this()

} // class MyStatusBar
