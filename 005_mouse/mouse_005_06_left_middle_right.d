// This source code is in the public domain.

// distingish between left, middle and right mouse buttons

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
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
	MyLMRButton myLMRButton;
	
	string title = "Left, Middle or Right Mouse Button";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		myLMRButton = new MyLMRButton();
		add(myLMRButton);
		
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string byeBye = "Bye, bye.";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class TestRigWindow


class MyLMRButton : Button
{
	string labelText = "LeftMiddleRight";
	string[] mouseButtons = ["None", "Left", "Middle", "Right"]; // we'll never get a '0', so "None" keeps us from having
	                                                             // to do math to get the right name for the event 
	
	this()
	{
		super(labelText);
		addOnButtonPress(&onButtonPress);
		addOnButtonRelease(&onButtonRelease);
		
	} // this()
	
	
	public bool onButtonPress(Event event, Widget widget)
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			mousePress(buttonEvent.button);

			value = true;
		}

		return(value);
		
	} // onButtonPress()


	public bool onButtonRelease(Event event, Widget widget)
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			mouseRelease(buttonEvent.button);

			value = true;
		}

		return(value);
		
	} // onButtonRelease()


	void mousePress(uint mouseButton)
	{
		
		writeln("The ", mouseButtons[mouseButton], " was pressed.");

	} // mousePress()


	void mouseRelease(uint mouseButton)
	{
		writeln("The ", mouseButtons[mouseButton], " was released.");
		
	} // mouseRelease()

} // class MyLMRButton
