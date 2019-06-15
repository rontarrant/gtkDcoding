/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			KeepCheckMenuItem
 	
 */

import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.CheckMenuItem;
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
	string title = "CheckMenuItem Example";

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
	MakeItFancyCheckMenuItem makeItFancyItem;
	
	this()
	{
		super();
		
		makeItFancyItem = new MakeItFancyCheckMenuItem();
		append(makeItFancyItem);
		
	} // this()

} // class FileMenu


class MakeItFancyCheckMenuItem : CheckMenuItem
{
	string makeItFancyLabel = "Make it fancy";
   
	this()
	{
		super(makeItFancyLabel);
		setActive(true);
		addOnToggled(&choose);
		
	} // this()
	
	
	void choose(CheckMenuItem mi)
	{
		if(getActive() == true)
		{
			keepItFancy();
		}
		else
		{
			makeItPlain();
		}
		
	} // choose()
	
	
	void keepItFancy()
	{
		writeln("We're making it fancy, yes, sir.");
		
	} // keepItFancy()
	
	
	void makeItPlain()
	{
		writeln("K.I.S.");
		
	} // makeItPlain()
	
} // class MakeItFancyCheckMenuItem
