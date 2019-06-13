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

	testRigWindow testRigWindow = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Fill Background";
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

} // class testRigWindow


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
	//              R    G    B    Alpha
	float[] rgba = [0.3, 0.6, 0.2, 0.9];
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceRgba(rgba[0], rgba[1], rgba[2], rgba[3]);
		context.paint();

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
