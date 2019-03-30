import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.ImageMenuItem;
import gtk.Widget;
import gtk.Image;
import gtk.Label;

// Note: Orientation flags are found in gtk.c.types

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "ImageMenuItem Example";

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
	
} // TestRigWindow


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
	string headerTitle = "Images";
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
	FakeIconMenuItem keepItem;
	
	this()
	{
		super();
		
		keepItem = new FakeIconMenuItem();
		append(keepItem);
		
	} // this()
	
	
} // class FileMenu


class FakeIconMenuItem : ImageMenuItem
{
	string actionMessage = "You have added a plane to your cart.";
	IconMenuBox iconMenuBox;
   
	this()
	{
		super();
		
		iconMenuBox = new IconMenuBox();
		add(iconMenuBox);
		
		addOnActivate(&reportStuff);
		
	} // this()
	
	
	void reportStuff(MenuItem mi)
	{
		writeln(actionMessage);
		
	} // exit()
	
} // class MyIconMenuItem


class IconMenuBox : Box
{
	string menuLabelText = "Buy a _Plane";
	Image icon;
	string iconName = "airplane-mode-symbolic";
	Label label;	
	
	this()
	{
		super(Orientation.HORIZONTAL, 0); // no padding 'cause we're on a menu
		
		icon = new Image(iconName, IconSize.MENU);
		label = new Label(menuLabelText);

		packStart(icon, true, true, 0);
		packStart(label, true, true, 0);
		
	}

} // class IconMenuBox
