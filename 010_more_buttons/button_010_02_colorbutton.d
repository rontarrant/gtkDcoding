// ColorButton

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
	Main.init(args);

	testRigWindow testRigWindow = new testRigWindow();

	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig OOP";
	string byeBye = "Bye, bye, y'all.";
	ColorBox box;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);

		box = new ColorBox();
		add(box);

		showAll();

	} // this()
	
	
	void quitApp(Widget w)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

} // class testRigWindow


class ColorBox : Box                                                            // *** NOTE ***
{
	int padding = 5;
	ObservedColor observedColor;
	Orientation orientation = Orientation.VERTICAL;
	SetColorButton colorButton;
	FetchColorButton fetchColorButton;
	ResetColorButton resetColorButton;
	Button[] buttons;
	
	this()
	{
		super(orientation, padding);
		observedColor = new ObservedColor();
		
		// create the buttons
		colorButton = new SetColorButton(observedColor);
		fetchColorButton = new FetchColorButton(observedColor);
		resetColorButton = new ResetColorButton(observedColor, colorButton);
		
		// stuff them into an array...
		buttons = [colorButton, fetchColorButton, resetColorButton];
		
		// so we can do this:
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
		
	} // setObservedColor()

} // class SetColorButton


// is passed a pointer to SetColorButton so it can call its setRgba() function
class ResetColorButton : Button                                                 // *** NOTE ***
{
	string labelText = "Reset Color";
	ObservedColor resetColor;
	SetColorButton setColorButton;
	
	this(ObservedColor extColor, SetColorButton extColorButton)
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
	string labelText = "Show Color";
	string preMessage = "Chosen color is: ";
	string postMessage = " and here is where we'd do something with it.";
	
	ObservedColor showColor;
	
	this(ObservedColor extColor)
	{
		super(labelText);
		
		showColor = extColor;
		
		addOnClicked(&buttonAction);
		
	} // this()
	
	
	void buttonAction(Button b)
	{
		writeln(preMessage, showColor.color, postMessage);
		
	} // buttonAction()
	
} // class FetchColorButton


class ObservedColor                                                             // *** NOTE *** r, g, b, a = 0.00 - 1.0
{
	private:
	string message = "Color is now ";
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
		writeln(message, extColor);

	} // toggleState()


	RGBA getColor()
	{
		return(color);
		
	} // getColor()

} // class ObservedColor
