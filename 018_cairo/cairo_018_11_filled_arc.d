// Cairo: Fill an arc

import std.stdio;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import cairo.Surface;
import gtk.DrawingArea;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Cairo: Draw an Arc");
	
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
	Surface surface;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		/*	x & y = position of the center of the arc
		 * radius = the radius of the arc
		 * angle1 = the start angle, in radians
		 * angle2 = the end angle, in radians
		*/
		float x = 320, y = 180, radius = 40, angle1 = 0.7, angle2 = 2.44;
		
	 	// draw the arc
		context.setLineWidth(3);
		context.arc(x, y, radius, angle1, angle2);
		context.fill();

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
