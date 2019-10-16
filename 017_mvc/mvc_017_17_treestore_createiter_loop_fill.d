// This source code is in the public domain.

// MVC - a TreeStore example using createIter() in a loop to populate the model

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
	string title = "TreeStore (loop fill)";
	AppBox appBox;
	int minimumWidth, naturalWidth, minimumHeight, naturalHeight;
	
	this()
	{
		super(title);
		setSizeRequest(300, 250);
		
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
	string columnTitle = "Parents";
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
	string[] parentHeaders = ["June & Bill", "Jerry & Sally", "Millicent & Pete"];
	string[][] children = [["George", "Marvin"], ["Blake", "Sam"], ["Jill", "Blair", "Mergatroyd"]];
	int parentColumn = 0, childColumn = 1;
	TreeIter parentIter, childIter;
	 
	this()
	{
		super([GType.STRING, GType.STRING]);

		for(int i = 0; i < parentHeaders.length; i++)
		{
			string parentTitle = parentHeaders[i];
			string[] childFamily = children[i];

			parentIter = createIter(); // append an empty row to the top level and get an iter back
			setValue(parentIter, 0, parentTitle);

			for(int j = 0; j < childFamily.length; j++)
			{
				childIter = createIter(parentIter); // passing in parentIter makes this a child row

				string child = children[i][j];
				setValue(childIter, 1, child);
			
			}
		}
		
	} // this()

} // class FamilyTreeStore
