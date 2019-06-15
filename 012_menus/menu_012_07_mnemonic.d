import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
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
	string title = "Menu Item with a Mnemonic Shortcut Key";

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		AppBox appBox = new AppBox();
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other exit stuff here if necessary
		// like call an external function
		
		Main.quit();
		
	} // quitApp()
	
} // testRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar();
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	FileMenuHeader fileMenuHeader;
	
	this()
	{
		super();
		
		fileMenuHeader = new FileMenuHeader();
		append(fileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string headerTitle = "_File";
	FileMenu fileMenu;
	
	this()
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
		
	} // this()
	
} // class FileMenu


class FileMenu : Menu
{
	NewFileItem newFileItem;
	ExitItem exitItem;
	
	this()
	{
		super();
		
		newFileItem = new NewFileItem();
		append(newFileItem);
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
	
} // class FileMenu


class NewFileItem : MenuItem
{
	string newFileLabel = "_New";
   
	this()
	{
		super(newFileLabel, true); // true turns on the mnemonic
		addOnActivate(&newFile);
		
	} // this()
	
	
	void newFile(MenuItem mi)
	{
		writeln("New file created.");
		
	} // newFile()
	
} // class NewFileItem


class ExitItem : MenuItem
{
	string exitLabel = "E_xit";
   
	this()
	{
		super(&exit, exitLabel, true);
		
	} // this()
	
	
	void exit(MenuItem mi)
	{
		Main.quit();
		
	} // exit()
	
} // class ExitItem
