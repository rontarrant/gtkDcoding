// This source code is in the public domain.

// Notebook demo #1 - a simple example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Label;
import gtk.Notebook;
import gtk.TextView;
import gtk.TextBuffer;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Notebook Demo - Simple";
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
	MyNotebook myNotebook;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myNotebook = new MyNotebook();
		
		packStart(myNotebook, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class MyNotebook : Notebook
{
	PositionType tabPosition = PositionType.TOP;
	string tabLabel = "Demo Tab";
	Label _label;
	TabTextView _tabTextView;
	
	this()
	{
		super();
		setTabPos(tabPosition);

		_label = new Label(tabLabel);
		_tabTextView = new TabTextView();
		appendPage(_tabTextView, _label);
				
	} // this()
	
} // class MyNotebook


class TabTextView : TextView
{
	TextBuffer textBuffer;
	string content = "Now is the English of our discontent.";
	int width = 400, height = 350;
	
	this()
	{
		super();
		setSizeRequest(width, height);
		textBuffer = getBuffer();
		textBuffer.setText(content);
		
	} // this()

} // class TabTextView
