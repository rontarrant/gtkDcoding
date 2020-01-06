// This source code is in the public domain.

// example of a multiple Widgets as Observers
// using an Interface to add Observer functionality

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.Entry;
import gdk.Event;
import gtk.Image;
import gtk.CheckButton;

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
	
	string title = "Multiple Observers";
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
	WatchedButton switchButton;
	ObserverButton actionButton;
	ObserverEntry observerEntry;
	ObserverImage observerImage;
	
	this()
	{
		super(Orientation.VERTICAL, 5);

		actionButton = new ObserverButton();
		observerEntry = new ObserverEntry();
		observerImage = new ObserverImage();

		switchButton = new WatchedButton();
		switchButton.addObserver(cast(Observer)observerImage);
		switchButton.addObserver(cast(Observer)actionButton);
		switchButton.addObserver(cast(Observer)observerEntry);
		
		add(observerImage);
		add(actionButton);
		add(observerEntry);
		add(switchButton);
		
	} // this()

} // class ObservationBox


interface Observer
{
	void update(bool value);
	
} // interface Observer


class ObserverImage : Image, Observer
{
	string robot = "images/robot.png";
	string monkey = "images/monkey-in-a-tin-suit.png";
	string current;
	
	this()
	{
		super();
		current = robot;
		setFromFile(current);	
	}
	
	void update(bool state)
	{
		if(state == true)
		{
			current = monkey;
		}
		else
		{
			current = robot;
		}

		setFromFile(current);
		
	} // update()
	
} // class ObserverImage


class ObserverButton : Button, Observer
{
	private:
	string[] labels = ["These Droids?", "What Droids?"];

	public:
	this()
	{
		super(labels[0]);
		addOnClicked(&doSomething);
		
	} // this()
	
	
	void doSomething(Button b)
	{
		string message;

		if(getLabel() == labels[0])
		{
			message = "These aren't the droids you're looking for.";
		}
		else
		{
			message = "These aren't droids. They're monkeys in tin suits.";
		}

		writeln(message);
		
	} // doSomething()
	
	
	void update(bool state)
	{
		setLabel(labels[state]);
		
	} // updateSubjectState()
	
} // class ObserverButton


class ObserverEntry : Entry, Observer
{
	string predefinedText = "Droid Name: D4QP";
	
	this()
	{
		super(predefinedText);
		setVisibility(true);
		
	} // this()


	void update(bool state)
	{
		state = !state;
		setVisibility(state);
		
	} // update()
	
} // class ObserverEntry


class WatchedButton : CheckButton
{
	string buttonText = "Switch Output";
	Observer[] observers;
	
	this()
	{
		super(buttonText);
		addOnClicked(&updateAll);
		
	} // this()
	
	
	void addObserver(Observer observer)
	{
		observers ~= observer;
		
	} // addObserver()
	
	
	void updateAll(Button b)
	{
		foreach(observer; observers)
		{
			observer.update(getActive());
			
		}
		
	} // updateAll()

} // class WatchedButton
