// Cairo: Draw Lines with Rounded Ends

import std.stdio;
import std.conv;
import std.math;

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
	string title = "Cairo: Draw Lines with Rounded Ends";
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
	DragNode dragNode1, dragNode2;
	
	this()
	{
		addOnDraw(&onDraw);
		
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		double x1 = 12, y1 = 12,
				 x2 = 120, y2 = 120;
				 
		dragNode1 = new DragNode(context, x1, y1);
		dragNode2 = new DragNode(context, x2, y2);
		
		return(true);
		
	} // onDraw()
	
} // class MyDrawingArea


class DragNode
{
	NodeShape nodeShape;
//	NodeBanner nodeBanner;
//	InTerminalStatus inTerminalStatus;
//	OutTerminalStatus outTerminalStatus;
	NodeTerminalIn nodeTerminalIn;
	NodeTerminalOut nodeTerminalOut;
	
	double _xOrigin, _yOrigin,
			 width = 100, height = 100;

	this(Context context, double x, double y)
	{
		_xOrigin = x;
		_yOrigin = y;

		nodeShape = new NodeShape(context, x, y, width, height);
		nodeTerminalIn = new NodeTerminalIn(context, _xOrigin, _yOrigin + (height * .33));
		nodeTerminalOut = new NodeTerminalOut(context, _xOrigin + width, _yOrigin + (height * .66));
			
	} // this()

} // class DragNode


class NodeShape
{
	double _xOrigin, _yOrigin,
	 		 aspectRatio = 1.0,
	 		 cornerRadius, radians;
	double lineWidth = 2;
	double[] rimRGBA = [0.5, 0.1, 0.5, 1.0];
	double[] fillRGBA = [0.518, 0.820, 0.471, 1.0];

	this(Context context, double xPosition, double yPosition, double width, double height)
	{
		_xOrigin = xPosition;
		_yOrigin = yPosition;
		cornerRadius = height / 10.0;
		radians = PI / 180.0;

		double xRight = xPosition + width - cornerRadius,
				 xLeft = xPosition + cornerRadius,
				 yUpper = yPosition + cornerRadius,
				 yLower = yPosition + height - cornerRadius;
		double[] northEastArc = [-90 * radians, 0 * radians],
					southEastArc = [0 * radians, 90 * radians],
					southWestArc = [90 * radians, 180 * radians],
					northWestArc = [180 * radians, 270 * radians];

		// describe a round-shouldered rectangle
		context.newSubPath();
		context.arc(xRight, yUpper, cornerRadius, northEastArc[0], northEastArc[1]); // upper right corner
		context.arc(xRight, yLower, cornerRadius, southEastArc[0], southEastArc[1]); // lower right corner
		context.arc(xLeft,  yLower, cornerRadius, southWestArc[0], southWestArc[1]); // lower left corner
		context.arc(xLeft,  yUpper, cornerRadius, northWestArc[0], northWestArc[1]); // upper left corner
		context.closePath();
		
		// fill it (needs to be done first)
		context.setSourceRgba(fillRGBA[0], fillRGBA[1], fillRGBA[2], fillRGBA[3]);
		context.fillPreserve();

		// draw it
		context.setSourceRgba(rimRGBA[0], rimRGBA[1], rimRGBA[2], rimRGBA[3]);
		context.setLineWidth(lineWidth);
		context.stroke();
		
	} // this()
	
} // class NodeShape


class NodeBannerShape
{
	double _xOrigin, _yOrigin,
	 		 aspectRatio = 1.0,
	 		 cornerRadius, radius, radians, lineWidth = 2;
	double[] rimRGBA = [0.5, 0.1, 0.5, 1.0];
	double[] fillRGBA = [0.518, 0.820, 0.471, 1.0];

	this(Context context, double x, double y, double width, double height)
	{
		_xOrigin = x;
		_yOrigin = y;
		cornerRadius = height *.33;
		radius = cornerRadius / aspectRatio;
		radians = PI / 180.0;

		// Params:
		// xc = X position of the center of the arc
		// yc = Y position of the center of the arc
		// radius = the radius of the arc
		// angle1 = the start angle, in radians
		// angle2 = the end angle, in radians

		// describe a round-shouldered rectangle
		context.newSubPath();
		context.arc(x + width - radius, y + radius, radius, -90 * radians, 0 * radians);
		context.arc(x + width - radius, y + height - radius, radius, 0 * radians, 90 * radians);
		context.arc(x + radius, y + height - radius, radius, 90 * radians, 180 * radians);
		context.arc(x + radius, y + radius, radius, 180 * radians, 270 * radians);
		context.closePath();
		
		// fill it (needs to be done first)
		context.setSourceRgba(fillRGBA[0], fillRGBA[1], fillRGBA[2], fillRGBA[3]);
		context.fillPreserve();

		// draw it
		context.setSourceRgba(rimRGBA[0], rimRGBA[1], rimRGBA[2], rimRGBA[3]);
		context.setLineWidth(lineWidth);
		context.stroke();
		
	} // this()
	
} // class NodeBannerShape


class NodeTerminalIn : NodeTerminal
{
	double[] rimRGBA = [0.5, 0.0, 0.0, 1.0];
	double[] fillRGBA = [1.0, 0.706, 0.004, 1.0];
	
	this(Context context, double nodeXOrigin, double terminalYOffset)
	{
		super(context, nodeXOrigin, terminalYOffset, fillRGBA, rimRGBA);
		
	} // this()
	
} // class NodeTerminalIn


class NodeTerminalOut : NodeTerminal
{
	double[] rimRGBA = [0.5, 0.0, 0.0, 1.0];
	double[] fillRGBA = [0.988, 0.988, 0.051, 1.0];
	
	this(Context context, double nodeXOrigin, double terminalYOffset)
	{
		super(context, nodeXOrigin, terminalYOffset, fillRGBA, rimRGBA);
		
	} // this()
	
} // class NodeTerminalIn


// NOTE: xOffset and yOffset should be one level up in InNodeTerminal and OutNodeTerminal
class NodeTerminal
{
	double radius = 5,
			 lineWidth = 2;
	
	this(Context context, double nodeXOrigin, double terminalYOffset, double[] fillRGBA, double[] rimRGBA)
	{
		// set up the path and color
		context.newSubPath();
		context.arc(nodeXOrigin, terminalYOffset, radius, 0, PI * 2);
		context.closePath();
		
		// fill the circle
		context.setSourceRgba(fillRGBA[0], fillRGBA[1], fillRGBA[2], fillRGBA[3]);
		context.fillPreserve();
		
		// color the path
		context.setSourceRgba(rimRGBA[0], rimRGBA[1], rimRGBA[2], rimRGBA[3]);
		context.stroke();
		
	} // this()
	
} // class NodeTerminal
