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
	string title = "Insensitive Switch and Label";
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
	MySwitch mySwitch1, mySwitch2, mySwitch3;
	MyButton myButton;
	Label switchLabel1, switchLabel2, switchLabel3;
	int borderWidth = 10;
	int columnSpacing = 10, rowSpacing = 5;

	this()
	{
		switchLabel1 = new Label("Insensitize Me");
		attach(switchLabel1, 0, 0, 1, 1);
		mySwitch1 = new MySwitch();
		attach(mySwitch1, 1, 0, 1, 1);
		
		switchLabel2 = new Label("Insensitize Me, too");
		attach(switchLabel2, 0, 2, 1, 1);
		mySwitch2 = new MySwitch();
		attach(mySwitch2, 1, 2, 1, 1);
		
		switchLabel3 = new Label("Me, three!");
		attach(switchLabel3, 0, 3, 1, 1);
		mySwitch3 = new MySwitch();
		attach(mySwitch3, 1, 3, 1, 1);

		myButton = new MyButton();
		attach(myButton, 0, 4, 2, 1);
		myButton.addCompanion(cast(Widget)mySwitch1);
		myButton.addCompanion(cast(Widget)mySwitch2);
		myButton.addCompanion(cast(Widget)mySwitch3);

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
	Widget[] companions;
	string[] labelText = ["Activate", "Deactivate"];
	
	this()
	{
		super(labelText[1]);
		addOnButtonPress(&onButtonPress);
		
	} // this()


	bool onButtonPress(Event e, Widget w)
	{
		if(companions[0].getSensitive() is false)
		{
			writeln("Activating switch");
			companions[0].setSensitive(true);
			setLabel(labelText[1]);
		}
		else
		{
			writeln("Deactivating switch.");
			companions[0].setSensitive(false);
			setLabel(labelText[0]);
		}
		
		return(true);
		
	} // onButtonPress()
	
	
	void addCompanion(Widget widget)
	{
		companions ~= widget;
		
		if(companions[0] != widget)
		{
			companions[0].bindProperty("sensitive", widget, "sensitive", GBindingFlags.DEFAULT);
		}

	} // addCompanion()
	
} // class MyButton
