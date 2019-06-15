import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gdk.Event;
import gtk.FileChooserDialog;
import gtk.Window;
import gtk.Widget;
import gtk.Entry;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Save Dialog Example";

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		AppBox appBox = new AppBox(this);
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other exit stuff here if necessary
		
		Main.quit();
		
	} // quitApp()
	
} // testRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	TextEntry filenameEntry;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);

		filenameEntry = new TextEntry(parentWindow);
		menuBar = new MyMenuBar(parentWindow, filenameEntry);

		packStart(menuBar, false, false, 0);
		packStart(filenameEntry, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	string fileHeaderLabel = "File";
	
	FileHeader fileHeader;
	
	this(Window parentWindow, TextEntry filenameEntry)
	{
		super();
		
		fileHeader = new FileHeader(fileHeaderLabel, parentWindow, filenameEntry);
		append(fileHeader);
				
	} // this()

	
} // class MyMenuBar


class FileHeader : MenuItem
{
	FileMenu fileMenu;
	
	// arg: a Menu object
	this(string headerTitle, Window parentWindow, TextEntry filenameEntry)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu(parentWindow, filenameEntry);
		setSubmenu(fileMenu);
		
	} // this()
	
} // class FileHeader


class FileMenu : Menu
{
	FileSaveItem fileSaveItem;
	
	// arg: an array of items
	this(Window parentWindow, TextEntry filenameEntry)
	{
		super();
		
		fileSaveItem = new FileSaveItem(parentWindow, filenameEntry);
		append(fileSaveItem);

	} // this()
	
} // class FileMenu


class FileSaveItem : MenuItem
{
	private:
	string itemLabel = "Save";
	FileChooserDialog fileChooserDialog;
	Window _parentWindow;
	string filename;
	TextEntry _filenameEntry;
	
	public:
	this(Window parentWindow, TextEntry filenameEntry)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		_parentWindow = parentWindow;
		_filenameEntry = filenameEntry;

	} // this()
	
	
	private:
	void doSomething(MenuItem mi)
	{
		int response;
		FileChooserAction action = FileChooserAction.SAVE;
		filename = _filenameEntry.getText();
		
		if(filename == "Untitled")
		{
			FileChooserDialog dialog = new FileChooserDialog("Save a File", _parentWindow, action, null, null);

			dialog.setCurrentName(_filenameEntry.getText());
			response = dialog.run();
			
			if(response == ResponseType.OK)
			{
				filename = dialog.getFilename();
				saveFile();
			}
			else
			{
				writeln("cancelled.");
			}
	
			dialog.destroy();		
		}
		else
		{
			saveFile();
		}

		_filenameEntry.setText(filename);
				
	} // doSomething()
	
	
	void saveFile()
	{
		writeln("file to save: ", filename);
				
	} // saveFile()
	
} // class FileSaveItem


class TextEntry : Entry
{
	private:
	string defaultFilename = "Untitled";
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(defaultFilename);
		addOnActivate(&changeFilename);
		
		_parentWindow = parentWindow;
		
	} // this()


	void changeFilename(Entry e)
	{
		if(getText() == null)
		{
			writeln("The filename is an empty string. Resetting to default: Untitled.");
			setText(defaultFilename);
		}
		else
		{
			writeln("Filename has changed to: ", getText());
		}

	} // changeFilename()

} // class TextEntry
