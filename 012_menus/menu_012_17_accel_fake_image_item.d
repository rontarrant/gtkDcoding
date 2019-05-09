import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gtk.Image;
import gtk.AccelLabel;
import gtk.AccelGroup;
import gdk.c.types;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "ImageMenuItem Example";
	AccelGroup accelGroup;
	
	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		accelGroup = new AccelGroup();
		addAccelGroup(accelGroup);
		
		AppBox appBox = new AppBox(accelGroup);
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
	
	this(AccelGroup accelGroup)
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar(accelGroup);
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	FileMenuHeader fileMenuHeader;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		fileMenuHeader = new FileMenuHeader(accelGroup);
		append(fileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string headerTitle = "Images";
	FileMenu fileMenu;
	
	this(AccelGroup accelGroup)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu(accelGroup);
		setSubmenu(fileMenu);
		
		
	} // this()
	
} // class FileMenuHeader


class FileMenu : Menu
{
	FakeImageMenuItem appleItem;
	ExitMenuItem exitMenuItem;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		appleItem = new FakeImageMenuItem(accelGroup);
		append(appleItem);
		
		exitMenuItem = new ExitMenuItem(accelGroup);
		append(exitMenuItem);

	} // this()
	
	
} // class FileMenu


class FakeImageMenuItem : MenuItem
{
	string actionMessage = "You have added one (1) apple to your cart.";
	Box imageMenuBox;
	string labelText = "Buy an Apple";
	string imageFilename = "images/apples.jpg";
	Image image;
	AccelLabel accelLabel;
	char accelKey = 'a';
   
	this(AccelGroup accelGroup)
	{
		super();
		addOnActivate(&reportStuff);
				
		imageMenuBox = new Box(Orientation.HORIZONTAL, 0);
		add(imageMenuBox);

		image = new Image(imageFilename);

		accelLabel = new AccelLabel(labelText);
		accelLabel.setXalign(0.0);
		accelLabel.setAccelWidget(this);
		
		addAccelerator("activate", accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);

		imageMenuBox.add(image);
		imageMenuBox.packEnd(accelLabel, true, true, 0);
	
	} // this()
	
	
	void reportStuff(MenuItem mi)
	{
		writeln(actionMessage);
		
	} // reportStuff()
	
} // class FakeImageMenuItem


class ExitMenuItem : MenuItem
{
	string itemLabel = "Exit";
	char accelKey = 'x';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", true, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // doSomething()
	
} // class ExitMenuItem
