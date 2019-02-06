import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gdk.Event;
import gtk.AboutDialog;
import gdk.Pixbuf;
import gtk.Window;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "Multiple Menus Example";

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
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar(parentWindow);
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	string helpHeaderLabel = "Help";
	
	HelpHeader helpHeader;
	
	this(Window parentWindow)
	{
		super();
		
		helpHeader = new HelpHeader(helpHeaderLabel, parentWindow);
		append(helpHeader);
				
	} // this()

	
} // class MyMenuBar


class HelpHeader : MenuItem
{
	HelpMenu helpMenu;
	
	// arg: a Menu object
	this(string headerTitle, Window parentWindow)
	{
		super(headerTitle);
		
		helpMenu = new HelpMenu(parentWindow);
		setSubmenu(helpMenu);
		
	} // this()
	
} // class HelpHeader


class HelpMenu : Menu
{
	AboutItem aboutItem;
	
	// arg: an array of items
	this(Window parentWindow)
	{
		super();
		
		aboutItem = new AboutItem(parentWindow);
		append(aboutItem);
		
	} // this()
	
} // class HelpMenu


class AboutItem : MenuItem
{
	string itemLabel = "About";
	AboutDialog aboutDialog;
	string sectionName = "Them What Done Stuff";
   string[] people = ["Laurence Fine", "Jerome Howard", "Maurice Howard"];
   string[] artists = ["Andy Warhol", "Salvador Dali", "Sam Carter"];
   string comments = "This is a fine bit of software built for the rigors of testing dialog windows.";
   string[] documenters = ["William Reid", "William Penn Patrick"];
   string license = "This is a FOSS Budget build of a GNOLD project";
   string programName = "About Dialog Demo";
   Pixbuf logoPixbuf;
   Window parentWindow;
   
	this(Window extParentWindow)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		parentWindow = extParentWindow;
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		int responseID;
		
		writeln("Bringing up dialog...");
		
		logoPixbuf = new Pixbuf("images/logo.png");
		
		// Although is seems we should do all this config stuff in this()
		// it has to be done here.
		AboutDialog aboutDialog = new AboutDialog();
		aboutDialog.setAuthors(people);
		aboutDialog.setArtists(artists);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setCopyright("Copyright 2019 © The Three Stooges");
		aboutDialog.setArtists(artists);
		aboutDialog.setComments(comments);
		aboutDialog.setLicense(license);
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setTransientFor(parentWindow);
		
		aboutDialog.run();
		aboutDialog.destroy();
		
	} // doSomething()
	
} // class AboutItem
