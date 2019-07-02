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
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Dialog: Help - About";

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
	AboutMenuItem aboutMenuItem;
	
	// arg: an array of items
	this(Window parentWindow)
	{
		super();
		
		aboutMenuItem = new AboutMenuItem(parentWindow);
		append(aboutMenuItem);
		
	} // this()
	
} // class HelpMenu


class AboutMenuItem : MenuItem
{
	string itemLabel = "About";
	string sectionName = "Them What Done Stuff";
   string[] people = ["Laurence Find", "Jerome Hayward", "Dick van Puddlesopper"];
   string[] artists = ["Alice Warhol", "Salvador Deli", "My Brother-in-law, Bill"];
   string comments = "This is a fine bit of software built for the rigors of testing dialog windows.";
   string[] documenters = ["Billy Buck Thorndyke", "Phil Gates"];
   string license = "This is a FOSS Budget build of a GNOLD project";
   License licenseType = License.ARTISTIC;
   string programName = "About Dialog Demo";
   string protection = "Copywrong 2019 © The Three Stool Pigeons";
   Pixbuf logoPixbuf;
   string pixbufFilename = "images/logo.png";
   string productVersion = "0.10 (the first, not the tenth, for crying out loud)";
   string website = "http://gtkdcoding.com";
   string websiteLabel = "gtkDcoding";
   Window parentWindow;
	AboutDialog aboutDialog;
	   
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
		
		logoPixbuf = new Pixbuf(pixbufFilename);
		
		// Although it seems we should do all this config stuff in this()
		// it has to be done here.
		AboutDialog aboutDialog = new AboutDialog();
		aboutDialog.setArtists(artists);
		aboutDialog.setAuthors(people);
		aboutDialog.setComments(comments);
		aboutDialog.setCopyright(protection);
		aboutDialog.setDocumenters(documenters);
		aboutDialog.setLicense(license);
		aboutDialog.setLicenseType(licenseType);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setVersion(productVersion);
		aboutDialog.setWebsite(website);
		aboutDialog.setWebsiteLabel(websiteLabel);
		aboutDialog.setTransientFor(parentWindow);
		
		aboutDialog.run();
		aboutDialog.destroy();
		
	} // doSomething()
	
} // class AboutMenuItem
