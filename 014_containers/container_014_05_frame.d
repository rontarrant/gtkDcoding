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

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "<Insert Title>";
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
	FrameDefault frameDefault;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		frameDefault = new FrameDefault();
		
		packStart(frameDefault, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class FrameDefault : Frame
{
	private:
	string titleLabel = "Coordinates";
	XLabel xLabel;
	YLabel yLabel; 
	XSpinButton xSpinButton;
	YSpinButton ySpinButton;
	
	public:
	this()
	{
		super(titleLabel);
		
		xLabel = new XLabel();
		add(xLabel);
		xSpinButton = new XSpinButton();
		add(xSpinButton);
		
		yLabel = new YLabel();
		add(yLabel);
		ySpinButton = new YSpinButton();
		add(ySpinButton);
		
	} // this()
	
} // class FrameDefault


class XLabel : Label
{
	string labelText = "x";
	
	this()
	{
		super(labelText);
		
	} // this()
	
} // class XLabel


class YLabel : Label
{
	string labelText = "y";
	
	this()
	{
		super(labelText);
		
	} // this()
	
} // class YLabel


class XSpinButton : SpinButton
{
	double minimum = 320;
	double maximum = 1920;
	double step = 1;

	Adjustment adjustment;
	double initialValue = 1280;
	double pageIncrement = 100;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(SpinButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()

} // class XSpinButton


class YSpinButton : SpinButton
{
	double minimum = 200;
	double maximum = 1080;
	double step = 1;

	Adjustment adjustment;
	double initialValue = 720;
	double pageIncrement = 100;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(SpinButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()

	
	
} // class YSpinButton

/*
class FrameOut : Frame
{
	
	
} // class FrameOut


class FrameEtchedIn : Frame
{
	
	
} // class FrameEtchedIn


class FrameEtchedOut : Frame
{
	
	
} // class FrameEtchedOut


class FrameNone : Frame
{
	
	
} // class FrameNone
*/