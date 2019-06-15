/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			NewFileItem
 			OpenFileItem
 			CloseFileItem
 			QuitItem
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

// NOTE: use the '-i' compiler flag to include our own external modules
import singleton.S_AccelGroup;

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
	S_AccelGroup s_AccelGroup;

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		s_AccelGroup = s_AccelGroup.get();
		addAccelGroup(s_AccelGroup);

		AppBox appBox = new AppBox();
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other quit stuff here if necessary
		
		Main.quit();
		
	} // quitApp()
	
} // class TestRigWindow


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
	
	this(string headerTitle)
	{
		super(headerTitle);
		
		fileMenuHeader = new FileMenu();
		setSubmenu(fileMenuHeader);
		
	} // this()
	
} // class FileMenuHeader


class EditMenuHeader : MenuItem
{
	EditMenu editMenuHeader;
	
	this(string headerTitle)
	{
		super(headerTitle);
		
		editMenuHeader = new EditMenu();
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
	QuitItem quitItem;
	
	this()
	{
		super();
		
		newFileItem = new NewFileItem();
		append(newFileItem);
		
		openFileItem = new OpenFileItem();
		append(openFileItem);
		
		saveFileItem = new SaveFileItem();
		append(saveFileItem);
		
		saveAsFileItem = new SaveAsFileItem();
		append(saveAsFileItem);
		
		closeFileItem = new CloseFileItem();
		append(closeFileItem);
		
		quitItem = new QuitItem();
		append(quitItem);
		
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
		
		nonStandardItem = new NonStandardItem();
		append(nonStandardItem);
		
	} // this()
	
} // class EditMenu


class QuitItem : MenuItem
{
	string itemLabel = "Quit";
	char accelKey = 'q';
	S_AccelGroup s_AccelGroup;
   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();		
		super(&doSomething, itemLabel, "activate", true, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // quit()
	
} // class QuitItem


class NewFileItem : MenuItem
{
	string itemLabel = "New";
	char accelKey = 'n';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("New file created.");
		
	} // doSomething()
	
} // class NewFileItem


class OpenFileItem : MenuItem
{
	string itemLabel = "Open";
   char accelKey = 'o';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown now for chosing a file to open.");
		
	} // doSomething()
	
} // class OpenFileItem


class SaveFileItem : MenuItem
{
	string itemLabel = "Save";
	char accelKey = 's';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown ONLY if the file hasn't yet been saved.");
		
	} // doSomething()
	
} // class SaveFileItem


class SaveAsFileItem : MenuItem
{
	string itemLabel = "Save as...";
	char accelKey = 's';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("A file dialog will be shown so the file can be saved under a different name.");
		
	} // doSomething()
	
} // class SaveAsFileItem


class CloseFileItem : MenuItem
{
	string itemLabel = "Close";
	char accelKey = 'w';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("The file is closed.");
		
		// If this was the last open file, 
		// pop up a Dailog to ask if the the application should also be closed.
		
	} // doSomething()
	
} // class CloseFileItem


class UndoItem : MenuItem
{
	string itemLabel = "Undo";
	char accelKey = 'z';
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
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
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.SHIFT_MASK, AccelFlags.VISIBLE);
		
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
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
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
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
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
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		
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
	S_AccelGroup s_AccelGroup;
	   
	this()
	{
		s_AccelGroup = s_AccelGroup.get();
		super(&doSomething, itemLabel, "activate", false, s_AccelGroup, accelKey, ModifierType.CONTROL_MASK | ModifierType.MOD1_MASK, AccelFlags.VISIBLE);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("This is a non-standard item to show a Ctrl-Alt key combo.");
		
	} // doSomething()
	
} // class NonStandardItem
