/+ dub.sdl:
name "cairo_018_20_draw_save_jpeg"
description "Saving a JPeg"
homepage "https://gtkdcoding.com/2019/08/20/0063-cairo-vii-draw-save-images.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Cairo: Draw and Save a JPeg

import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import gdk.Pixbuf;
import gdkpixbuf.Pixbuf; // so we can see which file options exist

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Draw and Save a JPeg";
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
	GtkAllocation size; // the area assigned to the DrawingArea by its parent
	Pixbuf pixbuf; // an 8-bit/pixel image buffer
	string[] jpegOptions, jpegOptionValues;
	int xOffset = 0, yOffset = 0;
	
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

		// set up and draw text
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL); // set the font
		context.setFontSize(15); // set the font size
		context.setSourceRgb(0.129, 0.220, 0.886); // set the pen color
		context.moveTo(260, 185); // put the pen in position
		context.showText("Hello, JPeg World."); // and draw

		getAllocation(size); // grab the widget's size as allocated by its parent
		pixbuf = getFromSurface(context.getTarget(), xOffset, yOffset, size.width, size.height); // the contents of the surface go into the buffer
		
		// prep and write JPEG file
		jpegOptions = ["quality"]; 
		jpegOptionValues = ["100"];

		if(pixbuf.savev("./rectangle_hw.jpg", "jpeg", jpegOptions, jpegOptionValues))
		{
			writeln("JPEG was successfully saved.");
			
		}

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
