/*
 Diagram:
 
 MyMenuBar
 	FileFileMenuHeader
 		FileMenu
 			NewFileItem
 			OpenFileItem
 			CloseFileItem
 			-------------- (separator)
 			ExitItem
 	
 */

import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gdk.Event;
import gtk.SeparatorMenuItem;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "Menu Separator Example";

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
	FileMenuHeader fileFileMenuHeader;
	
	this()
	{
		super();
		
		fileFileMenuHeader = new FileMenuHeader();
		append(fileFileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string fileHeaderTitle = "File";
	FileMenu fileMenu;
	
	// arg: a Menu object
	this()
	{
		super(fileHeaderTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
		
	} // this()
	
} // class FileMenuHeader


class FileMenu : Menu
{
	NewFileItem newFileItem;
	OpenFileItem openFileItem;
	CloseFileItem closeFileItem;
	ExitItem exitItem;
	
	// arg: an array of items
	this()
	{
		super();
		
		newFileItem = new NewFileItem();
		append(newFileItem);
		
		openFileItem = new OpenFileItem();
		append(openFileItem);
		
		closeFileItem = new CloseFileItem();
		append(closeFileItem);
		
		SeparatorMenuItem separator = new SeparatorMenuItem();
		append(separator);
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
	
} // class FileMenu


class NewFileItem : MenuItem
{
	string itemLabel = "New";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("New file created.");
		
	} // doSomethingNew()
	
} // class NewFileItem


class OpenFileItem : MenuItem
{
	string itemLabel = "Open";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown now.");
		
	} // doSomething()
	
} // class OpenFileItem


class CloseFileItem : MenuItem
{
	string itemLabel = "Close";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("The file is closed.");
		
		// If this was the last open file, 
		// ask the user if the the application should also be closed.
		
	} // doSomething()
	
} // class CloseFileItem


class ExitItem : MenuItem
{
	string itemLabel = "Exit";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		Main.quit();
		
	} // exit()
	
} // class ExitItem
