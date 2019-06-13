// SpinButton example

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

	TestRigWindow testRigWindow = new TestRigWindow("Test Rig with SpinButton");
	
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
	MySpinButton mySpinButton;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		mySpinButton = new MySpinButton();
		packStart(mySpinButton, false, false, 0);
		
	} // this()

} // class AppBox


class MySpinButton : SpinButton
{
	double minimum = -48;
	double maximum = 48;
	double step = 2;

	Adjustment adjustment;
	double initialValue = 4;
	double pageIncrement = 8;
	double pageSize = 20;
	
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


} // class MySpinButton
