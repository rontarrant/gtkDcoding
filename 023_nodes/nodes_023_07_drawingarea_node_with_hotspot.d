// This source code is in the public domain.

// Nodes - Setting up Hotspots

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
	string title = "Nodes - Hotspots";
	AppBox appBox;
	
	this()
	{
		super(title);
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
	
	this()
	{
		super(Orientation.VERTICAL, 10);

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
	NodeShape nodeShape; // appearance of the node
	NodeHandle nodeHandle; // appearance of the drag handle
	NodeTerminalIn nodeTerminalIn; // appearance of the input terminal
	TerminalInStatus terminalInStatus; // appearance of the input terminal's status block
	NodeTerminalOut nodeTerminalOut; // appearance of the output terminal
	TerminalOutStatus terminalOutStatus; // appearance of the output terminal's status block
	
	int width = 113, height = 102;

	double[string] dragArea;
	double[string] inHotspot;
	double[string] outHotspot;

	this()
	{
		setSizeRequest(width, height); // without this, nothing shows

		nodeShape = new NodeShape();
		nodeTerminalIn = new NodeTerminalIn();
		terminalInStatus = new TerminalInStatus();
		nodeTerminalOut = new NodeTerminalOut();
		terminalOutStatus = new TerminalOutStatus();
		nodeHandle = new NodeHandle();
		addOnDraw(&onDraw);

		dragArea = ["left" : 13, "top" : 9, "right" : 99, "bottom" : 30];
		inHotspot = ["left" : 0, "top" : 27, "right" : 10, "bottom" : 38];
		outHotspot = ["left" : 100, "top" : 60, "right" : 110, "bottom" : 70];
		
		addOnButtonPress(&onButtonPress);

	} // this()
	
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		// call sub-objects' draw routines?
		nodeShape.draw(context);
		nodeTerminalIn.draw(context);
		terminalInStatus.draw(context);
		nodeTerminalOut.draw(context);
		terminalOutStatus.draw(context);
		nodeHandle.draw(context);

		return(true);
		
	} // onDraw()


	bool onButtonPress(Event event, Widget widget)
	{
		double xMouse, yMouse;
		GdkEventButton* buttonEvent = event.button;
		int button1 = 1;
		
		xMouse = buttonEvent.x;
		yMouse = buttonEvent.y;

		// restrict active areas to terminal connections and the dragbar
		if(xMouse > dragArea["left"] && xMouse < dragArea["right"] && yMouse > dragArea["top"] && yMouse < dragArea["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// dragArea
				GdkEventButton* mouseEvent = event.button;
				dragAreaActive(xMouse, yMouse);
			}
		}
		else if(xMouse > inHotspot["left"] && xMouse < inHotspot["right"] && yMouse > inHotspot["top"] && yMouse < inHotspot["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// inHotspot
				GdkEventButton* mouseEvent = event.button;
				terminalInActive(xMouse, yMouse);
			}
		}
		else if(xMouse > outHotspot["left"] && xMouse < outHotspot["right"] && yMouse > outHotspot["top"] && yMouse < outHotspot["bottom"])
		{
			if(buttonEvent.button is button1) // ModifierType.BUTTON1_MASK
			{
				// inHotspot
				GdkEventButton* mouseEvent = event.button;
				terminalOutActive(xMouse, yMouse);
			}
		}
	
		return(true);
		
	} // onButtonPress()


	void dragAreaActive(double xMouse, double yMouse)
	{
		// see if the mouse is in the drag area 
		writeln("dragArea: xMouse = ", xMouse, " yMouse = ", yMouse);
		
	} // dragAreaActive()
	

	void terminalInActive(double xMouse, double yMouse)
	{
		// see if the mouse is in the drag area 
		writeln("inHotspot: xMouse = ", xMouse, " yMouse = ", yMouse);
		
		// do something, then unset the flag
		
	} // dragAreaActive()
	

	void terminalOutActive(double xMouse, double yMouse)
	{
		// see if the mouse is in the drag area 
		writeln("outHotspot: xMouse = ", xMouse, " yMouse = ", yMouse);
		
		// do something, then unset the flag
		
	} // dragAreaActive()
	

} // class MoveableNode


class NodeShape
{
	double _xOffset = 6, _yOffset = 1,
			 width = 100, height = 100,
	 		 cornerRadius, radians;
	double xRight, xLeft, yUpper, yLower;
	double[] northEastArc, southEastArc, southWestArc, northWestArc;
	double lineWidth = 2;
	double[] rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] fillRGBA = [0.686, 0.776, 0.914, 1.0];

	this()
	{
		cornerRadius = height / 10.0;
		radians = PI / 180.0;

		xRight = _xOffset + width - cornerRadius;
		xLeft = _xOffset + cornerRadius;
		yUpper = _yOffset + cornerRadius;
		yLower = _yOffset + height - cornerRadius;
		northEastArc = [-90 * radians, 0 * radians];
		southEastArc = [0 * radians, 90 * radians];
		southWestArc = [90 * radians, 180 * radians];
		northWestArc = [180 * radians, 270 * radians];

	} // this()
	
	
	void draw(Context context)
	{
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

	} // draw()
	
} // class NodeShape


