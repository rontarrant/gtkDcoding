// Notebook - All Signals

import std.stdio;
import std.conv;
import std.algorithm;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Notebook;
import gtk.Label;
import gtk.TextView;
import gtk.TextBuffer;
import gtk.Grid;
import gtk.Button;
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
	string title = "Notebook - All Signals";
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
		showAll();
		
	} // this()

} // class AppBox


class ButtonGrid : Grid
{
	InsertButton insertButton;
	RemoveButton removeButton;
	
	this(MyNotebook myNotebook)
	{
		insertButton = new InsertButton(myNotebook);
		attach(insertButton, 0, 0, 1, 1);
		
		removeButton = new RemoveButton(myNotebook);
		attach(removeButton, 1, 0, 1, 1);
		
	} // this()
	
} // class ButtonGrid


class InsertButton : Button
{
	string _buttonLabel = "Insert Page";
	TabTextView tabTextView;
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
writeln("RemoveButton calling the Notebook's deletePage() function");
		_myNotebook.deletePage();
		
	} // onClicked()
	
} // class RemoveButton


class MyNotebook : Notebook
{
	CSS css;
	PositionType tabPosition = PositionType.TOP;
	int _lastPageNumber = 0;
	
	this()
	{
		css = new CSS(getStyleContext());

		TabTextView tabTextView = new TabTextView();
		Label label = new Label("Tab " ~ _lastPageNumber.to!string());
		appendPage(tabTextView, label);
		setTabReorderable(tabTextView, true);
		
		popupEnable();
		setScrollable(true);
		
		addOnSwitchPage(&onSwitchPage);
		addOnPageRemoved(&onPageRemoved);
		addOnPageReordered(&onPageReordered);
		addOnPageAdded(&onPageAdded);

		addOnMoveFocusOut(&onMoveFocusOut); // key-binding signals //
		addOnChangeCurrentPage(&onChangeCurrentPage);
		addOnReorderTab(&onReorderTab);
		addOnSelectPage(&onSelectPage);
		addOnFocusTab(&onFocusTab);

	} // this()
	
	
	void onSwitchPage(Widget widget, uint pageNumber, Notebook notebook)
	{
		writeln("SIGNAL: onSwitchPage, current page: ", pageNumber);
				
	} // onSwitchPage()


	void onPageRemoved(Widget widget, uint pageNumber, Notebook notebook)
	{
		writeln("page removed: ", pageNumber);
				
	} // onPageRemoved()


	void onPageReordered(Widget widget, uint pageNumber, Notebook notebook)
	{
		writeln("SIGNAL: onPageReordered, current page: ", pageNumber);
		writeln();
		
	} // onPageReordered()
	
	
	void onPageAdded(Widget widget, uint pageNumber, Notebook notebook)
	{
		writeln("SIGNAL: onPageAdded... _lastPageNumber: ", _lastPageNumber);
		writeln("onPageAdded signal... page #", pageNumber, " has been added.");
		writeln();
		
	} // onPageAdded()
	
	
	void onMoveFocusOut(GtkDirectionType directionType, Notebook notebook)
	{
		writeln("SIGNAL: onMoveFocusOut");
		writeln();
		
	} // onMoveFocusOut()
	
	
	bool onChangeCurrentPage(int direction, Notebook notebook)
	{
		write("SIGNAL: onChangeCurrentPage, direction: ");
		
		if(direction is 1)
		{
			writeln("to the right");
		}
		else if(direction is -1)
		{
			writeln("to the left");
		}
		writeln();
		
		return(true);
		
	} // onChangeCurrentPage()
	

	bool onReorderTab(GtkDirectionType directionType, bool yesNo, Notebook notebook)
	{
		writeln("SIGNAL: onReorderTab, the Boolean value: ", yesNo);
		writeln();
		
		return(true);
		
	} // onReorderTab()
	
	
	bool onSelectPage(bool yesNo, Notebook notebook)
	{
		writeln("SIGNAL: onSelectPage, the Boolean value: ", yesNo);
		writeln();
	
		return(true);
		
	} // onSelectPage()
	
	
	bool onFocusTab(NotebookTab tab, Notebook notebook)
	{
		writeln("SIGNAL: onFocusTab, tab: ", tab);
		writeln();
		
		return(true);
		
	} // onFocusTab()


	void addPage()
	{
		_lastPageNumber++; // increase the page count
		TabTextView tabTextView = new TabTextView();
		Label label = new Label("Tab " ~ _lastPageNumber.to!string());
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
