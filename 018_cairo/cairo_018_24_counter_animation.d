// This source code is in the public domain.

// Cairo: Animate a Text Counter

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
	string title = "Cairo: Animate a Text Counter";
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
	int number = 1;
	int fps = 1000 / 24; // 24 frames per second
	
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
		
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
		context.setFontSize(35);
		context.setSourceRgb(0.0, 0.0, 1.0);
		context.moveTo(580, 340); // bottom right corner
		
		if(number > 24) // number range: 1 - 24
		{
			number = 1;
		}

		context.showText(number.to!string());
		number++;

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
