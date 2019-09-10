// Description of example

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
	int tabIndex;
	Label myTabLabel;
	MyTextView myTextview;
	
	this()
	{
		super();
		setTabPos(tabPosition);

		myTabLabel = new Label(tabLabel);
		myTextview = new MyTextView();
		tabIndex = appendPage(myTextview, myTabLabel);
				
	} // this()
	
} // class MyNotebook


class MyTextView : TextView
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

} // class MyTextView
