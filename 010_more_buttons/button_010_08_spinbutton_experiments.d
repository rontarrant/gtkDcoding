// SpinButton madness

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

	TestRigWindow myTestRig = new TestRigWindow("Test Rig with SpinButton");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
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

} // class myAppWindow


class AppBox : Box
{
	DoubleSpinButton doubleSpinButton;
	FloatSpinButton floatSpinButton;
	PrecisionSpinButton precisionSpinButton;
	IntSpinButton intSpinButton;
	ByteSpinButton byteSpinButton;
	BoolSpinButton boolSpinButton;
		
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		doubleSpinButton = new DoubleSpinButton();
		packStart(doubleSpinButton, false, false, 0);

		floatSpinButton = new FloatSpinButton();
		packStart(floatSpinButton, false, false, 0);

		precisionSpinButton = new PrecisionSpinButton();
		packStart(precisionSpinButton, false, false, 0);

		intSpinButton = new IntSpinButton();
		packStart(intSpinButton, false, false, 0);

		byteSpinButton = new ByteSpinButton();
		packStart(byteSpinButton, false, false, 0);

		boolSpinButton = new BoolSpinButton();
		packStart(boolSpinButton, false, false, 0);

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
//		addOnValueChanged(&valueChanged);
		addOnOutput(&outputValue);
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Double: ", getValue());
		
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
		writeln("Float: ", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Float: ", getValue());
		
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
		writeln("Precision: ", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Precision: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class PrecisionSpinButton


class IntSpinButton : SpinButton
{
	int minimum = 1;
	int maximum = 1000;
	int step = 5;

	Adjustment adjustment;
	int initialValue = 23;
	int pageIncrement = 100;
	int pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);

		addOnValueChanged(&valueChanged); // NO double-fire
//		addOnOutput(&outputValue); // double-fire
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Int: ", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Int: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class IntSpinButton


class ByteSpinButton : SpinButton
{
	byte minimum = -128;
	byte maximum = 127;
	byte step = 1;

	Adjustment adjustment;
	byte initialValue = 0;
	byte pageIncrement = 8;
	byte pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);

		addOnValueChanged(&valueChanged); // NO double-fire
//		addOnOutput(&outputValue); // double-fire
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Byte: ", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Byte: ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class ByteSpinButton


class BoolSpinButton : SpinButton
{
	bool minimum = 0;
	bool maximum = 1;
	bool step = 1;

	Adjustment adjustment;
	bool initialValue = 0;
	bool pageIncrement = 1;
	bool pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);

		addOnValueChanged(&valueChanged); // NO double-fire
//		addOnOutput(&outputValue); // double-fire
		
	} // this()

	void valueChanged(SpinButton sb)
	{
		writeln("Bool(ish): ", getValue());
		
	} // valueChanged()

	
	bool outputValue(SpinButton sb)
	{
		writeln("Bool(ish): ", getValue());
		
		return(false);
		
	} // outputValue()
	
} // class BoolSpinButton
