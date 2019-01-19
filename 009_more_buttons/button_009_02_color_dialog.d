// Example of:
//  a plain button
//  coded in the OOP paradigm


import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.ColorButton;
import gdk.Event;
import gdk.RGBA;
import gtk.Box;

void main(string[] args)
{
	string title = "Test Rig OOP";
	 
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow(title);

	// Show the window and its contents...
	myTestRig.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	ColorBox box;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);

		box = new ColorBox();
		add(box);

	} // this()
	
	
	void quitApp(Widget w)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ColorBox : Box                                                            // *** NOTE ***
{
	ObservedColor observedColor;
	Orientation orientation = Orientation.VERTICAL;
	int padding = 5;
	Button[] buttons;
	
	this()
	{
		super(orientation, padding);
		observedColor = new ObservedColor();
	
		SetColorButton colorButton = new SetColorButton(observedColor);
		FetchColorButton fetchColorButton = new FetchColorButton("Show Color", observedColor);
		ResetColorButton resetColorButton = new ResetColorButton("Reset Color", observedColor, colorButton);
		buttons = [colorButton, fetchColorButton, resetColorButton];
		
		foreach(button; buttons)
		{
			add(button);
		}

	} // this()
	
} // class ColorBox


class SetColorButton : ColorButton                                              // *** NOTE ***
{
	ObservedColor myColor;
	
	this(ObservedColor extColor)
	{
		super();
		myColor = extColor;
		setRgba(extColor.defaultColor);
		addOnColorSet(&setObservedColor);
		
	} // this()
	
	
	void setObservedColor(ColorButton b)
	{
		RGBA rgba;
		getRgba(rgba);
		
		myColor.setColor(rgba);
		
	} // buttonAction()
	
	
	void setObservedColor(RGBA rgba)
	{
		myColor.color = rgba;
		setRgba(rgba);
		
	} // setObservedColor()
	
} // class SetColorButton


// is passed a pointer to SetColorButton so it can call its setRgba() function
class ResetColorButton : Button                                                 // *** NOTE ***
{
	ObservedColor resetColor;
	SetColorButton setColorButton;
	
	this(string labelText, ObservedColor extColor, SetColorButton extColorButton)
	{
		super(labelText);
		addOnClicked(&buttonAction);
		resetColor = extColor;
		setColorButton = extColorButton;
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		resetColor.setColor(resetColor.defaultColor);
		setColorButton.setRgba(resetColor.defaultColor);
		
	} // buttonAction()
	
} // class ResetColorButton


class FetchColorButton : Button                                                  // *** NOTE ***
{
	ObservedColor showColor;
	
	this(string labelText, ObservedColor extColor)
	{
		super(labelText);
		showColor = extColor;
		addOnClicked(&buttonAction);
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		writeln("Chosen color is: ", showColor.color, " and here is where we'd do something with it.");
		
	} // buttonAction()
	
} // class FetchColorButton


class ObservedColor                                                             // *** NOTE *** r, g, b, a = 0.00 - 1.0
{
	private:
	RGBA color;
	RGBA defaultColor;
	
	this()
	{
		defaultColor = new RGBA(.75, .75, .75, 1.0);
		setColor(defaultColor);
		
	} // this()
	
// end private
	
	public:
	
	void setColor(RGBA extColor)
	{
		color = extColor;
		writeln("Color is now ", extColor);

	} // toggleState()


	RGBA getColor()
	{
		return(color);
		
	} // getColor()

} // class ObservedColor
