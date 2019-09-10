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
import gdk.RGBA;
import gtk.EventBox;
import gtk.CssProvider;
import gtk.StyleContext;

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
	CSS css; // need to see tab shapes against the bg
	PositionType tabPosition = PositionType.TOP;
	int tabIndex;
	Label myTabLabel;
	MyTextView myTextview;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());
		
		myTabLabel = new Label("Demo Tab");
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


class CSS // GTK4 compliant
{
	CssProvider provider;
	string cssPath = "./css/visible_tabs.css";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromPath(cssPath);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
