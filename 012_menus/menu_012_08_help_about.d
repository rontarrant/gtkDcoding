/*
  Menu hierarchy, object names and types:
  	menubar (MenuBar)
  		fileHeader (MenuItem)
  			fileMenu (Menu)
  				newFileItem (MenuItem)
  					newFileSubMenu (Menu)
  						dNewFileItem (MenuItem)
  					openFileItem (MenuItem)
  					closeFileItem (MenuItem)
  					exitItem (MenuItem)
  		editHeader (MenuItem)
  			editMenu (Menu)
  				undoItem (MenuItem)
  				redoItem (MenuItem)
  				cutItem (MenuItem)
  				copyItem (MenuItem)
  				pasteItem (MenuItem)
  		helpHeader (MenuItem)
  			helpMenu (Menu)
  				docsItem (MenuItem)
  				aboutItem (MenuItem)
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
import gtk.AboutDialog;

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

		AppBox appBox = new AppBox();
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
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar();
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	string fileHeaderLabel = "File";
	string editHeaderLabel = "Edit";
	string helpHeaderLabel = "Help";
	
	FileHeader fileHeader;
	EditHeader editHeader;
	HelpHeader helpHeader;
	
	this()
	{
		super();
		
		fileHeader = new FileHeader(fileHeaderLabel);
		append(fileHeader);
				
		editHeader = new EditHeader(editHeaderLabel);
		append(editHeader);
		
		helpHeader = new HelpHeader(helpHeaderLabel);
		append(helpHeader);
				
	} // this()

	
} // class MyMenuBar


class FileHeader : MenuItem
{
	FileMenu fileMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
	} // this()
	
} // class MenuHeader


class EditHeader : MenuItem
{
	EditMenu editMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		editMenu = new EditMenu();
		setSubmenu(editMenu);
		
	} // this()
	
} // class MenuHeader


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
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
	
} // class FileMenu


class EditMenu : Menu
{
	UndoItem undoItem;
	RedoItem redoItem;
	CutItem cutItem;
	CopyItem copyItem;
	PasteItem pasteItem;
	
	// arg: an array of items
	this()
	{
		super();
		
		undoItem = new UndoItem();
		append(undoItem);
		
		redoItem = new RedoItem();
		append(redoItem);
		
		cutItem = new CutItem();
		append(cutItem);
		
		copyItem = new CopyItem();
		append(copyItem);
		
		pasteItem = new PasteItem();
		append(pasteItem);
		
	} // this()
	
	
} // class EditMenu


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
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // exit()
	
} // class ExitItem


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


class UndoItem : MenuItem
{
	string itemLabel = "Undo";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Doing Undo.");
		
	} // doSomething()
	
} // class UndoItem


class RedoItem : MenuItem
{
	string itemLabel = "Redo";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Doing Redo.");
		
	} // doSomething()
	
} // class RedoItem


class CutItem : MenuItem
{
	string itemLabel = "Cut";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Cutting...");
		
	} // doSomething()
	
} // class CutItem


class CopyItem : MenuItem
{
	string itemLabel = "Copy";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Copying...");
		
	} // doSomething()
	
} // class CopyItem


class PasteItem : MenuItem
{
	string itemLabel = "Paste";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Pasting...");
		
	} // doSomething()
	
} // class PasteItem


class HelpHeader : MenuItem
{
	HelpMenu helpMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		helpMenu = new HelpMenu();
		setSubmenu(helpMenu);
		
	} // this()
	
} // class HelpHeader


class HelpMenu : Menu
{
	DocsItem docsItem;
	AboutItem aboutItem;
	
	// arg: an array of items
	this()
	{
		super();
		
		docsItem = new DocsItem();
		append(docsItem);
		
		aboutItem = new AboutItem();
		append(aboutItem);
		
	} // this()
	
} // class HelpMenu


class DocsItem : MenuItem
{
	string itemLabel = "Docs";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Going to the documentation page...");
		
	} // doSomething()
	
} // class DocsItem


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
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		int responseID;
		
		writeln("Bringing up dialog...");
		
		AboutDialog aboutDialog = new AboutDialog();
		aboutDialog.setAuthors(people);
		aboutDialog.setArtists(artists);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setCopyright("Copyright 2019 © The Three Stooges");
		aboutDialog.setArtists(artists);
		aboutDialog.setComments(comments);
		aboutDialog.setLicense(license);
		aboutDialog.setProgramName(programName);
		aboutDialog.run();
		aboutDialog.destroy();
		
	} // doSomething()
	
} // class AboutItem
