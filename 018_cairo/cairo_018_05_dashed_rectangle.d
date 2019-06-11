// Needs cleaning up. The dashed rectangle looks ragged.

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
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		double[] dashPattern = [5, 10, 15, 20];
		// set up and draw a dashed-line rectangle
		context.setLineWidth(3);
		context.setLineCap(CairoLineCap.SQUARE);
		context.setSourceRgba(0.1, 0.2, 0.3, 0.8); // pen color with alpha
		context.rectangle(150, 100, 340, 170); // rectangle upper-left/width/height
		context.setDash(dashPattern, 0);
		context.stroke();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
