// SpinButtons - cardinal and float

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.SpinButton;
import gtk.Adjustment;
import gtk.c.types;

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRigWindow = new testRigWindow("Test Rig with SpinButtons");
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
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

} // class testRigWindow


class AppBox : Box
{
	DoubleSpinButton doubleSpinButton;
	FloatSpinButton floatSpinButton;
	PrecisionSpinButton precisionSpinButton;
		
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		doubleSpinButton = new DoubleSpinButton();
		packStart(doubleSpinButton, false, false, 0);

		floatSpinButton = new FloatSpinButton();
		packStart(floatSpinButton, false, false, 0);

		precisionSpinButton = new PrecisionSpinButton();
		packStart(precisionSpinButton, false, false, 0);

	} // this()

} // class AppBox


class DoubleSpinButton : SpinButton
{
	double minimum = -48;
	double maximum = 48;
	double step = 2;

	Adjustment adjustment;
	double initialValue = 0;
	double pageIncrement = 8;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);

		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		addOnValueChanged(&valueChanged);
//		addOnOutput(&outputValue);
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Double", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Double: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class DoubleSpinButton


class FloatSpinButton : SpinButton
{
	float minimum = -1.0;
	float maximum = 1.0;
	double step = .1;

	Adjustment adjustment;
	float initialValue = 0.0;
	float pageIncrement = 0.5;
	float pageSize = 0.0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setWrap(true);
		
		addOnValueChanged(&valueChanged);
//		addOnOutput(&outputValue);
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Float Standard", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Float Standard: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class FloatSpinButton


class PrecisionSpinButton : SpinButton
{
	double minimum = -1.0;
	double maximum = 1.0;
	double step = .001;
	uint precision = 3;

	Adjustment adjustment;
	double initialValue = 0.0;
	double pageIncrement = 0.01;
	double pageSize = 0.0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setDigits(precision);

		addOnValueChanged(&valueChanged); // NO double-fire
//		addOnOutput(&outputValue); // double-fire
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Float Precision", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Float Precision: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class PrecisionSpinButton
