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

	TestRigWindow myTestRig = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string greeting = "Hello GtkD World.";
	string ungreeting = "Bye, bye, GtkD World.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		AddBox addBox = new AddBox();
		add(addBox);
		
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void sayHi()
	{
		writeln(greeting); // appears in the console, not the GUI
	}
	
	
	void quitApp()
	{
		writeln(ungreeting);
		
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
		
		ActionButton myActionButton = new ActionButton(observed);
		MyToggleButton myToggle = new MyToggleButton(observed);                   // *** NEW ***
		add(myActionButton);
		add(myToggle);
		
	} // this()
	
} // class AddBox


class ActionButton : Button
{
	string label = "Take Action";
	
	Observed observed;

	this(Observed extObserved)
	{
		super(label);
		observed = extObserved;
		addOnClicked(&outputSomething);
		
	} // this()
	
	
	void outputSomething(Button b)                                               // *** NEW ***
	{
		write("observedState = ", observed.observedState, ": ");
		
		if(observed.getState()) // if it's 'true'
		{
			writeln("Walls make good neighbours, eh.");
		}
		else
		{
			writeln("Berlin doesn't like walls.");
		}
	}
} // class ActionButton


class MyToggleButton : ToggleButton                                             // *** NEW ***
{
	string onText = "Toggle is on.";
	string offText = "Toggle is off.";
	string label = "Toggle: ON";
	string altLabel = "Toggle: OFF";
	
	Observed observed;

	this(Observed extObserved)
	{
		super(label);
		addOnClicked(&toggleMode);
		setMode(true);
		
		observed = extObserved;
		writeln(onText);
		
	} // this()
	
	
	void toggleMode(Button b)
	{
		if(getMode() == true)
		{
			setMode(false);
			observed.setState(false);
			writeln(offText);
			setLabel(altLabel);
		}
		else
		{
			setMode(true);
			observed.setState(true);
			writeln(onText);
			setLabel(label);
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
