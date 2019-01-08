// Window Close button and GUI button trigger same action

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Button;
import gtk.Label;
import gtk.Layout;

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
		
		/////////////////////
		// Test Code Start //
		/////////////////////
		
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
		
		///////////////////
		// Test Code End //
		///////////////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	/////////////////////
	// Test Code Start //
	/////////////////////

	void doSomething()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Action from a rotated button...");
		
	} // doSomething()

	///////////////////
	// Test Code End //
	///////////////////

	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow

/////////////////////
// Test Code Start //
/////////////////////

class MyLayout : Layout
{
	this(Button button)
	{
		super(null, null);
		put(button, 10, 10);
		
	} // this()
	
} // class MyLayout

///////////////////
// Test Code End //
///////////////////
