/+ dub.sdl:
name "cairo_018_03_draw_rounded_lines"
description "Multiple Lines with Rounded Ends"
homepage "https://gtkdcoding.com/2019/07/30/0057-cairo-i-the-basics.html"
license "public domain"
dependency "gtk-d" version="~>3.9.0"
+/
// This source code is in the public domain.

// Cairo: Draw Lines with Rounded Ends

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
	string title = "Cairo: Draw Lines with Rounded Ends";
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
		context.setLineWidth(10);
		context.setLineCap(CairoLineCap.ROUND); // options are: BUTT, ROUND, SQUARE
		context.setLineJoin(CairoLineJoin.ROUND); // options are: MITER, ROUND, BEVEL
		context.moveTo(10, 10);
		context.lineTo(249, 249);
		context.lineTo(450, 15);
		context.lineTo(450, 249);
		context.stroke();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
