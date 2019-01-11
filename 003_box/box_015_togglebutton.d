// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.ToggleButton;                                          // *** NEW ***

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
		Button[] buttons;
		
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		AddBox addBox = new AddBox();
		add(addBox);
		
	} // this() CONSTRUCTOR
	
	
	void sayHi()
	{
		writeln("Hello GtkD World."); // appears in the console, not the GUI
	}
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AddBox : Box
{
	Observed observed;
	
	this()
	{
		super(Orientation.VERTICAL, 5);
		
		// set up observer/observed to sync up the buttons
		observed = new Observed();
		
		ActionButton myActionButton = new ActionButton("Take Action", observed);
		MyToggleButton myToggle = new MyToggleButton("Toggle", observed);         // *** NEW ***
		add(myActionButton);
		add(myToggle);
		
	} // this()
	
} // class AddBox


class ActionButton : Button
{
	Observed observed;

	this(string label, Observed extObserved)
	{
		super(label);
		observed = extObserved;
		addOnClicked(&outputSomething);
		
	} // this()
	
	
	void outputSomething(Button b)                                               // *** NEW ***
	{
		if(observed.getState()) // if it's 'true'
		{
			writeln("observedState = ", observed.observedState, " Walls make good neighbours, eh.");
		}
		else
		{
			writeln("observedState = ", observed.observedState, " Berlin doesn't like walls.");
		}
	}
} // class ActionButton


class MyToggleButton : ToggleButton                                             // *** NEW ***
{
	Observed observed;

	this(string label, Observed extObserved)
	{
		super(label);
		addOnClicked(&toggleMode);
		setMode(true);
		observed = extObserved;
		
	} // this()
	
	
	void toggleMode(Button b)
	{
		if(getMode() == true)
		{
			setMode(false);
			observed.setState(false);
			writeln("Toggle is off.");
		}
		else
		{
			setMode(true);
			observed.setState(true);
			writeln("Toggle is on.");
		}
	
	} // report()
	
} // class MyToggleButton


class Observed
{
	private:
	bool observedState;
	
	this()
	{
		observedState = true;
		
	} // this()
	
// end private
	
	public:
	
	void toggleState()
	{
		if(observedState == true)
		{
			observedState = false;
		}
		else
		{
			observedState = true;
		}

	} // toggleState()


	void setState(bool state)
	{
		observedState = state;
		
	} // setState()
	
	
	bool getState()
	{
		return(observedState);
		
	} // getState()

} // class Observed
