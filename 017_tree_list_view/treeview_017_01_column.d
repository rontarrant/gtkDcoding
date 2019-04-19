// Minimal TreeView with one column

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.TreeView;
import gtk.ListStore;
import gtk.TreeIter;
import gtk.TreePath;
import gtk.TreeViewColumn;
import gtk.CellRendererText;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		
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
	SignTreeView signTreeView;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		signTreeView = new SignTreeView();
		packStart(signTreeView, false, false, 0);
		
	} // this()

} // class AppBox


/*
 *A TreeView needs:
 * - at least one column, and
 * - a ListStore or TreeStore to serve as both data model and storage.
 */
class SignTreeView : TreeView
{
	SignTreeViewColumn signTreeViewColumn;	// where the data is displayed
	SignListStore signListStore;				// where the data is stored
	
	this()
	{
		super();
		
		signListStore = new SignListStore();
		setModel(signListStore);
		
		signTreeViewColumn = new SignTreeViewColumn();
		appendColumn(signTreeViewColumn);
		
	} // this()
	
} // class SignTreeView


/*
 * A TreeViewColumn needs:
 * - a string that will become the title,
 * - a CellRenderer (with suffix Accel, Class, Combo, Pixbuf, Progress, Spin, Spinner, Text, or Toggle)
 * - a string describing the attribute type
 * - and a column number (starting from 0)
 */
class SignTreeViewColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Sign Message";
	string attributeType = "text";
	int columnNumber = 0; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()

} // class SignTreeViewColumn


/*
 * A ListStore needs:
 * - an array of GType types (essentially, data types such as string, int, etc.)
 *   so the constructor knows what's being stored, and
 * - a TreeIter for creating rows of data.
 * 
 * Rows are added to the ListStore with the setValue() function which needs:
 * - a TreeIter (could be thought of as the row number, but it's a pointer object)
 * - a column number, and
 * - the data to be stored.
 */
class SignListStore : ListStore
{
	string[] items = ["bikes", "bumps", "deer", "falling rocks", "road crews", "cattle"];
	string warning = "Watch for ";
	TreeIter treeIter;
	
	this()
	{
		super([GType.STRING]);
		
		for(int i; i < items.length; i++)
		{
			string message = warning ~ items[i];
			treeIter = createIter();
			setValue(treeIter, 0, message);
		}

	} // this()

} // class SignListStore
