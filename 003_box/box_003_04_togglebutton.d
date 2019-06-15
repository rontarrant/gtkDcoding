// ToggleButton with an observer

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.ToggleButton;                                          // *** NEW ***

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "ToggleButton with Observer";
	string greeting = "Hello GtkD World.";
	string ungreeting = "Bye, bye, GtkD World.";
	AddBox addBox;
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		addBox = new AddBox();
		add(addBox);
		
		showAll();
		
	} // this()
	
	
	void sayHi()
	{
		writeln(greeting); // appears in the console, not the GUI
		
	} // sayHi()
	
	
	void quitApp()
	{
		writeln(ungreeting);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AddBox : Box
{
	this()
	{
		super(Orientation.VERTICAL, 5);
		
		ObservedToggleButton observedToggleButton = new ObservedToggleButton();
		ObserverButton observerButton = new ObserverButton(observedToggleButton);

		add(observerButton);
		add(observedToggleButton);
		
	} // this()
	
} // class AddBox


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
		string trueMessage = "Walls make good neighbours, eh.";
		string falseMessage = "Berlin doesn't like walls.";
		
		write("observedState = ", observed.getMode(), ": "); // NOTE: no linefeed here
		
		if(observed.getMode()) // if it's 'true'
		{
			writeln(trueMessage);
		}
		else
		{
			writeln(falseMessage);
		}

	} // outputSomething()

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
	
} // class ObservedToggleButton
