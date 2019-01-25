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
	TestRigWindow myTestRig = new TestRigWindow();

	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, y'all.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		AddBox myBox = new AddBox();
		add(myBox);

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(byeBye);
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AddBox : Box
{
	Observed switcher;                                                           // *** NEW ***
	
	this()
	{
		super(Orientation.VERTICAL, 5);

		switcher = new Observed();                                                // *** NEW ***
		
		MyCheckButton switchOutputButton = new MyCheckButton(switcher);           // *** NEW ***
		ActionButton actionButton = new ActionButton(switcher);                   // *** NEW ***
		
		add(actionButton);                                                        // *** NEW ***
		add(switchOutputButton);                                                  // *** NEW ***
		
	} // this()

	
	void changeOutput()                                                          // *** NEW ***
	{
		
	} // changeOutput()
	
} // class AddBox


class ActionButton : Button
{
	string label = "Take Action";
	
	string standardMessage = "Droids? We don't need no stinking droids!";        // *** NEW ***
	string switchMessage = "These aren't the droids you're looking for.";        // *** NEW ***
	Observed switcher;                                                           // *** NEW ***

	this(Observed extSwitcher)                                 // *** NEW ***
	{
		super(label);
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
	string label = "Change Output";
	
	Observed switcher;
	
	this(Observed extSwitcher)
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
