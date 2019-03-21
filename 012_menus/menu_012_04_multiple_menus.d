/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			NewFileItem
 			OpenFileItem
 			CloseFileItem
 			ExitItem
 	EditMenuHeader
 		EditMenu
 			UndoItem
 			RedoItem
 			CutItem
 			CopyItem
 			PasteItem
 	
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
	
	FileMenuHeader fileHeader;
	EditMenuHeader editHeader;
	
	this()
	{
		super();
		
		fileHeader = new FileMenuHeader(fileHeaderLabel);
		append(fileHeader);
				
		editHeader = new EditMenuHeader(editHeaderLabel);
		append(editHeader);		
		
	} // this()
	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	FileMenu fileMenuHeader;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		fileMenuHeader = new FileMenu();
		setSubmenu(fileMenuHeader);
		
	} // this()
	
} // class MenuHeader


class EditMenuHeader : MenuItem
{
	EditMenu editMenuHeader;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		editMenuHeader = new EditMenu();
		setSubmenu(editMenuHeader);
		
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
