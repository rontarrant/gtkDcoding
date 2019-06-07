import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import cairo.ImageSurface;
import cairo.Surface;
import gtk.DrawingArea;
import gdk.Pixbuf;
import gdkpixbuf.PixbufFormat;
import glib.ListSG;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
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
	GtkAllocation size; // the area assigned to the DrawingArea by its parent
	Pixbuf pixbuf; // an 8-bit/pixel image buffer
	string[] jpegOptions, jpegOptionValues;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// set up and draw a rectangle
		context.setSourceRgb(0.541, 0.835, 0.886); // pen color
		context.rectangle(150, 100, 340, 170); // rectangle upper-left/lower-right corners
		context.fill(); // draw the rectangle

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
