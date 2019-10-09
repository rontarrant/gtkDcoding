// Cairo: Draw Lines with Rounded Ends

import std.stdio;
import std.conv;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.DrawingArea;
import gtk.Widget;
import gtk.Layout;
import gtk.Image;
import gdkpixbuf.Pixbuf;
import gdk.Event;

import cairo.Context;
import cairo.ImageSurface;
import cairo.Surface;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Nodes - Stage 1";
	AppBox appBox;
	
	this()
	{
		super(title);
//		setSizeRequest(640, 360);
		
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
	NodeLayout nodeLayout;
	uint globalPadding = 10;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);

		nodeLayout = new NodeLayout();
		add(nodeLayout);
			
	} // this()

} // class AppBox


class NodeLayout : Layout
{
	MoveableNode moveableNode;
	
	this()
	{
		super(null, null);
		setSizeRequest(640, 360); // has to be set so signals get through from child widgets
		
		moveableNode = new MoveableNode();
		put(moveableNode, 20, 140);		
		
	} // this()
	
} // class NodeLayout


class MoveableNode : DrawingArea
{
	private:
	Surface _surface;
	string _imageFilename = "images/node.png";
	int _xOffset = 0, _yOffset = 0, _width, _height;
	GtkAllocation _size;
	
	public:	
	this()
	{
		_surface = ImageSurface.createFromPng(_imageFilename);
		Pixbuf.getFileInfo(_imageFilename, _width, _height); // get the image size

		addOnDraw(&onDraw);
		addOnButtonPress(&doSomething);
		addOnButtonRelease(&doSomethingElse);
		
	} // this()
	
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceSurface(_surface, _xOffset, _yOffset);
		getAllocation(_size);
		setSizeRequest(_width, _height);

		context.paint();
		
		return(true);
		
	} // onDraw()


	bool doSomething(Event e, Widget w)
	{
		writeln("down");
	
		return(true);
		
	} // doSomething()


	bool doSomethingElse(Event e, Widget w)
	{
		writeln("up");
	
		return(true);
		
	} // doSomethingElse()
	
} // class MoveableNode
