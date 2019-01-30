// Test Rig with an observer pattern and a ToggleButton

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
		
		ObservationBox addBox = new ObservationBox();
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


class ObservationBox : Box
{
	this()
	{
		super(Orientation.VERTICAL, 5);
		
		ObservedToggleButton observedToggle = new ObservedToggleButton();
		ObserverButton myObserverButton = new ObserverButton(observedToggle);

		add(myObserverButton);
		add(observedToggle);
		
	} // this()
	
} // class ObservationBox


class ObserverButton : Button
{
	string label = "Take Action";
	
	ObservedToggleButton observed;

	this(ObservedToggleButton extObserved)
	{
		super(label);
		observed = extObserved;
		addOnClicked(&outputSomething);
		
	} // this()
	
	
	void outputSomething(Button b)
	{
		write("observedState = ", observed.getMode(), ": "); // NOTE: no linefeed here
		
		if(observed.getMode()) // if it's 'true'
		{
			writeln("Walls make good neighbours, eh.");
		}
		else
		{
			writeln("Berlin doesn't like walls.");
		}
	}
} // class ObserverButton


class ObservedToggleButton : ToggleButton
{
	string onText = "Toggle is on.";
	string offText = "Toggle is off.";
	string onLabel = "Toggle: ON";
	string offLabel = "Toggle: OFF";
	
	this()
	{
		super(onLabel);
		addOnToggled(&toggleMode);
		setMode(true);
		
		writeln(onText);
		
	} // this()
	
	
	void toggleMode(ToggleButton tb)
	{
		if(getMode() == true)
		{
			setMode(false);
			writeln(offText);
			setLabel(offLabel);
		}
		else
		{
			setMode(true);
			writeln(onText);
			setLabel(onLabel);
		}
	
	} // toggleMode()
	
} // class MyToggleButton
