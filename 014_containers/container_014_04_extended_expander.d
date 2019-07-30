// A more complex Expander example with multiple children

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Expander;
import gtk.Label;
import gtk.Grid;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Expander with Multiple Child Elements";
	int width = 400, height = 230;
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setSizeRequest(width, height);
		
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
	MyExpander expander;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		expander = new MyExpander();
		
		packStart(expander, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class MyExpander : Expander
{
	string label = "An Expander";
	bool isMnemonic = false;
	ExpanderChildGrid expanderChildGrid;
	
	this()
	{
		super(label, isMnemonic);
		
		expanderChildGrid = new ExpanderChildGrid();
		add(expanderChildGrid);
		
	} // this()
	
} // class MyExpander


class ExpanderChildGrid : Grid
{
	int leftStartColumn = 0, topStartRow = 0, extendToRight = 1, extendToDown = 1;
	int borderWidth = 10;
	uint globalPadding = 0, localPadding = 0;
	PadLabel childLabel01, childLabel02;
	BoxJustify bJustify = BoxJustify.LEFT; 
	string labelText01 = "Child of expander", labelText02 = "Another child of expander";
	
	this()
	{
		super();
		
		childLabel01 = new PadLabel(bJustify, labelText01);
		attach(childLabel01, leftStartColumn, topStartRow, extendToRight, extendToDown);
		
		childLabel02 = new PadLabel(bJustify, labelText02);
		attach(childLabel02, leftStartColumn, topStartRow + 1, extendToRight, extendToDown);
		
		setMarginLeft(10);
		
	} // this()
	
} // class ExpanderChildGrid


class PadLabel : HPadBox
{
	Label label;
	
	this(BoxJustify pJustify, string text = null)
	{
		label = new Label(text);
		
		super(label, pJustify);
		
	} // this()
	
} // class PadLabel


class HPadBox : Box
{
	private:
	Widget _widget;
	int globalPadding = 0;
	int padding = 0;
	bool fill = false;
	bool expand = false;
	int _borderWidth = 5;

	BoxJustify _pJustify;
	
	public:
	this(Widget widget, BoxJustify pJustify)
	{
		_widget = widget;
		_pJustify = pJustify;
		
		super(Orientation.HORIZONTAL, globalPadding);

		if(_pJustify == BoxJustify.LEFT)
		{
			packStart(_widget, expand, fill, padding);
		}
		else if(_pJustify == BoxJustify.RIGHT)
		{
			packEnd(_widget, expand, fill, padding);
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
	
} // BoxJustify
