// This source code is in the public domain.

// Example of:
//  an array of Buttons
//  coded in the OOP paradigm
//  Build an array of Button objects. Echo a list of pointers to Buttons.
// Verify each Button pointer from within the Button's callback.

import std.stdio;
import std.conv;
import std.algorithm;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
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
	string title = "<Insert Title>";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	
	// add child object and variable definitions here
	MyButton[] buttons;
	MyButton newButton;
	int lastButtonID = -1;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		foreach(int i; 0..4)
		{
			lastButtonID++;
			newButton = new MyButton(to!string(lastButtonID), this);
			packStart(newButton, expand, fill, localPadding);
			buttons ~= newButton;
		}

		foreach(ulong i; 0..buttons.length)
		{
			writeln("Button: ", cast(MyButton*)buttons[i], ", label: ", buttons[i].getLabel(), ", ID: ", buttons[i].buttonID);
		}

		writeln("\n");
		
	} // this()


	long findButton(MyButton findButton)
	{
		long index = buttons.countUntil(findButton);
		
		return(index);
		
	} // findButton()

} // class AppBox


class MyButton : Button
{
	string labelText = "Button ";
	int buttonID;
	AppBox _appBox;
	
	this(string suffix, AppBox appBox)
	{
		labelText ~= suffix;
		super(labelText);
		
		buttonID = to!int(suffix);
		_appBox = appBox;
		
		addOnClicked(&buttonAction); // *** NEW ***
		
	} // this()
	
	
	// echo button info to the terminal
	void buttonAction(Button b)
	{
		MyButton* currentButton = cast(MyButton*)this;
		writeln("Button clicked: ", getLabel(), ", address: ", currentButton, ", ID: ", buttonID);
		writeln("found in the array at index: ", _appBox.findButton(this), "\n");
		
	} // buttonAction()
	
} // class MyButton
