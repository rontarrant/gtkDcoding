// Cairo: Draw an arc

import std.stdio;
import std.conv;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import glib.Timeout;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Draw an Arc";
	int width = 640, height = 360; 
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(width, height);
		
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

} // class myAppWindow


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
	float arcLength = PI / 12;
	int fps = 1000 / 12; // 12 frames per second
	cairo_text_extents_t extents;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
			
		}
		
		if(arcLength > (PI * 2)) // number range: 1 - 24
		{
			arcLength = PI / 12;
		}

		arcLength += (PI / 12);

		context.setLineWidth(3); // prepare the context
		context.arc(320, 180, 40, 0, arcLength); // draw the circle in 12 segments
		context.stroke(); // and draw
		
		return(true);
		
	} // onDraw()


	bool onFrameElapsed()
	{
		GtkAllocation area;
		getAllocation(area);
		
		queueDrawArea(area.x, area.y, area.width, area.height);
		
		return(true);
		
	} // onFrameElapsed()
	
} // class MyDrawingArea
