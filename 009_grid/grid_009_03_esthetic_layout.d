// esthetic layout example using a Grid

import std.stdio;
import std.conv; // needed for finding 90% of the width and height

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.EventBox; // Labels can't have a background color, so we pack them in EventBoxes which can
import gtk.Label;
import gdk.RGBA; // needed for defining colors for the label backgrounds
import gtk.Widget; // needed for setHalign() and setValign() functions
import gtk.c.types; // needed for Align types (FILL, START, END, CENTER, BASELINE)
import gtk.Box;

// Note: StateFlags are found in gtk.c.types

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	int width = 400;
	int height = 100;
	string title = "Grid with Centre-aligned Elements";
	MyGrid myGrid;
	
	this()
	{
		super(title);
		
		myGrid = new MyGrid();
		add(myGrid);
		
		showAll();
		
	} // this()
		
} // class TestRigWindow


class MyGrid : Grid
{
	private:
	int _borderWidth = 10;
	PadLabel zeroZero, oneZero, zeroOne, oneOne;
	
	public:
	this()
	{
		super();
		setBorderWidth(_borderWidth);

		// row 0
		zeroZero = new PadLabel("this is a long bit of text", PadBoxJustify.RIGHT);
		attach(zeroZero, 0, 0, 1, 1);
		zeroZero.setHalign(Align.END);
		
		oneZero = new PadLabel("cell 1, 0", PadBoxJustify.LEFT);
		attach(oneZero, 1, 0, 1, 1);
		oneZero.setHalign(Align.START);

		// row 1
		zeroOne = new PadLabel("and this is shorter", PadBoxJustify.RIGHT);
		attach(zeroOne, 0, 1, 1, 1);
		zeroOne.setHalign(Align.END);
				
		oneOne = new PadLabel("cell 1, 1", PadBoxJustify.LEFT);
		attach(oneOne, 1, 1, 1, 1);
		oneOne.setHalign(Align.START);
		
	} // this()
	
} // class MyGrid


class PadLabel : PadBox
{
	Label label;
	
	this(string text, PadBoxJustify pJustify)
	{
		label = new Label(text);
		
		super(label, pJustify);
		
	} // this()
	
} // class PadLabel


class PadBox : Box
{
	Widget _widget;
	int globalPadding = 0;
	int padding = 0;
	bool fill = false;
	bool expand = false;
	int _borderWidth = 5;

	PadBoxJustify _pJustify;
	
	this(Widget widget, PadBoxJustify pJustify)
	{
		_widget = widget;
		_pJustify = pJustify;
		
		super(Orientation.HORIZONTAL, globalPadding);

		if(_pJustify == PadBoxJustify.LEFT)
		{
			packStart(_widget, expand, fill, padding);
		}
		else if(_pJustify == PadBoxJustify.RIGHT)
		{
			packEnd(_widget, expand, fill, padding);
		}
		else
		{
			add(_widget);
		}	
		
		setBorderWidth(_borderWidth);

	} // this()
	
} // class PadBox


enum PadBoxJustify
{
	LEFT = 0,
	RIGHT = 1,
	CENTER = 2,
	
} // PadBoxJustify
