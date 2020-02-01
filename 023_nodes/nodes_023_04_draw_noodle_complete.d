// This source code is in the public domain.

// Cairo: Draw a Curve

import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.DrawingArea;

import gdk.Event;

import glib.Timeout;

import cairo.Context;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Draw a Curve";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(640, 360);
		
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyDrawingArea myDrawingArea;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		myDrawingArea = new MyDrawingArea();
		
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyDrawingArea : DrawingArea
{
	Timeout _timeout;
	int fps = 1000 / 24; // 24 frames per second
	bool dragAndDraw = false;
	double xStart, yStart;
	double controlPointX1, controlPointY1,
		   controlPointX2, controlPointY2,
		   xEnd, yEnd;

	this()
	{
		addOnDraw(&onDraw);
		addOnButtonPress(&onButtonPress);
		addOnMotionNotify(&onMotion);
		addOnButtonRelease(&onButtonRelease);

	} // this()


	public bool onButtonPress(Event event, Widget widget)
	{
		bool returnValue = false;

		// tell Cairo it can start drawing
		dragAndDraw = true;

		if(event.type == EventType.BUTTON_PRESS)
		{
			xStart = event.button.x;
			yStart = event.button.y;
			
			returnValue = true;
		}

		return(returnValue);
		
	} // onButtonPress()


	public bool onMotion(Event event, Widget widget)
	{
		bool returnValue = false;
		
		// make sure we're not reacting to the wrong event
		if(event.type == EventType.MOTION_NOTIFY)
		{
			// get the curve's end point
			xEnd = event.motion.x;
			yEnd = event.motion.y;
			
			// Recalculate the control points so we always have
			// a nice-looking double curve.
			controlPointX1 = xEnd;
			controlPointY1 = yStart;
			controlPointX2 = xStart;
			controlPointY2 = yEnd;
			
			returnValue = true;
		}

		return(returnValue);
		
	} // onMotion()

	
	public bool onButtonRelease(Event event, Widget widget)
	{
		bool returnValue = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			xEnd = event.button.x;
			yEnd = event.button.y;
			returnValue = true;
		}

		dragAndDraw = false;

		return(returnValue);
		
	} // onButtonRelease()


	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
		}

		if(dragAndDraw == true)
		{
			// set up and draw a cubic Bezier
			context.setLineWidth(3);
			context.setSourceRgb(0.3, 0.2, 0.1);
			context.moveTo(xStart, yStart);
			context.curveTo(controlPointX1, controlPointY1, controlPointX2, controlPointY2, xEnd, yEnd);
			context.stroke();
		}

		return(true);
		
	} // onDraw()


	bool onFrameElapsed()
	{
		if(dragAndDraw == true)
		{
			queueDraw();
		}
		
		return(true);
		
	} // onFrameElapsed()
	
} // class MyDrawingArea
