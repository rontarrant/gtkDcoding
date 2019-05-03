// esthetic layout example using a Grid

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.Label;
import gtk.Widget; // needed for setHalign() and setValign() functions
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
	PadLabel zeroZero, oneZero, zeroOne, oneOne;
	
	public:
	this()
	{
		super();

		// row 0
		zeroZero = new PadLabel("this is a long bit of text", PadBoxJustify.RIGHT);
		attach(zeroZero, 0, 0, 1, 1);
		
		oneZero = new PadLabel("cell 1, 0", PadBoxJustify.LEFT);
		attach(oneZero, 1, 0, 1, 1);

		// row 1
		zeroOne = new PadLabel("and this is shorter", PadBoxJustify.RIGHT);
		attach(zeroOne, 0, 1, 1, 1);
				
		oneOne = new PadLabel("cell 1, 1", PadBoxJustify.LEFT);
		attach(oneOne, 1, 1, 1, 1);

		setBorderWidth(_borderWidth);
		setMarginBottom(10);
		
	} // this()
	
} // class PadGrid


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
	private:
	Widget _widget;
	int _globalPadding = 0;
	int _padding = 0;
	bool fill = false;
	bool expand = false;
	int _borderWidth = 5;

	PadBoxJustify _pJustify;
	
	public:
	this(Widget widget, PadBoxJustify pJustify)
	{
		_widget = widget;
		_pJustify = pJustify;
		
		super(Orientation.HORIZONTAL, _globalPadding);

		if(_pJustify == PadBoxJustify.LEFT)
		{
			packStart(_widget, expand, fill, _padding);
		}
		else if(_pJustify == PadBoxJustify.RIGHT)
		{
			packEnd(_widget, expand, fill, _padding);
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
