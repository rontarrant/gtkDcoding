// This source code is in the public domain.

// Cairo: Animate a Flipbook

import std.stdio;
import std.conv;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import cairo.Surface;
import gdk.Pixbuf;
import gdk.Cairo;
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
	string title = "Cairo: Animate a Flipbook";
	int width = 992, height = 720; 
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
	int currentFrame = 0;
	int fps = 1000 / 12; // 6 frames per second
	Timeout _timeout;
	Pixbuf[] pixbufs;
	int numberOfFrames = 75;
	
	this()
	{
		for(int i = 0; i < numberOfFrames; i++)
		{
			if(i < 10)
			{
				pixbufs ~= new Pixbuf("./images/sequence/one00" ~ i.to!string() ~ ".tif");
			}
			else
			{
				pixbufs ~= new Pixbuf("./images/sequence/one0" ~ i.to!string() ~ ".tif");
			}

		} // for()
		
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
			
		}
		
		context.setSourcePixbuf(pixbufs[currentFrame], 0, 0);
		context.paint();
		
		currentFrame += 1;
		
		if(currentFrame >= numberOfFrames)
		{
			currentFrame = 0;
		}
		
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
