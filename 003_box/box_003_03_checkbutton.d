// example of a CheckButton
// using an Observer pattern to keep two buttons in sync

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gdk.Event;
import gtk.CheckButton;                                           // *** NEW ***

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
	
	string title = "CheckButton with Observer";
	string byeBye = "Bye, y'all.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		observationBox = new ObservationBox();
		add(observationBox);

		showAll();

	} // this()
	
	
	void quitApp()
	{
		writeln(byeBye);
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ObservationBox : Box
{
	CheckButton switchOutputButton;
	ObserverButton actionButton;
	string checkButtonText = "Switch Output";
	
	this()
	{
		super(Orientation.VERTICAL, 5);

		switchOutputButton = new CheckButton(checkButtonText);
		actionButton = new ObserverButton(switchOutputButton);
		
		add(actionButton);
		add(switchOutputButton);
		
	} // this()

} // class ObservationBox


class ObserverButton : Button
{
	private:
	string label = "Take Action";
	CheckButton _checkButton;

	public:
	this(CheckButton checkButton)
	{
		super(label);
		addOnClicked(&doSomething);
		_checkButton = checkButton;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		string standardMessage = "Droids? We don't need no stinking droids!";
		string switchMessage = "These aren't the droids you're looking for.";

		if(_checkButton.getActive() == true)
		{
			writeln(switchMessage);
		}
		else
		{
			writeln(standardMessage);
		}
		
	} // doSomething()
	
} // class ObserverButton
