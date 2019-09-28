// Notebook - Tabs with Images

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Notebook;
import gtk.Image;
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
	string title = "Notebook - Tabs with Images";
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
	Image tabImageOne, tabImageTwo, tabImageThree;
	TabTextView tabTextViewOne, tabTextViewTwo, tabTextViewThree;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());

		tabTextViewOne = new TabTextView("Now is the witness of our discontinent.");
		tabImageOne = new Image("images/green-man.png");
		appendPage(tabTextViewOne, tabImageOne);
		setTabReorderable(tabTextViewOne, true);

		tabTextViewTwo = new TabTextView("Four stores and seven pounds ago...");
		tabImageTwo = new Image("images/yellow-man.png");
		appendPage(tabTextViewTwo, tabImageTwo);
		setTabReorderable(tabTextViewTwo, true);

		tabTextViewThree = new TabTextView("Help me open yon cantelope.");
		tabImageThree = new Image("images/whisk.png");
		appendPage(tabTextViewThree, tabImageThree);
		setTabReorderable(tabTextViewThree, true);
		
	} // this()
	
} // class MyNotebook


class TabTextView : TextView
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

} // class TabTextView


class CSS // GTK4 compliant
{
	CssProvider provider;
	string cssPath = "./css/visible_tabs.css";

	string myCSS = "notebook
						{
							background-color: #f2f2f2;
						}
						tab
						{
							background-color: #f2f2f2;
						}";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(myCSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
