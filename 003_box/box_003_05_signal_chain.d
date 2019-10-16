// This source code is in the public domain.

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
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Interrupt Signal Chain";
	string greeting = "Hello GtkD World.";
	string ungreeting = "Bye, bye, GtkD World.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		AddBox addBox = new AddBox();
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
	int globalPadding = 5;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		WatchedButton myToggle = new WatchedButton();
		ObserverButton observerButton = new ObserverButton(myToggle);

		add(observerButton);
		add(myToggle);
		
	} // this()
	
} // class AddBox


class ObserverButton : Button
{
	string label = "Take Action";
	WatchedButton _watchedButton;
	
	this(WatchedButton watchedButton)
	{
		super(label);
		_watchedButton = watchedButton;
		
		// signal hook-ups
		addOnButtonRelease(&outputSomething);
		addOnButtonRelease(&takeAction);
		addOnButtonRelease(&clickReport);
		addOnButtonRelease(&endStatement);

	} // this()
	
	
	bool endStatement(Event event, Widget widget)
	{
		string message = "And that's the report from Walls-R-Us.\n";
		 
		writeln(message);
		
		return(true);
		
	} // endStatement()
	
	
	bool clickReport(Event event, Widget widget)
	{
		string message = "Reporting a click.";
		 
		writeln(message);
		
		return(false);
		
	} // clickReport()
	
	
	bool takeAction(Event event, Widget widget)
	{
		bool continueFlag = true;
		string trueMessage = "A value of 'false' keeps the signal chain going.";
		string falseMessage = "A value of 'true' tells the chain its work is done.\n";
		
		writeln("Action was taken.");
		
		if(_watchedButton.getMode() == true)
		{
			continueFlag = false;
			writeln(trueMessage);
		}
		else
		{
			continueFlag = true;
			writeln(falseMessage);
		}

		return(continueFlag);
		
	} // takeAction()
		
	
	bool outputSomething(Event event, Widget widget)
	{
		string trueMessage = "Walls make good neighbours, eh.";
		string falseMessage = "Berlin doesn't like walls.";
		
		write("observedState = ", _watchedButton.getMode(), ": ");
		
		if(_watchedButton.getMode()) // if it's 'true'
		{
			writeln(trueMessage);
		}
		else
		{
			writeln(falseMessage);
		}

		return(false);
		
	} // outputSomething()

} // class ObserverButton


class WatchedButton : ToggleButton
{
	string onText = "Toggle is on.\n";
	string offText = "Toggle is off.\n";
	string onLabel = "Toggle: ON";
	string offLabel = "Toggle: OFF";
	
	this()
	{
		super(onLabel);
		addOnClicked(&toggleMode);
		setMode(true);
		
		writeln(onText);
		
	} // this()
	
	
	void toggleMode(Button b)
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
	
} // class WatchedButton
