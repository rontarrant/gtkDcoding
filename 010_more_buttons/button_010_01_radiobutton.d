import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Box;
import gtk.RadioButton;
import gtk.ToggleButton; // so we can use the toggle signal
import gtk.Button;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow testRigWin = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Window";
	RadioBox radioBox;
	
	this()
	{
		super(title);
		setDefaultSize(500, 500);
	
		radioBox = new RadioBox();
		add(radioBox);

		showAll();
		
	} // this()
	
} // class TestRigWindow


class RadioBox : Box
{
	int padding = 5;
	Observed observed = new Observed(null);
	MyRadioButton button1, button2, button3;
	ActionButton actionButton;
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		button1 = new MyRadioButton("button 1", observed);
		
		button2 = new MyRadioButton("button 2", observed);
		button2.setGroup(button1.getGroup());                                        // ** NOTE **
		
		button3 = new MyRadioButton("button 3", observed);
		button3.setGroup(button1.getGroup());
		
		observed.setState(button2.getLabel());      	// set the initial state
		button2.setActive(true);							// must be set AFTER all buttons are built (because the last button built is set as active)

		actionButton = new ActionButton(observed);
		
		add(button1);
		add(button2);
		add(button3);
		add(actionButton);
		
	} // this()
	
	
} // class Radiobox


// The first RadioButton created will have its mode set automatically?
class MyRadioButton : RadioButton
{
	Observed observed;
	
	this(string labelText, Observed extObserved)
	{
		super(labelText);
		addOnToggled(&onToggle); // this signal derives from Toggle
		
		observed = extObserved;
		
	} // this()
	

	void onToggle(ToggleButton b)  // because Radio derives from Toggle, we can (and must) do this.
	{
		observed.setState(getLabel());
		
	} // onToggle()

} // class MyRadioButton


class ActionButton : Button
{
	string labelText = "Do it";
	Observed observed;
	string stateMessage = "And the setting state is: ";
	
	this(Observed extObserved)
	{
		super(labelText);
		
		addOnClicked(&getSettingState);
		
		observed = extObserved;
		
	} // this()
	
	
	void getSettingState(Button b)
	{
		writeln(stateMessage, observed.getState());
		
	} // getSettingState()
		
} // class ActionButton


class Observed
{
	private:
	string observedState;
	
	this(string extState)
	{
		setState(extState);
		
	} // this()
	
// end private
	
	public:
	
	void setState(string extState)
	{
		observedState = extState;

	} // toggleState()


	string getState()
	{
		return(observedState);
		
	} // getState()

} // class Observed
