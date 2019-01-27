// distingish between left, middle and right mouse buttons

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event; // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, bye.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		MyLMRButton myLMRButton = new MyLMRButton();             // *** NEW ***
		add(myLMRButton);
		
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()

} // class myAppWindow


class MyLMRButton : Button                                        // *** NEW ***
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
	
	
	public bool onButtonPress(Event event, Widget widget)          // *** NEW ***
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


	public bool onButtonRelease(Event event, Widget widget)        // *** NEW ***
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


	void mousePress(uint mouseButton)                                               // *** NEW ***
	{
		
		writeln("The ", mouseButtons[mouseButton], " was pressed.");

	} // mousePress()


	void mouseRelease(uint mouseButton)                                             // *** NEW ***
	{
		writeln("The ", mouseButtons[mouseButton], " was released.");
		
	} // mouseRelease()

} // class MyLMRButton
