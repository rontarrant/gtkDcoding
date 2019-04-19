// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.SpinButton;
import gtk.Adjustment;

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
	IntSpinButton intSpinButton;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		intSpinButton = new IntSpinButton();
		packStart(intSpinButton, false, false, 0);
		
	} // this()

} // class AppBox


class IntSpinButton : SpinButton
{
	double minimum = -50;
	double maximum = 50;
	double step = 2;

	Adjustment adjustment;
	double initialValue = 4;
	double pageIncrement = 8;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		
		adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		
	} // this()
	
} // class IntSpinButton


class DoubleSpinButton : SpinButton
{
	double minimum = -50;
	double maximum = 50;
	double step = 2;

	Adjustment adjustment;
	double initialValue = 4;
	double pageIncrement = 8;
	double pageSize = 0;
	
	this()
	{
		super(minimum, maximum, step);
		new Adjustment(cast(Adjustment) adjustment);
		setAdjustment(adjustment);
		
	} // this()
	
} // class DoubleSpinButton
