import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import cairo.ImageSurface;
import gdk.Pixbuf;
import gdk.Cairo;
import cairo.Surface;
import gtk.DrawingArea;

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRigWindow = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Cairo: Display JPeg";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(600, 337);
		
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
	Surface surface;
	Pixbuf pixbuf;
	Context context;
	int x, y;
	
	this()
	{
		pixbuf = new Pixbuf("./images/guitar_bridge.jpg");
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourcePixbuf(pixbuf, 0, 0);
		context.paint();
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
