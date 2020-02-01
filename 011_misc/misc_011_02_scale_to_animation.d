// This source code is in the public domain.

// Scale Controls Ball Position in DrawingArea

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Scale;
import gtk.Range;
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
	string title = "Scale Moves Ball";
	int borderWidth = 10;
	int width = 250;
	int height = 175;
	AppBox appBox;
	string exitMessage = "Bye.";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setBorderWidth(borderWidth);
		setSizeRequest(width, height);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		writeln(exitMessage);
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyScale myScale;
	int localPadding = 0, globalPadding = 10;
	bool expand = false, fill = false;
	MyDrawingArea myDrawingArea;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myDrawingArea = new MyDrawingArea();
		myScale = new MyScale(myDrawingArea);

		packStart(myScale, expand, fill, localPadding);
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyScale : Scale
{
	double minimum = 0;
	double maximum = 10;
	double step = 1;
	MyDrawingArea ballDisplay;
	
	this(MyDrawingArea myDrawingArea)
	{
		super(Orientation.HORIZONTAL, minimum, maximum, step);
		
		ballDisplay = myDrawingArea;
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(Range range)
	{
		double scaleValue = getValue();
		ballDisplay.setBallPosition(cast(int)scaleValue);
		
	} // valueChanged()


} // class MyScaleButton


class MyDrawingArea : DrawingArea
{
	int ballX, prevBallX;
	
	this()
	{
		ballX = 30;
		
		addOnDraw(&onDraw);
		
	} // this()
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setLineWidth(3); // prepare the context
		context.arc(ballX, 50, 10, 0, 2 * 3.1415); // define the circle as an arc
		context.stroke(); // and draw

		return(true);
		
	} // onDraw()
	
	
	void setBallPosition(int x)
	{
		x *= 15; // move the ball a noticeable distance
		ballX = x + 30;
		queueDraw();
		
	} // setBallPosition()
	
} // class MyDrawingArea
