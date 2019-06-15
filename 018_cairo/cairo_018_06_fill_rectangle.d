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
	string title = "Cairo: Filled Rectangle";
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
		// fill rectangle
		context.setSourceRgb(0.541, 0.835, 0.886); // sky blue
		context.rectangle(150, 100, 340, 170); // x, y, w, h
		context.fill();

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
