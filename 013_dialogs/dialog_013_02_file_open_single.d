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

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
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
	
} // testRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar(parentWindow);
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	string fileHeaderLabel = "File";
	
	FileHeader fileHeader;
	
	this(Window parentWindow)
	{
		super();
		
		fileHeader = new FileHeader(fileHeaderLabel, parentWindow);
		append(fileHeader);
				
	} // this()

	
} // class MyMenuBar


class FileHeader : MenuItem
{
	FileMenu fileMenu;
	
	// arg: a Menu object
	this(string headerTitle, Window parentWindow)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu(parentWindow);
		setSubmenu(fileMenu);
		
	} // this()
	
} // class FileHeader


class FileMenu : Menu
{
	FileOpenItem fileOpenItem;
	
	// arg: an array of items
	this(Window parentWindow)
	{
		super();
		
		fileOpenItem = new FileOpenItem(parentWindow);
		append(fileOpenItem);
		
	} // this()
	
} // class FileMenu


class FileOpenItem : MenuItem
{
	string itemLabel = "Open";
	FileChooserDialog fileChooserDialog;
	Window parentWindow;
	string filename;
  
	this(Window extParentWindow)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		parentWindow = extParentWindow;
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		int response;
		FileChooserAction action = FileChooserAction.OPEN;
		
		FileChooserDialog dialog = new FileChooserDialog("Open a File", parentWindow, action, null, null);
		response = dialog.run();
		
		if(response == ResponseType.OK)
		{
			filename = dialog.getFilename();
			openFile(filename);
		}
		else
		{
			writeln("cancelled.");
		}

		dialog.destroy();
		
	} // doSomething()
	
	
	void openFile(string filename)
	{
		writeln("file to open: ", filename);
		
	} // openFile()
	
} // class FileOpenItem
