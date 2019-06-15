import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import cairo.Surface;
import gdk.Pixbuf;
import gdk.Cairo;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Display SVG";
	
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(578, 525);
		
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
	Pixbuf pixbuf;
	Context context;
	int x, y;
	string filename = "./images/Envy.svg";
	
	this()
	{
		pixbuf = new Pixbuf(filename);
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourcePixbuf(pixbuf, 0, 0);
		context.paint();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
