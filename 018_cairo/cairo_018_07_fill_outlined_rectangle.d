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
	string[] pngOptions, pngOptionValues;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// set up and outline a rectangle
		context.setLineWidth(1);
		context.setSourceRgba(0.1, 0.2, 0.3, 0.8); // pen color with alpha
		context.rectangle(150, 100, 340, 170); // rectangle upper-left corner and width/height
		context.stroke(); // draw a filled rectangle
		
		// prep for and fill rectangle
		context.setSourceRgba(0.945, 1.00, 0.694, 1.0); // make the fill color yellow
		context.rectangle(150, 100, 340, 170); // have to remind cairo of the shape we're about to fill
		context.fill(); // and fill
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
