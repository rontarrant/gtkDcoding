/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			NewFileSubHeader
 				NewFileSubMenu
 					DFileSubItem
 					TextFileSubItem
 					ImageFileSubItem
 					SpreadsheetFileSubItem
 					PdfFileSubItem
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
	string title = "Multiple Menus and a Submenu";

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
	string fileMenuHeaderLabel = "File";
	string editMenuHeaderLabel = "Edit";
	
	FileMenuHeader fileMenuHeader;
	EditMenuHeader editMenuHeader;
	
	this()
	{
		super();
		
		fileMenuHeader = new FileMenuHeader(fileMenuHeaderLabel);
		append(fileMenuHeader);
				
		editMenuHeader = new EditMenuHeader(editMenuHeaderLabel);
		append(editMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	FileMenu fileMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
	} // this()
	
} // class FileMenuHeader


class FileMenu : Menu
{
	NewFileSubHeader newFileSubHeader;
	OpenFileItem openFileItem;
	CloseFileItem closeFileItem;
	ExitItem exitItem;
	
	// arg: an array of items
	this()
	{
		super();
		
		newFileSubHeader = new NewFileSubHeader();
		append(newFileSubHeader);
		
		openFileItem = new OpenFileItem();
		append(openFileItem);
		
		closeFileItem = new CloseFileItem();
		append(closeFileItem);
		
		exitItem = new ExitItem();
		append(exitItem);
		
	} // this()
	
} // class FileMenu


class NewFileSubHeader : MenuItem
{
	string itemLabel = "New";
	NewFileSubMenu newFileSubMenu;
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
		newFileSubMenu = new NewFileSubMenu();
		setSubmenu(newFileSubMenu);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("New file created.");
		
	} // doSomethingNew()
	
} // class NewFileSubHeader


class NewFileSubMenu : Menu
{
	DFileSubItem dFileItem;
	TextFileSubItem textFileItem;
	ImageFileItem imageFileItem;
	SpreadsheetFileSubItem spreadsheetFileItem;
	PdfFileSubItem pdfFileItem;
	
	this()
	{
		super();
		
		dFileItem = new DFileSubItem();
		append(dFileItem);
		
		textFileItem = new TextFileSubItem();
		append(textFileItem);
		
		imageFileItem = new ImageFileItem();
		append(imageFileItem);
		
		spreadsheetFileItem = new SpreadsheetFileSubItem();
		append(spreadsheetFileItem);
		
		pdfFileItem = new PdfFileSubItem();
		append(pdfFileItem);
		
	} // this()
	
} // class NewFileSubMenu


class DFileSubItem : MenuItem
{
	string itemLabel = "D Source File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.d'");
		
	} // doSomething()
	
} // class UndoItem


class TextFileSubItem : MenuItem
{
	string itemLabel = "Text File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.txt'");
		
	} // doSomething()
	
} // class TextFileSubItem


class ImageFileItem : MenuItem
{
	string itemLabel = "Image File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.png, *.jpg, *.tiff'");
		
	} // doSomething()
	
} // class CutItem


class SpreadsheetFileSubItem : MenuItem
{
	string itemLabel = "Spreadsheet File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.csv, *.xls'");
		
	} // doSomething()
	
} // class SpreadsheetFileSubItem


class PdfFileSubItem : MenuItem
{
	string itemLabel = "PDF File";
   
	this()
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Dialog appears with filter: '*.pdf'");
		
	} // doSomething()
	
} // class PdfFileSubItem


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
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // exit()
	
} // class ExitItem


class EditMenuHeader : MenuItem
{
	EditMenu editMenu;
	
	// arg: a Menu object
	this(string headerTitle)
	{
		super(headerTitle);
		
		editMenu = new EditMenu();
		setSubmenu(editMenu);
		
	} // this()
	
} // class EditMenuHeader


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
