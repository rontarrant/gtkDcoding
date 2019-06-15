// Cairo: Draw an arc

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
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Draw an Arc";
	int width = 640, height = 360; 
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(width, height);
		
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
		float x = 320, y = 180;
		float radius = 40, startAngle = 0.7, endAngle = 2.44;
		/*	x & y = position of the center of an imaginary circle
		 * radius = the radius of the circle
		 * angle1 = the start angle of the arc, in radians
		 * angle2 = the end angle of the arc, in radians
		*/
		
	 	// draw the arc
		context.setLineWidth(3);
		context.arc(x, y, radius, startAngle, endAngle);
		context.stroke();

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
