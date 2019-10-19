/+ dub.sdl:
name "cairo_018_19_display_svg"
description "SVG – Load and Display"
homepage "https://gtkdcoding.com/2019/08/16/0062-cairo-vi-load-display-images.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Display SVG

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import cairo.Surface;
import gdk.Pixbuf;
import gdk.Cairo;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Display SVG";
	int svgWidth = 356, svgHeight = 356;
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(svgWidth, svgHeight);
		
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
	int globalPadding = 10;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myDrawingArea = new MyDrawingArea();
		
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyDrawingArea : DrawingArea
{
	Pixbuf pixbuf;
	Context context;
	int xOffset = 0, yOffset = 0;
	string filename = "./images/Envy.svg";
	
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
