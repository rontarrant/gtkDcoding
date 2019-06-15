// a rotated button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Layout;                                                // *** NEW ***
import gtk.Button;
import gtk.Label;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Rotated Button";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		auto myLayout = new MyLayout();
		add(myLayout);
		
		showAll();
		
	} // this()
	

	void quitApp()
	{
		string exitMessage = "Bye";

		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyLayout : Layout
{
	int xPosition = 10, yPosition = 10;
	
	this()
	{
		super(null, null);

		RotatedButton rotatedButton = new RotatedButton();
		put(rotatedButton, xPosition, yPosition);
		
	} // this()
	
} // class MyLayout


class RotatedButton : Button
{
	this()
	{
		super();
		
		RotatedLabel rotatedLabel = new RotatedLabel();
		
		addOnClicked(delegate void(_) { doSomething(); } );
		add(rotatedLabel);
		
	} // this()

	
	void doSomething()
	{
		string message = "Action from a rotated button...";
		
		writeln(message);
		
	} // doSomething()
	
} // class rotatedButton


class RotatedLabel : Label
{
	string rotatedText = "My Rotated Label on a Button";
	
	this()
	{
		int angle = 90;
		
		super(rotatedText);
		
		setAngle(angle);
		
	} // this()
	
} // class RotatedLabel
