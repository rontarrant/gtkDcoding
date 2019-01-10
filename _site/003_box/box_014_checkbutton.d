// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

////////////
// START  //
////////////

import gtk.Box;
import gtk.Button;
import gtk.CheckButton;
import gdk.Event;

///////////
//  END  //
///////////

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
////////////
// START  //
////////////

	AddBox myBox = new AddBox();
	myTestRig.add(myBox);
	
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

////////////
// START  //
////////////

class AddBox : Box
{
	Observed switcher;
	
	this()
	{
		super(Orientation.VERTICAL, 5);

		switcher = new Observed();
		
		MyCheckButton switchOutputButton = new MyCheckButton("Change Output", switcher);
		// set up activeness??

		ActionButton actionButton = new ActionButton("Take Action", switcher);
		// set up an action
		
		add(actionButton);
		add(switchOutputButton);
		
	} // this()

	
	void changeOutput()
	{
		
	} // changeOutput()
	
} // class AddBox


class ActionButton : Button
{
	string standardMessage = "Droids? We don't need no stinking droids!";
	string switchMessage = "These aren't the droids you're looking for.";
	Observed switcher;

	this(string labelText, Observed extSwitcher)
	{
		super(labelText);
		addOnClicked(&doSomething);
		switcher = extSwitcher;
		
	} // this()
	
	
	void doSomething(Button b) // needs an arg passed in
	{
		if(switcher.getState() == true)
		{
			writeln(switchMessage);
		}
		else
		{
			writeln(standardMessage);
		}
		
	} // doSomething()
	
} // class ActionButton


class MyCheckButton : CheckButton
{
	Observed switcher;
	
	this(string label, Observed extSwitcher)
	{
		super(label, &setObserver);
		switcher = extSwitcher;
		
	} // this()
	
	
	void setObserver(CheckButton cb)
	{
		switcher.setState(getActive());
		
	} // getState()
	
}


class Observed
{
	bool switcher;
	
	this()
	{
		switcher = false;
		
	} // this()
	
	
	bool getState()
	{
		return(switcher);
	}


	void setState(bool state)
	{
		switcher = state;
		
	} // setState()
	
} // class Observed

///////////
//  END  //
///////////
