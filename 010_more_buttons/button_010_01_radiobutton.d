// example from YouTube demo video

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
	MainWindow win = new MainWindow("Window");
	win.setDefaultSize(500, 500);
	
	RadioBox radioBox = new RadioBox();
	
	win.add(radioBox);
	win.showAll();
	Main.run();
	
} // main()


class RadioBox : Box
{
	int padding = 5;
	Observed mainObserved = new Observed(null);
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		MyRadioButton button1 = new MyRadioButton("button 1", mainObserved);
		
		MyRadioButton button2 = new MyRadioButton("button 2", mainObserved);
		button2.setGroup(button1.getGroup());                                        // ** NOTE **
		
		MyRadioButton button3 = new MyRadioButton("button 3", mainObserved);
		button3.setGroup(button1.getGroup());
		
		ActionButton actionButton = new ActionButton("Do it", mainObserved);
		
		add(button1);
		add(button2);
		add(button3);
		add(actionButton);
		
	} // this()
	
	
} // class Radiobox


class ActionButton : Button
{
	Observed observed;
	
	this(string labelText, Observed extObserved)
	{
		super(labelText);
		addOnClicked(&getSettingState);
		observed = extObserved;
		
	} // this()
	
	
	void getSettingState(Button b)
	{
		writeln("And the setting state is: ", observed.getState());
		
	} // getSettingState()
		
} // class ActionButton


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
	

//	void onToggle(RadioButton b) ******** this also would work, but would use addOnClicked instead of addOnToggled **********
	void onToggle(ToggleButton b)  // because Radio derives from Toggle, we can (and must) do this.
	{
		observed.setState(getLabel());
			
	} // onToggle()

} // class MyRadioButton


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
