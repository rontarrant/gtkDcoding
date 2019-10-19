/+ dub.sdl:
name "cairo_018_25_draw_circle_animation"
description "Animating the Drawing of a Circle"
homepage "https://gtkdcoding.com/2019/08/23/0064-cairo-vii-drawingarea-animation.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Cairo: Animte Drawing a Circle

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
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Animate Drawing a Circle";
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
	float arcLength = PI / 12;
	int fps = 1000 / 12; // 12 frames per second
	
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
		GtkAllocation size;
		getAllocation(size);
		
		queueDrawArea(size.x, size.y, size.width, size.height);
		
		return(true);
		
	} // onFrameElapsed()
	
} // class MyDrawingArea
