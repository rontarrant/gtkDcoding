// Description of example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Notebook;
import gtk.Label;
import gtk.TextView;
import gtk.TextBuffer;
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
	string tabLabelOne = "Tab One", tabLabelTwo = "Tab Two", tabLabelThree = "Tab Three";
	Label myTabLabelOne, myTabLabelTwo, myTabLabelThree;
	int tabIndex;
	MyTextView myTextViewOne, myTextViewTwo, myTextViewThree;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());

		myTextViewOne = new MyTextView("Now is the witness of our discontinent.");
		myTabLabelOne = new Label(tabLabelOne);
		tabIndex = appendPage(myTextViewOne, tabLabelOne);
//		setTabReorderable(myTextViewOne, true);

		myTextViewTwo = new MyTextView("Four stores and seven pounds ago...");
		myTabLabelTwo = new Label(tabLabelTwo);
		tabIndex = appendPage(myTextViewTwo, tabLabelTwo);
//		setTabReorderable(myTextViewTwo, true);

		myTextViewThree = new MyTextView("Help me open yon cantelope.");
		myTabLabelThree = new Label(tabLabelThree);
		tabIndex = appendPage(myTextViewThree, tabLabelThree);
//		setTabReorderable(myTextViewThree, true);
		
	} // this()
	
} // class MyNotebook


class MyTextView : TextView
{
	TextBuffer textBuffer;
	int width = 400, height = 350;
	
	this(string content)
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
