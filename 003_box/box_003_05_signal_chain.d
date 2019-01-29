// illustrates how to interrupt the flow of signals 

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.ToggleButton;
import gdk.Event;

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
		addOnButtonRelease(&takeAction);                            // *** NEW ***
		addOnButtonRelease(&outputSomething);
		addOnButtonRelease(&clickReport);                           // *** NEW ***
		addOnButtonRelease(&endStatement);

	} // this()
	
	
	bool endStatement(Event event, Widget widget)
	{
		writeln("\n");
		
		return(true);
		
	} // endStatement()
	
	
	bool clickReport(Event event, Widget widget)                                // *** NEW ***
	{
		writeln("Reporting a click.");
		
		return(false);
		
	} // clickReport()
	
	
	bool takeAction(Event event, Widget widget)                    // *** NEW ***
	{
		bool continueFlag = true;
		
		writeln("Action was taken.");
		
		if(observed.getState() == true)
		{
			continueFlag = false;
		}
		else
		{
			continueFlag = true;
		}

		return(continueFlag);                                              // *** NEW ***
		
	} // takeAction()
		
	
	bool outputSomething(Event event, Widget widget)                                               // *** NEW ***
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

		return(false);
		
	} // outputSomething()

} // class ActionButton


class MyToggleButton : ToggleButton                                             // *** NEW ***
{
	string onText = "Toggle is on.\n";
	string offText = "Toggle is off.\n";
	string onLabel = "Toggle: ON";
	string offLabel = "Toggle: OFF";
	
	Observed observed;

	this(Observed extObserved)
	{
		super(onLabel);
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
			setLabel(offLabel);
		}
		else
		{
			setMode(true);
			observed.setState(true);
			writeln(onText);
			setLabel(onLabel);
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
