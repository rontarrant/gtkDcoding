/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
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

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "Menu with one Item";

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
	string headerTitle = "File";
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
	ExitItem exitItem;
	
	this()
	{
		super();
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
	
} // class FileMenu


class ExitItem : MenuItem
{
	string exitLabel = "Exit";
   
	this()
	{
		super(exitLabel);
		addOnActivate(&exit);
		
	} // this()
	
	
	void exit(MenuItem mi)
	{
		Main.quit();
		
	} // exit()
	
} // class FileMenuItem
