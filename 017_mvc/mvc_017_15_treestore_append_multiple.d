// MVC - a TreeStore example using append() to populate the model

import std.stdio;
import std.string;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ScrolledWindow;
import gtk.TreeView;
import gtk.TreeStore;
import gtk.TreeIter;
import gtk.TreePath;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;
import pango.PgFontDescription;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "MVC TreeStore - Multi-level Family";
	AppBox appBox;
	int minimumWidth, naturalWidth, minimumHeight, naturalHeight;
	
	this()
	{
		super(title);
		setSizeRequest(250, 250);
		
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	int globalPadding = 10;
	int localPadding = 0;
	bool expand = true, fill = true;
	MyScrolledWindow myScrolledWindow;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);

		myScrolledWindow = new MyScrolledWindow();
		packStart(myScrolledWindow, expand, fill, localPadding);
		
	} // this()

} // class AppBox


class MyScrolledWindow : ScrolledWindow
{
	MyTreeView myTreeView;
	
	this()
	{
		myTreeView = new MyTreeView();
		super();
		add(myTreeView);
		
	} // this()
	
} // class MyScrolledWindow


public class MyTreeView : TreeView
{
	FamilyTreeStore familyTreeStore;
	ParentColumn parentColumn;
	ChildColumn childColumn;
	
	this()
	{
		super();

		familyTreeStore = new FamilyTreeStore();
		setModel(familyTreeStore);

		parentColumn = new ParentColumn();
		appendColumn(parentColumn);

		childColumn = new ChildColumn();
		appendColumn(childColumn);
		
	} // this()

} // class MyTreeView


public class ParentColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Parent";
	string attributeType = "text";
	int columnNumber = 0; 
	
	this()
	{
		cellRendererText = new CellRendererText();
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()
	
} // class ParentColumn


public class ChildColumn : TreeViewColumn
{
	private:
	CellRendererText cellRendererText;
	string columnTitle = "Children";
	string attributeType = "text";
	int columnNumber = 1; 
	
	public:
	this()
	{
		cellRendererText = new CellRendererText();
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()
	
} // class ChildColumn

 
class FamilyTreeStore : TreeStore
{
	int parentColumn = 0, childColumn = 1;
	TreeIter parentIter, childIter;
	 
	this()
	{
		super([GType.STRING, GType.STRING]);

		parentIter = append(null); // first header row
		setValue(parentIter, parentColumn, "Mom #1");
		
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #1");
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #2");

		parentIter = append(null); // first header row
		setValue(parentIter, parentColumn, "Dad #1");
		
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #3");
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #4");

		parentIter = append(null); // first header row
		setValue(parentIter, parentColumn, "Mom #2");
		
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #5");
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #6");
		append(childIter, parentIter);
		setValue(childIter, childColumn, "Kid #7");
		
	} // this()
		
} // class FamilyTreeStore
