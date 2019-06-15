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
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Draw Cartoon Smile";
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
		float xPos1 = 213, yPos1 = 160, xPos2, yPos2;
		float xPos3, yPos3, radius1 = 40, radius2 = 10;
		
		// draw the first arc (the mouth shape)
		context.setLineWidth(3);
		context.arc(xPos1, yPos1, radius1, 0.7, 2.44);
		context.stroke();
		// find the right corner of the mouth shape
		xPos2 = xPos1 + cos(0.7) * radius1;
		yPos2 = yPos1 + sin(0.7) * radius1;
		// draw the second arc
		context.arc(xPos2, yPos2, radius2, 4.2, 0.7);
		context.stroke();
		// find the left corner of the mouth shape
		xPos3 = xPos1 + cos(2.44) * radius1;
		yPos3 = yPos1 + sin(2.44) * radius1;
		// draw the third arc
		context.arc(xPos3, yPos3, radius2, 2.6, 5.6);
		context.stroke();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
