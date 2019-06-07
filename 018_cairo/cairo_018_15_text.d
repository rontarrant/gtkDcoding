// put text in a DrawingArea

import std.stdio;

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
	int width, height;
	
	this(string title)
	{
		super(title);
		setSizeRequest(640, 360);
		getSizeRequest(width, height);
		
		addOnDestroy(&quitApp);
		
		appBox = new AppBox([width, height]);
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
	
	this(int[] widthHeight)
	{
		super(Orientation.VERTICAL, 10);
		
		myDrawingArea = new MyDrawingArea(widthHeight);
		
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyDrawingArea : DrawingArea
{
	cairo_text_extents_t extents;
	int _width, _height;
	
	this(int[] widthHeight)
	{
		_width = widthHeight[0];
		_height = widthHeight[1];
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// set the font, size, and color
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
		context.setFontSize(35);
		context.setSourceRgb(0.0, 0.0, 1.0);
		// find the dimensions of the text so we can center it
		context.textExtents("Hello World", &extents);
		context.moveTo(_width / 2 - extents.width / 2, _height / 2 - extents.height / 2);
		context.showText("Hello World");
				
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
