// Roll-yer-own Custom Dialog

import std.stdio;
import std.typecons;
import std.conv;

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
	
	NewImageDialog newImageDialog;
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
		newImageDialog = new NewImageDialog(_parentWindow);
		
	} // doSomething()

} // class: DialogButton


class NewImageDialog : Dialog
{
	private:
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	string[] buttonLabels = ["OK", "Save Preset", "Cancel"];
	int responseID;
	ResponseType[] responseTypes = [ResponseType.OK, ResponseType.ACCEPT, ResponseType.CANCEL];
	string messageText = "";
	string titleText = "New image...";
	Window _parentWindow;
	Box contentArea; // grabbed from the Dialog
	AreaContent areaContent; // filled with stuff and passed to contentArea;
	
	public:
	this(Window parentWindow)
	{
		_parentWindow = parentWindow;
		super(titleText, _parentWindow, flags, buttonLabels, responseTypes);
		farmOutContent();
		
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()


	void farmOutContent()
	{
		// FARM it out to AreaContent class
		contentArea = getContentArea();
		areaContent = new AreaContent(contentArea);
		
	} // farmOutContent()
	
	
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.OK:
				writeln("Creating new image file with these specs:");
				
				foreach(item; areaContent.getNewImageDataGrid.getData())
				{
					writeln("data item: ", item);
					
				}
				
				
			break;
			
			case ResponseType.ACCEPT:
				writeln("Bringing up a second dialog to save presets using...");

				foreach(item; areaContent.getNewImageDataGrid.getData())
				{
					writeln("data item: ", item);
					
				}
				
			break;
			
			case ResponseType.CANCEL:
				writeln("Cancelled.");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class NewImageDialog


class AreaContent
{
	private:
	Box _contentArea;
	NewImageDataGrid _newImageDataGrid; 
	
	public:
	this(Box contentArea)
	{
		_contentArea = contentArea;
		_newImageDataGrid = new NewImageDataGrid();
		_contentArea.add(_newImageDataGrid);
		_contentArea.showAll();

	} // this()
	
	
	NewImageDataGrid getNewImageDataGrid()
	{
		return(_newImageDataGrid);
		
	} // getNewImageDataGrid()
	
} // class AreaContent


class NewImageDataGrid : Grid
{
	private:
	int _borderWidth = 10; // keeps the widgets from crowding each other in the grid
	
	PadLabel filenameLabel;
	string filenameLabelText = "Filename:";
	PadEntry filenameEntry;
	string filenamePlaceholderText = "Untitled";
	
	PadLabel widthLabel;
	string widthLabelText = "Width:";
	PadEntry widthEntry;
	string widthPlaceholderText = "1920";
	PadLabel widthUnitsLabel;
	string widthUnitsLabelText = "pixels";
	
	PadLabel heightLabel;
	string heightLabelText = "Width:";
	PadEntry heightEntry;
	string heightPlaceholderText = "1080";
	PadLabel heightUnitsLabel;
	string heightUnitsLabelText = "pixels";
	
	PadLabel resolutionLabel;
	string resolutionLabelText = "Width:";
	PadEntry resolutionEntry;
	string resolutionPlaceholderText = "300";
	PadLabel resolutionUnitsLabel;
	string resolutionUnitsLabelText = "pixels/inch";
	
	// store the user-supplied data so it can be retrieved later
	string _filename;
	int _width, _height, _resolution;
	
	public:
	this()
	{
		super();
		setBorderWidth(_borderWidth); // keeps the grid separated from the window edges
		
		// row 0
		filenameLabel = new PadLabel(PadBoxJustify.RIGHT, filenameLabelText);
		attach(filenameLabel, 0, 0, 1, 1);
		
		filenameEntry = new PadEntry(PadBoxJustify.LEFT, filenamePlaceholderText);
		filenameEntry.setWidthInCharacters(30);
		attach(filenameEntry, 1, 0, 2, 1);

		// row 1
		widthLabel = new PadLabel(PadBoxJustify.RIGHT, widthLabelText);
		attach(widthLabel, 0, 1, 1, 1);
				
		widthEntry = new PadEntry(PadBoxJustify.LEFT, widthPlaceholderText);
		attach(widthEntry, 1, 1, 1, 1);
		
		widthUnitsLabel = new PadLabel(PadBoxJustify.RIGHT, widthUnitsLabelText);
		attach(widthUnitsLabel, 2, 1, 1, 1);
		
		// row 2
		heightLabel = new PadLabel(PadBoxJustify.RIGHT, heightLabelText);
		attach(heightLabel, 0, 2, 1, 1);
				
		heightEntry = new PadEntry(PadBoxJustify.LEFT, heightPlaceholderText);
		attach(heightEntry, 1, 2, 1, 1);
		
		heightUnitsLabel = new PadLabel(PadBoxJustify.RIGHT, heightUnitsLabelText);
		attach(heightUnitsLabel, 2, 2, 1, 1);
		
		// row 3
		resolutionLabel = new PadLabel(PadBoxJustify.RIGHT, resolutionLabelText);
		attach(resolutionLabel, 0, 3, 1, 1);
				
		resolutionEntry = new PadEntry(PadBoxJustify.LEFT, resolutionPlaceholderText);
		attach(resolutionEntry, 1, 3, 1, 1);
		
		resolutionUnitsLabel = new PadLabel(PadBoxJustify.RIGHT, resolutionUnitsLabelText);
		attach(resolutionUnitsLabel, 2, 3, 1, 1);
		
	} // this()
	
	Tuple!(string, int, int, int) getData()
	{
		_filename = filenameEntry.getText();
		_width = to!int(widthEntry.getText());
		_height = to!int(heightEntry.getText());
		_resolution = to!int(resolutionEntry.getText());
		
		// build an associative array of user-supplied data
		return(tuple(_filename, _width, _height, _resolution));
		
	} // getData()
	
} // class NewImageDataGrid


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
		if(placeholderText !is null)
		{
			_placeholderText = placeholderText;			
		}
		else
		{
			_placeholderText = "";
		}

		_entry = new Entry(_placeholderText);
		
		super(_entry, pJustify);
		
	} // this()
	
	
	void setVisibility(bool state)
	{
		_entry.setVisibility(state);
		
	} // setVisibility()
	
	void setWidthInCharacters(int width)
	{
		_entry.setWidthChars(width);
		
	} // setWidthInCharacters()
	
	
	string getText()
	{
		return(_entry.getText());
	}
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
		
		setBorderWidth(_borderWidth); // keeps widgets from crowding each other

	} // this()
	
} // class PadBox


enum PadBoxJustify
{
	LEFT = 0,
	RIGHT = 1,
	CENTER = 2,
	
} // PadBoxJustify
