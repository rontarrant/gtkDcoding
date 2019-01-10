// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

///////////
// START //
///////////

import gtk.Button;
import gtk.ToggleButton;

///////////
//  END  //
///////////

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
///////////
// START //
///////////
	

	
///////////
//  END  //
///////////

	// Show the window and its contents...
	myTestRig.showAll();
	
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		ActionButton myActionButton = new ActionButton("Take Action");
		add(myActionButton);
		
		MyToggleButton myToggle = new MyToggleButton();
		add(myToggle);
		
	} // this() CONSTRUCTOR
	
	
	void sayHi()
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}
	
	
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
// START //
///////////

class ActionButton : Button
{
	this(string label)
	{
		super(label);
		
	} // this()
	
} // class ActionButton


class MyToggleButton : ToggleButton
{
	this()
	{
		super();
		addOnClicked(&report);
		
	} // this()
	
	
	void report(Button b)
	{
		if(getMode() == true)
		{
			writeln("Toggle is on.");
		}
		else
		{
			writeln("Toggle is off.");
		}
	
	} // report()
	
} // class MyToggleButton

///////////
//  END  //
///////////
