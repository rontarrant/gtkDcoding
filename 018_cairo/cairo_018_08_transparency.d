// Cairo: Transparency

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
	string title = "Cairo: Transparency";
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
		int i;
		
		// middle gray background
		context.setSourceRgba(0.75, 0.75, 0.75, 1.0); // middle gray
		context.paint();
		
		// draw the blue line
		context.setLineWidth(20);
		context.setSourceRgba(0.384, 0.914, 0.976, 1.0);
		context.moveTo(10, 166);
		context.lineTo(630, 166);
		context.stroke();
		
		// 10 yellow rectangles with graduating transparency
		for(i = 0; i < 11; i++)
		{
			context.setSourceRgba(0.965, 1.0, 0.0, (i * 0.1));
			context.rectangle((i * 56), 150, 32, 32);
			context.fill();
		}
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
