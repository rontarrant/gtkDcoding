import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import gdk.Pixbuf;

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRigWindow = new testRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
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
	GtkAllocation size; // the area assigned to the DrawingArea by its parent
	Pixbuf pixbuf; // an 8-bit/pixel image buffer
	string[] pngOptions, pngOptionValues;
	int xOffset = 0, yOffset = 0;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// set up and draw a rectangle
		context.setSourceRgb(0.502, 0.886, 0.765); // pen color
		context.rectangle(150, 100, 340, 170); // rectangle upper-left/lower-right corners
		context.fill(); // draw the rectangle

		// set up and draw text
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.BOLD); // set the font
		context.setFontSize(15); // set the font size
		context.setSourceRgb(0.078, 0.384, 0.184); // set the pen color
		context.moveTo(260, 185); // put the pen in position
		context.showText("Hello, PNG World."); // and draw
		
		getAllocation(size); // grab the widget's size as allocated by its parent
		pixbuf = getFromSurface(context.getTarget(), xOffset, yOffset, size.width, size.height); // the contents of the surface go into the buffer
		
		// prep and write to a PNG
		pngOptions = ["x-dpi", "y-dpi", "compression"];
		pngOptionValues = ["150", "150", "1"];
		
		if(pixbuf.savev("./rectangle_hw.png", "png", pngOptions, pngOptionValues))
		{
			writeln("PNG was successfully saved.");
			
		}

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
