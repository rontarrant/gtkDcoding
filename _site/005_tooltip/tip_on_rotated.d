// Tooltip on a rotated button
// Based on rotated.d from the buttons examples.
// Because this is based on another example, the Start/End comments
// have been moved to include just the differences between the original
// example and this one.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Label;
import gtk.Layout;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Tooltip;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	/////////////////////
	// Test Code Start //
	/////////////////////
	
	
	
	///////////////////
	// Test Code End //
	///////////////////
	
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
		
		// a rotated label
		Label myRotatedLabel = new Label("My Rotated Label on a Button");
		myRotatedLabel.setAngle(90);
		
		// and a button to put it on
		Button myButton = new Button();
		myButton.addOnClicked(delegate void(_) { doSomething(); } );
		myButton.add(myRotatedLabel);

		// add a layout container so the button's size will show
		// and put the hierarchy together
		auto myLayout = new MyLayout(myButton);
		add(myLayout);
		
		/////////////////////
		// Test Code Start //
		/////////////////////

		// add the tooltip
		// Note: Because a tooltip object is already built into the widget, all
		//       we really have to do is turn it on and set the text. And since
		//       the text we want is already in/on the button's label, use it. 
		myButton.setHasTooltip(true);
		myButton.setTooltipText(myRotatedLabel.getText());
				
		///////////////////
		// Test Code End //
		///////////////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	

	void doSomething()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Action from a rotated button...");
		
	} // doSomething()


	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyLayout : Layout
{
	this(Button button)
	{
		super(null, null);
		put(button, 10, 10);
		
	} // this()
	
} // class MyLayout
