// This source code is in the public domain.

// Description of example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Toolbar;
import gtk.ToolButton;
import gtk.Button;
import gtk.Image;
import gtk.ToolItem;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Toolbar Example";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyToolbar myToolbar;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myToolbar = new MyToolbar();
		
		packStart(myToolbar, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox


class MyToolbar : Toolbar
{
	ToolButton cutToolButton, copyToolButton, pasteToolButton;

	this()
	{
		super();
		setStyle(ToolbarStyle.BOTH);

		cutToolButton = new CutToolButton();
		insert(cutToolButton);

		copyToolButton = new CopyToolButton();
		insert(copyToolButton);
		
		pasteToolButton = new PasteToolButton();
		insert(pasteToolButton);
		
	} // this()
	
} // class MyToolbar


class CutToolButton : ToolButton
{
	CutButton cutButton;
	string actionMessage = "Cut operation.";

	this()
	{
		cutButton = new CutButton();
		super(cutButton, "Cut");		
		addOnClicked(&doSomething);
		
	} // this()


	void doSomething(ToolButton b)
	{
		writeln(actionMessage);
		
	} // doSomething()

} // class CutToolButton


class CutButton : Button
{
	Image image;
	string imageFilename = "images/edit-cut-symbolic.symbolic.png";
		
	this()
	{
		super();
		
		image = new Image(imageFilename);
		add(image);
		
	} // this()
	
} // class CutButton


class CopyToolButton : ToolButton
{
	CopyButton copyButton;
	string actionMessage = "Copy operation.";

	this()
	{
		copyButton = new CopyButton();
		super(copyButton, "Copy");		
		addOnClicked(&doSomething);
		
	} // this()


	void doSomething(ToolButton b)
	{
		writeln(actionMessage);
		
	} // doSomething()

} // class CopyToolButton


class CopyButton : Button
{
	Image image;
	string imageFilename = "images/edit-copy-symbolic.symbolic.png";
		
	this()
	{
		super();
		
		image = new Image(imageFilename);
		add(image);
		
	} // this()
	
} // class CopyButton


class PasteToolButton : ToolButton
{
	PasteButton pasteButton;
	string actionMessage = "Paste operation.";

	this()
	{
		pasteButton = new PasteButton();
		super(pasteButton, "Paste");		
		addOnClicked(&doSomething);
		
	} // this()


	void doSomething(ToolButton b)
	{
		writeln(actionMessage);
		
	} // doSomething()

} // class PasteToolButton


class PasteButton : Button
{
	Image image;
	string imageFilename = "images/edit-paste-symbolic.symbolic.png";
		
	this()
	{
		super();
		
		image = new Image(imageFilename);
		add(image);
		
	} // this()
	
} // class PasteButton
