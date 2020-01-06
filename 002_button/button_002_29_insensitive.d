// This source code is in the public domain.

// GTK Insensitive Switch Example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Grid;
import gtk.Button;
import gtk.Switch;
import gtk.Label;
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
	string title = "Insensitive Switch";
	string byeBye = "Bye-bye";
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
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

	
} // class TestRigWindow


class AppBox : Box
{
	ButtonGrid buttonGrid;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		buttonGrid = new ButtonGrid();
		packStart(buttonGrid, false, false, localPadding);
		
	} // this()

} // class AppBox


class ButtonGrid : Grid
{
	MySwitch mySwitch;
	MyButton myButton;
	Label switchLabel;
	int borderWidth = 10;
	int columnSpacing = 10, rowSpacing = 5;

	this()
	{
		switchLabel = new Label("Insensitize Me");
		attach(switchLabel, 0, 0, 1, 1);
		mySwitch = new MySwitch();
		attach(mySwitch, 1, 0, 1, 1);
		
		myButton = new MyButton();
		attach(myButton, 0, 1, 2, 1);
		myButton.setCompanion(mySwitch);

		setBorderWidth(borderWidth);
		setMarginBottom(10);
		setColumnSpacing(columnSpacing);
		setRowSpacing(rowSpacing);
		
	} // this()
	
} // class ButtonGrid


class MySwitch : Switch
{
	this()
	{
		super();
		addOnStateSet(&onStateSet);
		
	} // this()


	bool onStateSet(bool state, Switch s)
	{
		writeln("state = ", state);
		
		if(state)
		{
			writeln("The Switch is turned on.");
		}
		else
		{
			writeln("The Switch is turned off.");
		}
		
		return(true);
		
	} // onStateSet()
	
} // class MySwitch


class MyButton : Button
{
	MySwitch companion;
	string[] labelText = ["Activate", "Deactivate"];
	
	this()
	{
		super(labelText[1]);
		addOnButtonPress(&onButtonPress);
		
	} // this()


	bool onButtonPress(Event e, Widget w)
	{
		if(companion.getSensitive() is false)
		{
			writeln("Activating switch");
			companion.setSensitive(true);
			setLabel(labelText[1]);
		}
		else
		{
			writeln("Deactivating switch.");
			companion.setSensitive(false);
			setLabel(labelText[0]);
		}
		
		return(true);
		
	} // onButtonPress()
	
	
	void setCompanion(MySwitch otherSwitch)
	{
		companion = otherSwitch;
		
	} // setCompanion()
	
} // class MyButton
