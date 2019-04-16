// ColorChooserDialog

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Box;
import gtk.Window;
import gtk.Button;
import gtk.Dialog;
import gtk.ColorChooserDialog;
import gdk.RGBA;

void main(string[] args)
{
	TestRig testRig;
	
	Main.init(args);
	
	testRig = new TestRig();
	
	Main.run();
	
} // main()


class TestRig : MainWindow
{
	TestBox testBox;
	
	string windowTitle = "ColorChooserDialog demo";
	
	this()
	{
		super(windowTitle);
		setDefaultSize(640, 480);
		
		testBox = new TestBox(this);
		add(testBox);
		
		showAll();
		
	} // this()

} // class: TestRig


class TestBox : Box
{
	int padding = 5;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);
		
		Button button = new ColorChooserButton(parentWindow);
		add(button);
		
	} // this()
	
} // class: TestBox


class ColorChooserButton : Button
{
	private:
	string labelText = "Ask for a Color";
	
	MyColorChooserDialog colorChooserDialog;
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(labelText);
		addOnClicked(&doSomething);
		_parentWindow = parentWindow;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		colorChooserDialog = new MyColorChooserDialog(_parentWindow);
		
	} // doSomething()

} // class: ColorChooserButton


class MyColorChooserDialog : ColorChooserDialog
{
	private:
	string title = "I am the Chooser";
	DialogFlags flags = GtkDialogFlags.MODAL;
	RGBA selectedColor;

	public:
	this(Window _parentWindow)
	{
		super(title, _parentWindow);
		addOnResponse(&doSomething);
		run(); // no response ID because this dialog ignores it
		destroy();
		
	} // this()

	protected:
	void doSomething(int response, Dialog d)
	{
		getRgba(selectedColor);
		writeln("New color selection: ", selectedColor);
		
	} // doSomething()
	
} // class MyColorChooserDialog
