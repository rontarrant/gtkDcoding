// Description of example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Label;
import gtk.Button;
import gtk.Image;
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
	string title = "Notebook Demo - Tab with Close Button";
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
	Orientation orientation = Orientation.VERTICAL;
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyNotebook myNotebook;
	
	this()
	{
		super(orientation, globalPadding);
		
		myNotebook = new MyNotebook();
		
		packStart(myNotebook, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class MyNotebook : Notebook
{
	PositionType tabPosition = PositionType.TOP;
	int tabIndex;
	MyTextView myTextview;
	TabBox myTab;
	
	this()
	{
		super();
		setTabPos(tabPosition);

		myTab = new TabBox();
		myTextview = new MyTextView();
		tabIndex = appendPage(myTextview, myTab);
		showAll();
		
	} // this()
	
} // class MyNotebook


class TabBox : Box
{
	Label label;
	CloseButton closeButton;
	string labelText = "Tab with Close";
	Orientation orientation = Orientation.HORIZONTAL;
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;

	this()
	{
		super(orientation, globalPadding);
		
		label = new Label(labelText);
		packStart(label, expand, fill, localPadding);
		
		closeButton = new CloseButton();
		packStart(closeButton, expand, fill, localPadding);
		
		showAll();
		
	} // this()
	
} // class TabBox


class CloseButton : Button
{
	bool focusOnClick = false;
	Image closeButtonImage;
	
	this()
	{
		closeButtonImage = new Image("images/window-close.png");
		add(closeButtonImage);
		
	} // this()
	
} // class CloseButton


class MyTextView : TextView
{
	TextBuffer textBuffer;
	string content = "Now is the winter of our discontinence.";
	int width = 400, height = 350;
	
	this()
	{
		super();
		setSizeRequest(width, height);
		textBuffer = getBuffer();
		textBuffer.setText(content);
		
	} // this()

} // class MyTextView
