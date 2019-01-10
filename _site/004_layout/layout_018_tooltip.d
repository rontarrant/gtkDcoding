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
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// and a button to put it on
		Button myButton = new TooltipButton();

		// add a layout container so the button's size will show
		// and put the hierarchy together
		auto myLayout = new MyLayout(myButton);
		add(myLayout);

		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	

	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class TooltipButton : Button
{
	this()
	{
		super();

		// a rotated label
		Label myRotatedLabel = new Label("My Rotated Label on a Button");
		myRotatedLabel.setAngle(90);
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
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Action from a rotated button...");
		
	} // doSomething()
	
} // class TooltipButton


class MyLayout : Layout
{
	this(Button button)
	{
		super(null, null);
		put(button, 10, 10);
		
	} // this()
	
} // class MyLayout
