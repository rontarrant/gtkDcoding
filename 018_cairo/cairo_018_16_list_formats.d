import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import cairo.Context;
import gtk.DrawingArea;
import gdk.Pixbuf;
import gdkpixbuf.PixbufFormat;
import glib.ListSG;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: List Image Formats";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(640, 640);
		
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
	GtkAllocation size; // the area assigned to the DrawingArea by its parent
	Pixbuf pixbuf; // an 8-bit/pixel image buffer
	ListSG formatList;
	PixbufFormat pixbufFormat;
	PixbufFormat[] pixbufFormats;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		int y = 20;
		string format;
		
		// get the DrawingArea's Pixbuf using the dimensions allocated by the DrawingArea's parent
		getAllocation(size);
		pixbuf = getFromSurface(context.getTarget(), 0, 0, size.width, size.height);
		// get the list of formats and stuff them into a string array
		formatList = pixbuf.getFormats();
		pixbufFormats = formatList.toArray!PixbufFormat();
		// set up a font...
		context.selectFontFace("Arial", CairoFontSlant.NORMAL, CairoFontWeight.BOLD);
		context.setFontSize(12);
		context.setSourceRgb(0.0, 0.0, 1.0);
		// so we can print a header
		context.moveTo(20, y);
		context.showText("Formats found:");

		// advance the cursor down the page...
		y = y + 30;
		
		// set up another font...
		context.selectFontFace("Times New Roman", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
		context.setFontSize(12);
		context.setSourceRgb(0.0, 0.0, 1.0);
		//  so we can print the list in the DrawingArea		
		foreach(pixbufFormat; pixbufFormats)
		{
			context.moveTo(40, y);
			format = pixbufFormat.getName();
			context.showText(format);
			y += 30;
		}

		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
