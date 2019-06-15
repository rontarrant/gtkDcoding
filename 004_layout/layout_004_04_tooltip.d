// Tooltip on a rotated button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Label;
import gtk.Layout;
import gtk.Tooltip;                                               // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Tooltip Example";
	
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
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyLayout : Layout
{
	int buttonX = 10, buttonY = 10;
	
	this()
	{
		super(null, null);
		
		Button myButton = new TooltipButton();
		put(myButton, buttonX, buttonY);
		
	} // this()
	
} // class MyLayout


class TooltipButton : Button
{
	string tooltipText = "\nClick me and see what happens.";
	
	this()
	{
		super();

		// a rotated label
		RotatedLabel myRotatedLabel = new RotatedLabel();
		add(myRotatedLabel);

		addOnClicked(delegate void(_) { doSomething(); } );

		// add the tooltip

		// Note: Because a tooltip object is already built into the widget,
		// all we really have to do is turn it on and set the text. And
		// because the text we want is already in/on the button's label,
		// we just use that as part of the tooltip. 
		setHasTooltip(true);
		setTooltipText(myRotatedLabel.getText() ~ tooltipText);

	} // this()


	void doSomething()
	{
		string message = "Action from a rotated button...";
		 
		writeln(message);
		
	} // doSomething()
	
} // class TooltipButton


class RotatedLabel : Label
{
	string labelText = "My Rotated Label on a Button";
	int angle = 90;
	
	this()
	{
		super(labelText);
		setAngle(angle);
		
	} // this()
	
} // class RotatedLabel
