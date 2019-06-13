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

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Toy Text";
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

} // class myAppWindow


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
	cairo_text_extents_t extents;
	
	this()
	{
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		getAllocation(size);
writeln("Allocation.width: ", size.width, " Allocation.height: ", size.height);
		// set the font, size, and color
		context.selectFontFace("Comic Sans MS", CairoFontSlant.NORMAL, CairoFontWeight.NORMAL);
		context.setFontSize(35);
		context.setSourceRgb(0.0, 0.0, 1.0);
		// find the dimensions of the text so we can center it
		context.textExtents("Hello World", &extents);
writeln("extents.width: ", extents.width, " extents.height: ", extents.height);
		context.moveTo(size.width / 2 - extents.width / 2, size.height / 2 - extents.height / 2);
		context.showText("Hello World");
writeln("position of text - x: ", (size.width / 2 - extents.width / 2), " - y: ", (size.height / 2 - extents.height / 2));
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea
