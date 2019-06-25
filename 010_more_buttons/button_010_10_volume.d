// GtkD VolumeButton example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.VolumeButton;
import gtk.ScaleButton;
import gtk.Adjustment;
import gtk.c.types;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "VolumeButton Example";
	int borderWidth = 10;
	int width = 250;
	int height = 175;
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setBorderWidth(borderWidth);
		setSizeRequest(width, height);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyVolumeButton myVolumeButton;
	int localPadding = 0, globalPadding = 10;
	bool expand = false, fill = false;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myVolumeButton = new MyVolumeButton();
		packStart(myVolumeButton, expand, fill, localPadding);
		
	} // this()

} // class AppBox


class MyVolumeButton : VolumeButton
{
	double minimum = 0;
	double maximum = 10;
	double step = 1;

	Adjustment adjustment;
	double initialValue = 7;
	double pageIncrement = 1;
	double pageSize = 1;
	
	this()
	{
		double compensateForWinBug = initialValue + 1;
		
		super();
		
		adjustment = new Adjustment(compensateForWinBug, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setValue(initialValue);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(double value, ScaleButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()


} // class MyVolumeButton
