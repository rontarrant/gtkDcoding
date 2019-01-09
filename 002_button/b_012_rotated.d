// a rotated button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

///////////
// START //
///////////

import gtk.Button;
import gtk.Label;
import gtk.Layout;

///////////
//  END  //
///////////

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
		
///////////
// START // a rotated label on a button
///////////
		
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
		
///////////
//  END  //
///////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
///////////
// START // a placeholder callback
///////////

	void doSomething()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Action from a rotated button...");
		
	} // doSomething()

///////////
//  END  //
///////////

	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow

///////////
// START // Layout class
///////////

class MyLayout : Layout
{
	this(Button button)
	{
		super(null, null);
		put(button, 10, 10);
		
	} // this()
	
} // class MyLayout

///////////
//  END  //
///////////
