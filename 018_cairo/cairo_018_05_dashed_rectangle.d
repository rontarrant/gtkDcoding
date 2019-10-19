/+ dub.sdl:
name "cairo_018_05_dashed_rectangle"
description "The Dashed-line Rectangle"
homepage "https://gtkdcoding.com/2019/08/02/0058-cairo-ii-rectangles.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Cairo: Dashed Rectangle

import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
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
	string title = "Cairo: Dashed Rectangle";
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
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		double[] dashPattern = [10, 20, 30, 40];
		// set up and draw a dashed-line rectangle
		context.setLineWidth(3);
		context.setSourceRgba(0.1, 0.2, 0.3, 0.8);
		context.rectangle(150, 100, 340, 170);
		context.setDash(dashPattern, 0);
		context.stroke();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
