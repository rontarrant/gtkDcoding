// a rotated button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

import gtk.Button;
import gtk.Label;
import gtk.Layout; // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string bye = "Bye";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// add a layout container so the button's size will show
		// and put the hierarchy together
		auto myLayout = new MyLayout();                                           // *** NEW ***
		add(myLayout);                                                            // *** NEW ***
		
		showAll();
		
	} // this() CONSTRUCTOR
	

	void quitApp()
	{
		writeln(bye);
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyLayout : Layout                                                 // *** NEW ***
{
	this()
	{
		super(null, null);

		RotatedButton rotatedButton = new RotatedButton();
		put(rotatedButton, 10, 10);
		
	} // this()
	
} // class MyLayout


class RotatedButton : Button
{
	this()
	{
		super();
		
		RotatedLabel rotatedLabel = new RotatedLabel();                    // *** NEW ***
		
		addOnClicked(delegate void(_) { doSomething(); } );
		add(rotatedLabel);                                               // *** NEW ***
		
	} // this()

	
	void doSomething()                                                           // *** NEW ***
	{
		writeln("Action from a rotated button...");
		
	} // doSomething()
	
} // class rotatedButton


class RotatedLabel : Label
{
	string rotatedText = "My Rotated Label on a Button";
	
	this()
	{
		super(rotatedText);
		
		setAngle(90);
		
	} // this()
	
} // class RotatedLabel
