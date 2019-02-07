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
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		auto myLayout = new MyLayout();
		add(myLayout);

		showAll();
		
	} // this() CONSTRUCTOR
	

	void quitApp()
	{
		writeln("Bye.");
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyLayout : Layout
{
	this()
	{
		super(null, null);
		
		Button myButton = new TooltipButton();
		put(myButton, 10, 10);
		
	} // this()
	
} // class MyLayout


class TooltipButton : Button                                      // *** NEW ***
{
	this()
	{
		super();

		// a rotated label
		RotatedLabel myRotatedLabel = new RotatedLabel();
		add(myRotatedLabel);

		addOnClicked(delegate void(_) { doSomething(); } );

		// add the tooltip
		// Note: Because a tooltip object is already built into the widget, all
		//       we really have to do is turn it on and set the text. And since
		//       the text we want is already in/on the button's label, use it. 
		setHasTooltip(true);                                                            // *** NEW ***
		setTooltipText(myRotatedLabel.getText() ~ "\nClick me and see what happens.");  // *** NEW ***

	} // this()


	void doSomething()
	{
		writeln("Action from a rotated button...");
		
	} // doSomething()
	
} // class TooltipButton


class RotatedLabel : Label
{
	string labelText = "My Rotated Label on a Button";
	
	this()
	{
		super(labelText);
		setAngle(90);
		
	} // this()
	
} // class RotatedLabel
