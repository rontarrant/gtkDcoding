// Description of example

import std.stdio;
import std.conv;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Box;
import gdk.Event;
import gtk.Notebook;
import gtk.TextView;
import gtk.TextBuffer;

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
	string title = "Notebook - Multiple Custom Tabs";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyNotebook myNotebook;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myNotebook = new MyNotebook();
		
		packStart(myNotebook, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class MyNotebook : Notebook
{
	PositionType tabPosition = PositionType.TOP;
	string tabLabelPrefix = "Custom Tab";
	
	CustomTab customTab1, customTab2, customTab3;
	MyTextView myTextview1, myTextview2, myTextview3;
	string myTextView1Content = "Now is the witness of our discontinent.";
	string myTextView2Content = "Four stores and seven pounds ago...";
	string myTextView3Content = "Help me open yon cantelope.";
	
	this()
	{
		super();
		setTabPos(tabPosition);

		myTextview1 = new MyTextView(myTextView1Content);
		customTab1 = new CustomTab(tabLabelPrefix, 0, this);
		appendPage(myTextview1, customTab1);

		myTextview2 = new MyTextView(myTextView2Content);
		customTab2 = new CustomTab(tabLabelPrefix, 1, this);
		appendPage(myTextview2, customTab2);
				
		myTextview3 = new MyTextView(myTextView3Content);
		customTab3 = new CustomTab(tabLabelPrefix, 2, this);
		appendPage(myTextview3, customTab3);

		addOnSwitchPage(&onSwitchPage);
		
	} // this()
	
	
	void onSwitchPage(Widget widget, uint pageNumber, Notebook notebook)
	{
		writeln("Current page: ", pageNumber);
			
	} // addOnChangeCurrentPage()
		
} // class MyNotebook


class CustomTab : Box
{
	TabDrawingArea tabDrawingArea;
	Notebook _notebook;
	
	this(string tabLabel, int tabNumber, Notebook notebook)
	{
		super(Orientation.HORIZONTAL, 0);
		tabDrawingArea = new TabDrawingArea(tabLabel, tabNumber, notebook);
		packStart(tabDrawingArea, true, true, 0);
		_notebook = notebook;
		showAll();
		
	} // this()
	
} // class CustomTab


class TabDrawingArea : DrawingArea
{
	string _labelText;
	int _tabNumber;
	Notebook _notebook;
	cairo_text_extents_t extents;
	double[] northWestArc, northEastArc;
	double xRight, xLeft, textBaseline = 22, yUpper;
	double width, height;
	double[] tabOutlineRGBA = [0.5, 0.5, 0.5, 1.0];
	double[] tabFillRGBA = [0.949, 0.949, 0.949, 1.0];
	double cornerRadius = 10, radians;
	double lineWidth = 2;
	GtkAllocation size; // the area assigned to the DrawingArea by its parent

	this(string labelText, int tabNumber, Notebook notebook)
	{
		_tabNumber = tabNumber;
		_notebook = notebook;
		_labelText = labelText;
		
		radians = PI / 180.0;

		// map out the shape ofa tab with rounded corners
		northWestArc = [180 * radians, 270 * radians]; // upper-left
		northEastArc = [-90 * radians, 0 * radians]; // upper-right
		cornerRadius = 10;

		addOnDraw(&onDraw);
		addOnButtonPress(&onButtonPress);
		
	} // this()


	bool onButtonPress(Event event, Widget widget)
	{
		_notebook.setCurrentPage(_tabNumber);
		int pageNumber = _notebook.getCurrentPage();
		writeln("_pageNumber: ", pageNumber);
		
		return(true);
		
	} // onButtonPress()
	

	bool onDraw(Scoped!Context context, Widget w)
	{
		// set the font size to something resembling the default UI font
		context.setFontSize(13);
		context.selectFontFace("Sans 10", CairoFontSlant.NORMAL, CairoFontWeight.BOLD);
		getAllocation(size);

		// find the dimensions of the text so we can size the tab
		context.textExtents(_labelText, &extents);
		width = extents.width + 20;
		height = extents.height + 10;
		
		setSizeRequest(cast(int)width, cast(int)height);
		xLeft = 12;
		xRight = width - 11;
		yUpper = 15;
		context.setLineWidth(lineWidth);
		
		// Describe a round-shouldered tab starting in the bottom-left corner
		// and going clockwise around the tab outline.
		context.newSubPath();
		context.moveTo(2, 32);
		context.lineTo(2, 12);
		context.arc(xLeft,  yUpper, cornerRadius, northWestArc[0], northWestArc[1]); // upper left corner
		context.arc(xRight, yUpper, cornerRadius, northEastArc[0], northEastArc[1]); // upper right corner
		context.lineTo(width - 2, 32);
//		context.closePath(); // closing the path puts a line across the bottom which doesn't look very nice

		// fill it (needs to be done first)
		context.setSourceRgba(tabFillRGBA[0], tabFillRGBA[1], tabFillRGBA[2], tabFillRGBA[3]);
		context.fillPreserve();

		// draw it
		context.setSourceRgba(tabOutlineRGBA[0], tabOutlineRGBA[1], tabOutlineRGBA[2], tabOutlineRGBA[3]);
		context.stroke();

		// the text will be the same colour as the outline around the tab
		context.moveTo(size.width / 2 - extents.width / 2, textBaseline); // tabs always seem to be 20 pixels high
		context.showText(_labelText);

		return(true);
		
	} // onDraw()
	
} // class CustomTab


class MyTextView : TextView
{
	TextBuffer textBuffer;
	int width = 400, height = 350;
	
	this(string content)
	{
		super();
		setSizeRequest(width, height);
		textBuffer = getBuffer();
		textBuffer.setText(content);
		
	} // this()

} // class MyTextView
