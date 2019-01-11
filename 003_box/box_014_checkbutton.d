// example of a CheckButton
// using an Observed pattern to keep two buttons in sync

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gdk.Event;
import gtk.CheckButton;                                                         // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");

	AddBox myBox = new AddBox();
	myTestRig.add(myBox);

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
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AddBox : Box
{
	Observed switcher;                                                                  // *** NEW ***
	
	this()
	{
		super(Orientation.VERTICAL, 5);

		switcher = new Observed();                                                       // *** NEW ***
		
		MyCheckButton switchOutputButton = new MyCheckButton("Change Output", switcher); // *** NEW ***
		ActionButton actionButton = new ActionButton("Take Action", switcher);           // *** NEW ***
		
		add(actionButton);                                                               // *** NEW ***
		add(switchOutputButton);                                                         // *** NEW ***
		
	} // this()

	
	void changeOutput()                                                                 // *** NEW ***
	{
		
	} // changeOutput()
	
} // class AddBox


class ActionButton : Button
{
	string standardMessage = "Droids? We don't need no stinking droids!";        // *** NEW ***
	string switchMessage = "These aren't the droids you're looking for.";        // *** NEW ***
	Observed switcher;                                                           // *** NEW ***

	this(string labelText, Observed extSwitcher)                                 // *** NEW ***
	{
		super(labelText);
		addOnClicked(&doSomething);
		switcher = extSwitcher;
		
	} // this()
	
	
	void doSomething(Button b)                                                   // *** NEW ***
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


class MyCheckButton : CheckButton                                 // *** NEW ***
{
	Observed switcher;
	
	this(string label, Observed extSwitcher)
	{
		super(label, &setObserved);
		switcher = extSwitcher;
		
	} // this()
	
	
	void setObserved(CheckButton cb)                               // *** NEW ***
	{
		switcher.setState(getActive());
		
	} // getState()
	
}


class Observed                                                    // *** NEW ***
{
	bool switcher;                                                 // *** NEW ***
	
	this()
	{
		switcher = false;
		
	} // this()
	
	
	bool getState()                                                // *** NEW ***
	{
		return(switcher);
	}


	void setState(bool state)                                      // *** NEW ***
	{
		switcher = state;
		
	} // setState()
	
} // class Observed
