// Test Rig Foundation for Learning GtkD Coding

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
	Main.init(args);

	testRigWindow testRigWindow = new testRigWindow("Test Rig with VolumeButton");
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	int borderWidth = 10;
	int width = 250;
	int height = 175;
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		setBorderWidth(borderWidth);
		setSizeRequest(width, height);
		
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
	MyVolumeButton myVolumeButton;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		myVolumeButton = new MyVolumeButton();
		packStart(myVolumeButton, false, false, 0);
		
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
		super();
		
		adjustment = new Adjustment(initialValue + 1, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setValue(initialValue);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(double value, ScaleButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()


} // class MyVolumeButton