class NodeHandle
{
	double _xOffset = 13, _yOffset = 8,
			 width = 85, height = 20,
	 		 cornerRadius, radians;
	double xRight, xLeft, yUpper, yLower;
	double[] northEastArc, southEastArc, southWestArc, northWestArc;
	double lineWidth = 2;
	double[] rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] fillRGBA = [0.667, 0.933, 1.0, 1.0];


	this()
	{
		cornerRadius = height / 4.0;
		radians = PI / 180.0;

		xRight = _xOffset + width - cornerRadius;
		xLeft = _xOffset + cornerRadius;
		yUpper = _yOffset + cornerRadius;
		yLower = _yOffset + height - cornerRadius;
		northEastArc = [-90 * radians, 0 * radians];
		southEastArc = [0 * radians, 90 * radians];
		southWestArc = [90 * radians, 180 * radians];
		northWestArc = [180 * radians, 270 * radians];

	} // this()
	
	
	void draw(Context context)
	{
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

	} // draw()
	
} // class NodeHandle


class NodeTerminalIn : NodeTerminal
{
	double[] _rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] _fillRGBA = [1.0, 0.706, 0.004, 1.0];
	int _xOffset = 6, _yOffset = 34;
	
	this()
	{
		super(_xOffset, _yOffset, _fillRGBA, _rimRGBA);
		
	} // this()
	
} // class NodeTerminalIn


class NodeTerminalOut : NodeTerminal
{
	double[] _rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] _fillRGBA = [0.988, 0.988, 0.051, 1.0];
	int _xOffset = 105, _yOffset = 66;
	
	this()
	{
		super(_xOffset, _yOffset, _fillRGBA, _rimRGBA);
		
	} // this()
	
} // class NodeTerminalIn


// NOTE: xOffset and yOffset are one level up in InNodeTerminal and OutNodeTerminal
class NodeTerminal
{
	double _radius = 5,
			 _lineWidth = 2;
	int _xOffset, _yOffset;
	double[] _fillRGBA, _rimRGBA;
	
	this(int xOffset, int yOffset, double[] fillRGBA, double[] rimRGBA)
	{
		_xOffset = xOffset;
		_yOffset = yOffset;
		_fillRGBA = fillRGBA;
		_rimRGBA = rimRGBA;
		
	} // this()
	
	
	void draw(Context context)
	{
		// set up the path and color
		context.newSubPath();
		context.arc(_xOffset, _yOffset, _radius, 0, PI * 2);
		context.closePath();
		
		// fill the circle
		context.setSourceRgba(_fillRGBA[0], _fillRGBA[1], _fillRGBA[2], _fillRGBA[3]);
		context.fillPreserve();
		
		// color the path
		context.setSourceRgba(_rimRGBA[0], _rimRGBA[1], _rimRGBA[2], _rimRGBA[3]);
		context.setLineWidth(_lineWidth);
		context.stroke();
		
	} // draw()
	
} // class NodeTerminal


class TerminalInStatus : TerminalStatus
{
	int _xOffset = 13, _yOffset = 40;
	double[] _rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] _fillRGBA = [0.988, 0.902, 0.690, 1.0];

	this()
	{
		super(_xOffset, _yOffset, _fillRGBA, _rimRGBA);		
		
	} // this()
	
} // class TerminalInStatus


class TerminalOutStatus : TerminalStatus
{
	int _xOffset = 42, _yOffset = 73;
	double[] _rimRGBA = [0.129, 0.243, 0.608, 1.0];
	double[] _fillRGBA = [0.984, 0.984, 0.718, 1.0];

	this()
	{
		super(_xOffset, _yOffset, _fillRGBA, _rimRGBA);		
		
	} // this()
	
} // class TerminalOutStatus


class TerminalStatus
{
	double width = 58, height = 20,
	 		 cornerRadius, radians,
			 _xOffset, _yOffset;
	double xRight, xLeft, yUpper, yLower;
	double[] northEastArc, southEastArc, southWestArc, northWestArc;
	double lineWidth = 2;
	double[] _rimRGBA;
	double[] _fillRGBA;


	this(int xOffset, int yOffset, double[] fillRGBA, double[] rimRGBA)
	{
		cornerRadius = height / 4.0;
		radians = PI / 180.0;

		_fillRGBA = fillRGBA;
		_rimRGBA = rimRGBA;
		_xOffset = xOffset;
		_yOffset = yOffset;
		xRight = _xOffset + width - cornerRadius;
		xLeft = _xOffset + cornerRadius;
		yUpper = _yOffset + cornerRadius;
		yLower = _yOffset + height - cornerRadius;
		northEastArc = [-90 * radians, 0 * radians];
		southEastArc = [0 * radians, 90 * radians];
		southWestArc = [90 * radians, 180 * radians];
		northWestArc = [180 * radians, 270 * radians];

	} // this()
	
	
	void draw(Context context)
	{
		// describe a round-shouldered rectangle
		context.newSubPath();
		context.arc(xRight, yUpper, cornerRadius, northEastArc[0], northEastArc[1]); // upper right corner
		context.arc(xRight, yLower, cornerRadius, southEastArc[0], southEastArc[1]); // lower right corner
		context.arc(xLeft,  yLower, cornerRadius, southWestArc[0], southWestArc[1]); // lower left corner
		context.arc(xLeft,  yUpper, cornerRadius, northWestArc[0], northWestArc[1]); // upper left corner
		context.closePath();
		
		// fill it (needs to be done before the outline)
		context.setSourceRgba(_fillRGBA[0], _fillRGBA[1], _fillRGBA[2], _fillRGBA[3]);
		context.fillPreserve();

		// draw it
		context.setSourceRgba(_rimRGBA[0], _rimRGBA[1], _rimRGBA[2], _rimRGBA[3]);
		context.setLineWidth(lineWidth);
		context.stroke();

	} // draw()

} // class TerminalStatus
