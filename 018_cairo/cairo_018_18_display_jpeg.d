// This source code is in the public domain.

// Cairo: Display JPeg

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import cairo.ImageSurface;
import gdk.Pixbuf;
import gdk.Cairo;
import cairo.Surface;
import gtk.DrawingArea;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Display JPeg";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(640, 387);
		
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
	Pixbuf pixbuf;
	int xOffset = 20, yOffset = 20;
	string filename = "./images/guitar_bridge.jpg";
	
	this()
	{
		pixbuf = new Pixbuf(filename);
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourcePixbuf(pixbuf, xOffset, yOffset);
		context.paint();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
