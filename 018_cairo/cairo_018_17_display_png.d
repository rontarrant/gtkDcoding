/+ dub.sdl:
name "cairo_018_17_display_png"
description "PNG – Load and Display"
homepage "https://gtkdcoding.com/2019/08/16/0062-cairo-vi-load-display-images.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Display PNG

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import cairo.ImageSurface;
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
	string title = "Display PNG";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(970, 546);
		
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
	Surface surface;
	string filename = "./images/foundlings.png";
	int xOffset = 0, yOffset = 0;
	
	this()
	{
		surface = ImageSurface.createFromPng(filename);
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceSurface(surface, xOffset, yOffset);
		context.paint();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
