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

	testRigWindow testRigWindow = new testRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
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

} // class testRigWindow


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
	string[] bmpOptions, bmpOptionValues;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// set up and draw a rectangle
		context.setSourceRgb(0.169, 0.0, 0.714); // pen color
		context.rectangle(150, 100, 340, 170); // rectangle upper-left/lower-right corners
		context.fill(); // draw the rectangle
		
		// set up and draw text
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.BOLD); // set the font
		context.setFontSize(15); // set the font size
		context.setSourceRgb(0.588, 0.976, 0.965); // set the pen color
		context.moveTo(260, 185); // put the pen in position
		context.showText("Hello, BMP World."); // and draw
		
		getAllocation(size); // grab the widget's size as allocated by its parent
		pixbuf = getFromSurface(context.getTarget(), 0, 0, size.width, size.height); // the contents of the surface go into the buffer

		// write to a BMP
		if(pixbuf.savev("./rectangle_hw.bmp", "bmp", [], []))
		{
			writeln("BMP was successfully saved.");
			
		}
	
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
