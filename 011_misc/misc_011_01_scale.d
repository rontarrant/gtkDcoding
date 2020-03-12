// This source code is in the public domain.

// Scale Button example (as opposed to a ScaleButton example) Yup. They're different.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Scale;
import gtk.Range;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Scale Button Example";
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
	MyScale myScale;
	int localPadding = 0, globalPadding = 10;
	bool expand = false, fill = false;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myScale = new MyScale();
		packStart(myScale, expand, fill, localPadding);
		
	} // this()

} // class AppBox


class MyScale : Scale
{
	double minimum = 0;
	double maximum = 10;
	double step = 1;

	this()
	{
		super(Orientation.HORIZONTAL, minimum, maximum, step);
		addOnValueChanged(&valueChanged);
		
	} // this()
	
	
	void valueChanged(Range range)
	{
		writeln(getValue());
		
	} // valueChanged()

} // class MyScale
