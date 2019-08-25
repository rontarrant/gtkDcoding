// Description of example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Frame;
import gtk.Adjustment;
import gtk.Label;
import gtk.SpinButton;
import gtk.Grid;

void main(string[] args)
{
	CSS css;
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	css = new CSS(); // enable CSS

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Frame - CSS";
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
	int _borderWidth = 10;
	bool expand = false, fill = false;
	uint globalPadding = 0, localPadding = 0;
	FrameOn frameOn;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		setBorderWidth(_borderWidth);
		
		frameOn = new FrameOn();
		packStart(frameOn, expand, fill, localPadding); // LEFT justify
		
		setMarginLeft(7);
		setMarginRight(7);
		setMarginBottom(15);

	} // this()

} // class AppBox


class FrameOn : Frame
{
	private:
	string titleLabel = "Coordinates";
	FrameChildGrid frameChildGrid;
	float xAlign = 0.05, yAlign = 0.5;

	public:
	this()
	{
		super(titleLabel);
		setLabelAlign(xAlign, yAlign);
		frameChildGrid = new FrameChildGrid();
		add(frameChildGrid);
		
	} // this()
	
} // class FrameOn


class FrameChildGrid : Grid
{
	private:
	int _borderWidth = 10;
	XLabel xLabel;
	YLabel yLabel; 
	XSpinButton xSpinButton;
	YSpinButton ySpinButton;
	
	public:
	this()
	{
		// row 0
		xLabel = new XLabel();
		attach(xLabel, 0, 0, 1, 1);
		xSpinButton = new XSpinButton();
		attach(xSpinButton, 1, 0, 1, 1);
		
		yLabel = new YLabel();
		attach(yLabel, 0, 1, 1, 1);
		ySpinButton = new YSpinButton();
		attach(ySpinButton, 1, 1, 1, 1);		
		
		setBorderWidth(_borderWidth);
		setMarginBottom(10);

	} // this()
	
} // class FrameChildGrid


class XLabel : HPadLabel
{
	string labelText = "x";
	BoxJustify pJustify = BoxJustify.RIGHT;
	
	this()
	{
		super(labelText, pJustify);
		
	} // this()
	
} // class XLabel


class YLabel : HPadLabel
{
	string labelText = "y";
	BoxJustify pJustify = BoxJustify.RIGHT;
	
	this()
	{
		super(labelText, pJustify);
		
	} // this()
	
} // class YLabel


class HPadLabel : HPadBox
{
	Label label;
	
	this(string text, BoxJustify pJustify)
	{
		label = new Label(text);
		
		super(label, pJustify);
		
	} // this()
	
} // class HPadLabel


class XSpinButton : HPadBox
{
	double minimum = 320;
	double maximum = 1920;
	double step = 1;

	SpinButton spinButton;
	BoxJustify pJustify = BoxJustify.LEFT;
	Adjustment adjustment;
	double initialValue = 1280;
	double pageIncrement = 100;
	double pageSize = 0;
	
	this()
	{
		spinButton = new SpinButton(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		spinButton.setAdjustment(adjustment);
		spinButton.addOnValueChanged(&valueChanged);
		
		super(spinButton, pJustify);
		
	} // this()
	
	
	void valueChanged(SpinButton sb)
	{
		if(sb.getValue() == minimum)
		{
			writeln(sb.getValue());
		}
		
	} // valueChanged()

} // class XSpinButton


class YSpinButton : HPadBox
{
	double minimum = 200;
	double maximum = 1080;
	double step = 1;

	SpinButton spinButton;
	BoxJustify pJustify = BoxJustify.LEFT;
	Adjustment adjustment;
	double initialValue = 720;
	double pageIncrement = 100;
	double pageSize = 0;
	
	this()
	{
		spinButton = new SpinButton(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		spinButton.setAdjustment(adjustment);
		spinButton.addOnValueChanged(&valueChanged);
		
		super(spinButton, pJustify);
		
	} // this()
	
	
	void valueChanged(SpinButton sb)
	{
		writeln(sb.getValue());
		
	} // valueChanged()
	
} // class YSpinButton


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


class CSS
{
	import gdk.Display;
	import gdk.Screen;
	import gtk.StyleContext;
	import gtk.CssProvider;
	
	string cssPath = "./css/frame.css";

	this()
	{
		CssProvider provider = new CssProvider();
		provider.loadFromPath(cssPath);
		
		Display display = Display.getDefault();
		Screen screen = display.getDefaultScreen();
		StyleContext.addProviderForScreen(screen, provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);

	} // this()

} // CSS
