// Notebook - Working with Child Widgets

import std.stdio;
import std.conv;
import std.algorithm;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Grid;
import gtk.Button;
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
	string title = "Notebook - Working with Child Widgets";
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
	
	ButtonGrid buttonGrid; 
	MyNotebook myNotebook;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		myNotebook = new MyNotebook(); // create this first so the Buttons can communicate

		buttonGrid = new ButtonGrid(myNotebook);
		
		packStart(buttonGrid, expand, fill, localPadding);
		packStart(myNotebook, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class ButtonGrid : Grid
{
	InsertButton insertButton;
	RemoveButton removeButton;
	PageInfoButton pageInfoButton;
	
	this(MyNotebook myNotebook)
	{
		insertButton = new InsertButton(myNotebook);
		attach(insertButton, 0, 0, 1, 1);
		
		removeButton = new RemoveButton(myNotebook);
		attach(removeButton, 1, 0, 1, 1);
		
		pageInfoButton = new PageInfoButton(myNotebook);
		attach(pageInfoButton, 2, 0, 1, 1);
		
	} // this()
	
} // class ButtonGrid


class InsertButton : Button
{
	string _buttonLabel = "Insert Page";
	TabTextView myTextView;
	MyNotebook _myNotebook;
	
	this(MyNotebook myNotebook)
	{
		super(_buttonLabel);
		
		_myNotebook = myNotebook;
		
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button button)
	{
		_myNotebook.addPage();
		
	} // onClicked()
	
} // class InsertButton


class RemoveButton : Button
{
	string _buttonLabel = "Remove Page";

	MyNotebook _myNotebook;

	this(MyNotebook myNotebook)
	{
		super(_buttonLabel);
		_myNotebook = myNotebook;
		
		addOnClicked(&onClicked);
				
	} // this()
	
	
	void onClicked(Button button)
	{
		_myNotebook.deletePage();
		
	} // onClicked()
	
} // class RemoveButton


class PageInfoButton : Button
{
	string _buttonLabel = "Page Info";

	MyNotebook _myNotebook;

	this(MyNotebook myNotebook)
	{
		super(_buttonLabel);
		_myNotebook = myNotebook;
		
		addOnClicked(&onClicked);
				
	} // this()
	
	
	void onClicked(Button button)
	{
		int currentPage = _myNotebook.getCurrentPage();
		TabTextView tabTextView = cast(TabTextView)_myNotebook.getNthPage(currentPage);
		Label tabLabel = cast(Label)_myNotebook.getTabLabel(tabTextView);
		
		writeln("currentPage position in the Notebook tabs array:", currentPage);
		writeln("tabLabel: ", tabLabel.getText());
		writeln("tabTextView contents: ", tabTextView.getBuffer().getText()); 
		
	} // onClicked()
	
} // class PageInfoButton


class MyNotebook : Notebook
{
	CSS css; // need to see tab shapes against the bg
	PositionType tabPosition = PositionType.TOP;
	string tabLabelPrefix = "Tab ";
	int _lastPageNumber = -1;
	
	this()
	{
		super();
		setTabPos(tabPosition);
		css = new CSS(getStyleContext());
		addPage();
	
	} // this()
	
	
	void addPage()
	{
		_lastPageNumber++; // increase the page count
		string text = "Tab " ~ _lastPageNumber.to!string();
		TabTextView tabTextView = new TabTextView();
		Label label = new Label(text);
		appendPage(tabTextView, label);
		setTabReorderable(tabTextView, true);
		writeln("page added: ", _lastPageNumber);

		showAll();
		
	} // addPage()


	void deletePage()
	{
		int page;
		
		page = getCurrentPage();
		removePage(page);
		writeln("page removed: ", page);
				
	} // deletePage()

} // class MyNotebook


class TabTextView : TextView
{
	TextBuffer textBuffer;
	int width = 400, height = 350;
	
	this()
	{
		super();
		setSizeRequest(width, height);
		textBuffer = getBuffer();
		
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
