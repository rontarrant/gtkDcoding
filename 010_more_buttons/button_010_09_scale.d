// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ScaleButton;
import gtk.Adjustment;
import gtk.c.types;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig with ScaleButton");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
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

} // class myAppWindow


class AppBox : Box
{
	MyScaleButton myScaleButton;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		myScaleButton = new MyScaleButton();
		packStart(myScaleButton, false, false, 0);
		
	} // this()

} // class AppBox


class MyScaleButton : ScaleButton
{
	double minimum = 0;
	double maximum = 10;
	double step = 1;

	Adjustment adjustment;
	double initialValue = 5;
	double pageIncrement = 1;
	double pageSize = 0;
	
//	string[] icons = ["audio-volume-muted", "audio-volume-high", "audio-volume-low", "audio-volume-medium"];
	string[] icons = ["face-crying", "face-laugh", "face-embarrassed", "face-sad", "face-plain", "face-smirk", "face-smile"];
//	string[] icons = ["face-crying", "face-laugh", "face-plain"];
//	string[] icons = ["face-crying", "face-laugh"];
//	string[] icons = ["face-plain"];
	
	this()
	{
		super(IconSize.BUTTON, minimum, maximum, step, icons);
		
		adjustment = new Adjustment(initialValue + 1, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setValue(initialValue);
//		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(ScaleButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()


} // class MyScaleButton
