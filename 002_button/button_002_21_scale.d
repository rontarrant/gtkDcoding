// This source code is in the public domain.

// ScaleButton example

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
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "ScaleButton Example";
	int borderWidth = 10;
	int width = 250;
	int height = 175;
	AppBox appBox;
	string exitMessage = "Bye.";
	
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
		writeln(exitMessage);
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyScaleButton myScaleButton;
	int localPadding = 0, globalPadding = 10;
	bool expand = false, fill = false;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myScaleButton = new MyScaleButton();
		packStart(myScaleButton, expand, fill, localPadding);
		
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
		double compensateForWinBug = initialValue + 1;
		
		super(IconSize.BUTTON, minimum, maximum, step, icons);
		
		adjustment = new Adjustment(compensateForWinBug, minimum, maximum, step, pageIncrement, pageSize);
		setAdjustment(adjustment);
		setValue(initialValue);
//		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(ScaleButton sb)
	{
		writeln(getValue());
		
	} // valueChanged()


} // class MyScaleButton
