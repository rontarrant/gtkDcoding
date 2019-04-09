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
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "Open a File Using a Dialog";

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
	
} // TestRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	TextEntry filenameEntry;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);

		filenameEntry = new TextEntry("Untitled");
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
	string itemLabel = "Save";
	FileChooserDialog fileChooserDialog;
	Window parentWindow;
	string filename = "Untitled";
	TextEntry filenameEntry;
	
	this(Window extParentWindow, TextEntry extFilenameEntry)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		parentWindow = extParentWindow;
		
		filenameEntry = extFilenameEntry;
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		int response;
		FileChooserAction action = FileChooserAction.SAVE;
		
		if(filename == "Untitled")
		{
			FileChooserDialog dialog = new FileChooserDialog("Save a File", parentWindow, action, null, null);
			dialog.setCurrentName(filename);
			response = dialog.run();
			
			if(response == ResponseType.OK)
			{
				filename = dialog.getFilename();
				saveFile(filename);
			}
			else
			{
				writeln("cancelled.");
			}
	
			dialog.destroy();		
		}
		else
		{
			saveFile(filename);
		}

		filenameEntry.setText(filename);
		
	} // doSomething()
	
	
	void saveFile(string filename)
	{
		writeln("file to save: ", filename);
		
	} // saveFile()
	
} // class FileSaveItem


class TextEntry : Entry
{
	string predefinedText;
	
	this(string text)
	{
		predefinedText = text;
		
		super(predefinedText);
		
	} // this()

} // class TextEntry
