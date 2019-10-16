// This source code is in the public domain.

// esthetic layout example using a Grid

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.Label;
import gtk.Widget;
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
	string title = "Grid with Aesthetic Layout";
	PadGrid myGrid;
	
	this()
	{
		super(title);
		
		myGrid = new PadGrid();
		add(myGrid);
		
		showAll();
		
	} // this()
		
} // class TestRigWindow


class PadGrid : Grid
{
	private:
	int _borderWidth = 10;
	HPadLabel zeroZero, oneZero, zeroOne, oneOne;
	
	public:
	this()
	{
		super();

		// row 0
		zeroZero = new HPadLabel("this is a long bit of text", BoxJustify.RIGHT);
		attach(zeroZero, 0, 0, 1, 1);
		
		oneZero = new HPadLabel("cell 1, 0", BoxJustify.LEFT);
		attach(oneZero, 1, 0, 1, 1);

		// row 1
		zeroOne = new HPadLabel("and this is shorter", BoxJustify.RIGHT);
		attach(zeroOne, 0, 1, 1, 1);
				
		oneOne = new HPadLabel("cell 1, 1", BoxJustify.LEFT);
		attach(oneOne, 1, 1, 1, 1);

		setBorderWidth(_borderWidth);
		setMarginBottom(10);
		
	} // this()
	
} // class PadGrid


class HPadLabel : HPadBox
{
	Label label;
	
	this(string text, BoxJustify pJustify)
	{
		label = new Label(text);
		
		super(label, pJustify);
		
	} // this()
	
} // class HPadLabel


class HPadBox : Box
{
	private:
	Widget _widget;
	int _globalPadding = 0;
	int _padding = 0;
	bool fill = false;
	bool expand = false;
	int _borderWidth = 5;

	BoxJustify _pJustify;
	
	public:
	this(Widget widget, BoxJustify pJustify)
	{
		_widget = widget;
		_pJustify = pJustify;
		
		super(Orientation.HORIZONTAL, _globalPadding);

		if(_pJustify == BoxJustify.LEFT)
		{
			packStart(_widget, expand, fill, _padding);
		}
		else if(_pJustify == BoxJustify.RIGHT)
		{
			packEnd(_widget, expand, fill, _padding);
		}
		else
		{
			add(_widget);
		}	
		
		setBorderWidth(_borderWidth);

	} // this()
	
} // class HPadBox


enum BoxJustify
{
	LEFT = 0,
	RIGHT = 1,
	CENTER = 2,
	TOP = 3,
	BOTTOM = 4,
	
} // BoxJustify
