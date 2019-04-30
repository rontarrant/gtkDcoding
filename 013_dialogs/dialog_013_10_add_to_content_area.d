// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Window;
import gtk.Main;
import gtk.Box;
import gtk.Button;
import gtk.Dialog;
import gtk.c.types;
import gtk.Widget;
import gtk.Box;
import gtk.Grid;
import gtk.Label;
import gtk.Entry;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox(this);
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AppBox : Box
{
	DialogButton dialogButton;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, 10);
		
		dialogButton = new DialogButton(parentWindow);
		
		packStart(dialogButton, false, false, 0);
		
	} // this()

} // class AppBox


class DialogButton : Button
{
	private:
	string labelText = "Open a Dialog";
	
	ScratchDialog scratchDialog;
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(labelText);
		addOnClicked(&doSomething);
		_parentWindow = parentWindow;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		scratchDialog = new ScratchDialog(_parentWindow);
		
	} // doSomething()

} // class: DialogButton


class ScratchDialog : Dialog
{
	private:
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	string[] buttonLabels = ["Login", "Sign Up", "Cancel"];
	int responseID;
	ResponseType[] responseTypes = [ResponseType.OK, ResponseType.ACCEPT, ResponseType.CANCEL];
	string messageText = "";
	string titleText = "Select direction...";
	Window _parentWindow;
	Box contentArea; // grabbed from the Dialog
	AreaContent areaContent; // filled with stuff and passed to contentArea;
	
	public:
	this(Window parentWindow)
	{
		_parentWindow = parentWindow;
		super(titleText, _parentWindow, flags, buttonLabels, responseTypes);
		customizeContent();
		
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()


	void customizeContent()
	{
		// FARM it out to AreaContent class
		contentArea = getContentArea();
		areaContent = new AreaContent(contentArea);
		
	} // customizeContent()
	
	
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.OK:
				writeln("You're all logged in.");
			break;
			
			case ResponseType.ACCEPT:
				writeln("Heading to the Sign-up page...");
			break;
			
			case ResponseType.CANCEL:
				writeln("Operation cancelled.");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class ClicheMessageDialog


class AreaContent
{
	Box _contentArea;
	PadGrid padGrid; 
	
	this(Box contentArea)
	{
		_contentArea = contentArea;
		padGrid = new PadGrid();
		_contentArea.add(padGrid);
		_contentArea.showAll();

	} // this()
	
} // class AreaContent


class PadGrid : Grid
{
	int _borderWidth = 10;
	PadLabel userLabel;
	string userLabelText = "Username:";
	PadEntry userEntry;
	string userPlaceholderText = "Who goes there?";
	PadLabel passwordLabel;
	string passwordLabelText = "Password:";
	PadEntry passwordEntry;
	string passwordPlaceholderText = "What's the password?";	
	
	this()
	{
		super();
		setBorderWidth(_borderWidth);
		
		// row 0
		userLabel = new PadLabel(PadBoxJustify.RIGHT, userLabelText);
		attach(userLabel, 0, 0, 1, 1);
		userLabel.setHalign(Align.END);
		
		userEntry = new PadEntry(PadBoxJustify.LEFT, userPlaceholderText);
		attach(userEntry, 1, 0, 1, 1);
		userEntry.setHalign(Align.START);

		// row 1
		passwordLabel = new PadLabel(PadBoxJustify.RIGHT, passwordLabelText);
		attach(passwordLabel, 0, 1, 1, 1);
		passwordLabel.setHalign(Align.END);
				
		passwordEntry = new PadEntry(PadBoxJustify.LEFT);
		attach(passwordEntry, 1, 1, 1, 1);
		passwordEntry.setHalign(Align.START);
		passwordEntry.setVisibility(false);
		
	} // this()
	
} // class PadGrid


class PadLabel : PadBox
{
	Label label;
	
	this(PadBoxJustify pJustify, string text = null)
	{
		label = new Label(text);
		
		super(label, pJustify);
		
	} // this()
	
} // class PadLabel


class PadEntry : PadBox
{
	Entry _entry;
	string _placeholderText;
	
	this(PadBoxJustify pJustify, string placeholderText = null)
	{
		_placeholderText = placeholderText;
		_entry = new Entry(_placeholderText);
		
		super(_entry, pJustify);
		
	} // this()
	
	
	void setVisibility(bool state)
	{
		_entry.setVisibility(state);
		
	} // setVisibility()
	
} // class PadLabel


class PadBox : Box
{
	Widget _widget;
	int globalPadding = 0;
	int padding = 0;
	bool fill = false;
	bool expand = false;
	int _borderWidth = 5;

	PadBoxJustify _pJustify;
	
	this(Widget widget, PadBoxJustify pJustify)
	{
		_widget = widget;
		_pJustify = pJustify;
		
		super(Orientation.HORIZONTAL, globalPadding);

		if(_pJustify == PadBoxJustify.LEFT)
		{
			packStart(_widget, expand, fill, padding);
		}
		else if(_pJustify == PadBoxJustify.RIGHT)
		{
			packEnd(_widget, expand, fill, padding);
		}
		else
		{
			add(_widget);
		}	
		
		setBorderWidth(_borderWidth);

	} // this()
	
} // class PadBox


enum PadBoxJustify
{
	LEFT = 0,
	RIGHT = 1,
	CENTER = 2,
	
} // PadBoxJustify
