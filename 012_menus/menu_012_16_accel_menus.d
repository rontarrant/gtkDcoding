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
import gtk.AccelGroup;
import gdk.c.types;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Multiple Menus Example";
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
		
		Main.quit();
		
	} // quitApp()
	
} // testRigWindow


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
	string fileHeaderLabel = "File";
	string editHeaderLabel = "Edit";
	
	FileMenuHeader fileHeader;
	EditMenuHeader editHeader;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		fileHeader = new FileMenuHeader(fileHeaderLabel, accelGroup);
		append(fileHeader);
				
		editHeader = new EditMenuHeader(editHeaderLabel, accelGroup);
		append(editHeader);		
		
	} // this()
	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	FileMenu fileMenuHeader;
	
	this(string headerTitle, AccelGroup accelGroup)
	{
		super(headerTitle);
		
		fileMenuHeader = new FileMenu(accelGroup);
		setSubmenu(fileMenuHeader);
		
	} // this()
	
} // class FileMenuHeader


class EditMenuHeader : MenuItem
{
	EditMenu editMenuHeader;
	
	this(string headerTitle,  AccelGroup accelGroup)
	{
		super(headerTitle);
		
		editMenuHeader = new EditMenu(accelGroup);
		setSubmenu(editMenuHeader);
		
	} // this()
	
} // class EditMenuHeader


class FileMenu : Menu
{
	NewFileItem newFileItem;
	OpenFileItem openFileItem;
	SaveFileItem saveFileItem;
	SaveAsFileItem saveAsFileItem;
	CloseFileItem closeFileItem;
	ExitItem exitItem;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		newFileItem = new NewFileItem(accelGroup);
		append(newFileItem);
		
		openFileItem = new OpenFileItem(accelGroup);
		append(openFileItem);
		
		saveFileItem = new SaveFileItem(accelGroup);
		append(saveFileItem);
		
		saveAsFileItem = new SaveAsFileItem(accelGroup);
		append(saveAsFileItem);
		
		closeFileItem = new CloseFileItem(accelGroup);
		append(closeFileItem);
		
		exitItem = new ExitItem(accelGroup);
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
	NonStandardItem nonStandardItem;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		undoItem = new UndoItem(accelGroup);
		append(undoItem);
		
		redoItem = new RedoItem(accelGroup);
		append(redoItem);
		
		cutItem = new CutItem(accelGroup);
		append(cutItem);
		
		copyItem = new CopyItem(accelGroup);
		append(copyItem);
		
		pasteItem = new PasteItem(accelGroup);
		append(pasteItem);
		
		nonStandardItem = new NonStandardItem(accelGroup);
		append(nonStandardItem);
		
	} // this()
	
} // class EditMenu


class ExitItem : MenuItem
{
	string itemLabel = "Exit";
	char accelKey = 'x';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", true, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		//addOnActivate(&doSomething);
		
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
	char accelKey = 'n';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("New file created.");
		
	} // doSomethingNew()
	
} // class NewFileItem


class OpenFileItem : MenuItem
{
	string itemLabel = "Open";
   char accelKey = 'o';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown now.");
		
	} // doSomething()
	
} // class OpenFileItem


class SaveFileItem : MenuItem
{
	string itemLabel = "Save";
	char accelKey = 's';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);

	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown if the file hasn't, until now, been saved.");
		
	} // doSomething()
	
} // class SaveFileItem


class SaveAsFileItem : MenuItem
{
	string itemLabel = "Save as...";
	char accelKey = 's';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown now.");
		
	} // doSomething()
	
} // class SaveAsFileItem


class CloseFileItem : MenuItem
{
	string itemLabel = "Close";
	char accelKey = 'c';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
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
	char accelKey = 'z';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Doing Undo.");
		
	} // doSomething()
	
} // class UndoItem


class RedoItem : MenuItem
{
	string itemLabel = "Redo";
	char accelKey = 'z';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Doing Redo.");
		
	} // doSomething()
	
} // class RedoItem


class CutItem : MenuItem
{
	string itemLabel = "Cut";
	char accelKey = 'x';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Cutting...");
		
	} // doSomething()
	
} // class CutItem


class CopyItem : MenuItem
{
	string itemLabel = "Copy";
	char accelKey = 'c';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Copying...");
		
	} // doSomething()
	
} // class CopyItem


class PasteItem : MenuItem
{
	string itemLabel = "Paste";
	char accelKey = 'p';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Pasting...");
		
	} // doSomething()
	
} // class PasteItem


class NonStandardItem : MenuItem
{
	string itemLabel = "Non-standard command";
	char accelKey = 'j';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", false, accelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.MOD1_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("This is a non-standard item to show a Ctrl-Alt key combo.");
		
	} // doSomething()
	
} // class PasteItem
