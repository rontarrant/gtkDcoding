// Test Rig Foundation for Learning GtkD Coding
// distingish between left, middle and right mouse buttons

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Button;
import gdk.Event;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////

void main(string[] args)
{
	// initialization & creation
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	////////////////////////////////////////////
	// Look in TestRigWindow class for Test Code
	///////////////////////////////////////////
	
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
		
		/////////////////////
		// Test Code Start //
		/////////////////////
		
		// a button that does something
		MyLMRButton myLMRButton = new MyLMRButton("LeftMiddleRight");
		add(myLMRButton);
		
		
		///////////////////
		// Test Code End //
		///////////////////
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class myAppWindow


class MyLMRButton : Button
{
	this(string labelText)
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


	public bool onButtonRelease(Event event, Widget widget)
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


	void leftPress()
	{
		writeln("Left Button pressed.");

	} // leftPress()


	void middlePress()
	{
		writeln("Middle Button pressed.");
		
	} // middlePress()


	void rightPress()
	{
		writeln("Right Button pressed.");
		
	} // rightPress()


	void leftRelease()
	{
		writeln("Left Button released.");
		
	} // leftRelease()


	void middleRelease()
	{
		writeln("Middle Button released.");
		
	} // middleRelease()


	void rightRelease()
	{
		writeln("Right Button released.");
		
	} // rightRelease()

} // class MyLMRButton
