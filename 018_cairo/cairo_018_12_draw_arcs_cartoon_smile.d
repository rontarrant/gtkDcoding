// Cairo: Draw a cartoon smile

import std.stdio;
import std.math;

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
		float x1 = 213, y1 = 160, x2, y2, x3, y3, radius1 = 40, radius2 = 10;
		
		// draw the first arc (the mouth shape)
		context.setLineWidth(3);
		context.arc(x1, y1, radius1, 0.7, 2.44);
		context.stroke();
		// find the right corner of the mouth shape
		x2 = x1 + cos(0.7) * radius1;
		y2 = y1 + sin(0.7) * radius1;
		// draw the second arc
		context.arc(x2, y2, radius2, 4.2, 0.7);
		context.stroke();
		// find the left corner of the mouth shape
		x3 = x1 + cos(2.44) * radius1;
		y3 = y1 + sin(2.44) * radius1;
		// draw the third arc
		context.arc(x3, y3, radius2, 2.6, 5.6);
		context.stroke();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
