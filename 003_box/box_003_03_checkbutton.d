// example of a CheckButton
// using an Observer pattern to keep two buttons in sync

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
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	ObservationBox observationBox;
	
	string title = "Test Rig: CheckButton";
	string byeBye = "Bye, y'all.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		observationBox = new ObservationBox();
		add(observationBox);

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(byeBye);
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ObservationBox : Box
{
	this()
	{
		super(Orientation.VERTICAL, 5);

		CheckButton switchOutputButton = new CheckButton("Switch Output");
		ObserverButton actionButton = new ObserverButton(switchOutputButton);
		
		add(actionButton);
		add(switchOutputButton);
		
	} // this()

} // class ObservationBox


class ObserverButton : Button
{
	string label = "Take Action";
	
	string standardMessage = "Droids? We don't need no stinking droids!";
	string switchMessage = "These aren't the droids you're looking for.";
	CheckButton checkButton;

	this(CheckButton extCheckButton)
	{
		super(label);
		addOnClicked(&doSomething);
		checkButton = extCheckButton;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		if(checkButton.getActive() == true)
		{
			writeln(switchMessage);
		}
		else
		{
			writeln(standardMessage);
		}
		
	} // doSomething()
	
} // class ObservationButton

