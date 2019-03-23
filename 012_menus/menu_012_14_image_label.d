import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.ImageMenuItem;
import gtk.Widget;
import gdk.Event;
import gtk.Image;
import gtk.Label;

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
	MyImageMenuItem keepItem;
	
	this()
	{
		super();
		
		keepItem = new MyImageMenuItem();
		append(keepItem);
		
	} // this()
	
	
} // class FileMenu


class MyImageMenuItem : ImageMenuItem
{
	string actionMessage = "You have added one (1) apple to your cart.";
	ImageMenuBox imageMenuBox;
   
	this()
	{
		super();
		
		imageMenuBox = new ImageMenuBox();
		add(imageMenuBox);
		
		addOnActivate(&reportStuff);
		
	} // this()
	
	
	void reportStuff(MenuItem mi)
	{
		writeln(actionMessage);
		
	} // exit()
	
} // class MyImageMenuItem


class ImageMenuBox : Box
{
	string imageLabelText = "Image 1";
	string imageFilename = "images/apples.jpg";
	Image image;
	Label label;
	
	this()
	{
		super(Orientation.HORIZONTAL, 0); // no padding 'cause we're on a menu
		
		image = new Image(imageFilename);
		label = new Label(imageLabelText);

		packStart(image, true, true, 0);
		packStart(label, true, true, 0);
		
	}
	
	
} // class ImageMenuBox
