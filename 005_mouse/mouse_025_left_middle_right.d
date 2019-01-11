// distingish between left, middle and right mouse buttons

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event; // *** NEW ***

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");

	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to gtkD
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		// window
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// a button that does something
		MyLMRButton myLMRButton = new MyLMRButton("LeftMiddleRight");             // *** NEW ***
		add(myLMRButton);
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class myAppWindow


class MyLMRButton : Button                                        // *** NEW ***
{
	this(string labelText)
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

			if(buttonEvent.button == 3)
			{
				rightPress();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middlePress();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftPress();
				value = true;
			}
		}

		return(value);
		
	} // onButtonPress()


	public bool onButtonRelease(Event event, Widget widget)        // *** NEW ***
	{
		bool value = false;
		
		if(event.type == EventType.BUTTON_RELEASE)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				rightRelease();
				value = true;
			}
			else if(buttonEvent.button == 2)
			{
				middleRelease();
				value = true;

			}
			else if(buttonEvent.button == 1)
			{
				leftRelease();
				value = true;
			}
		}

		return(value);
		
	} // onButtonRelease()


	void leftPress()                                               // *** NEW ***
	{
		writeln("Left Button pressed.");

	} // leftPress()


	void middlePress()                                             // *** NEW ***
	{
		writeln("Middle Button pressed.");
		
	} // middlePress()


	void rightPress()                                              // *** NEW ***
	{
		writeln("Right Button pressed.");
		
	} // rightPress()


	void leftRelease()                                             // *** NEW ***
	{
		writeln("Left Button released.");
		
	} // leftRelease()


	void middleRelease()                                           // *** NEW ***
	{
		writeln("Middle Button released.");
		
	} // middleRelease()


	void rightRelease()                                            // *** NEW ***
	{
		writeln("Right Button released.");
		
	} // rightRelease()

} // class MyLMRButton
