// multi-level TreeStore - all in one

import std.stdio;
import std.string;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;

import gtk.TreeStore;
import gtk.TreeIter;
import gtk.TreeView;
import gtk.TreeViewColumn;
import gtk.TreeStore;
import gtk.CellRendererText;
import gtk.ListStore;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "TreeStore (multi-level)";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setDefaultSize(250, 280);

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
	private:
	int globalPadding = 10;
	LocationTreeView locationTreeView;
	bool expand = false, fill = false;
	uint padding = 0;
	
	public:
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		locationTreeView = new LocationTreeView();
		packStart(locationTreeView, expand, fill, padding);
		
	} // this()

} // class AppBox


class LocationTreeView : TreeView
{
	private:
	TreeViewColumn countryColumn, populationColumn;
	LocationTreeStore locationTreeStore;
	
	public:
	this()
	{
		super();
		locationTreeStore = new LocationTreeStore();
		setModel(locationTreeStore);

		// Add Country Column
		countryColumn = new TreeViewColumn("Location", new CellRendererText(), "text", 0);
		appendColumn(countryColumn);
		
		// Add Capital Column
		populationColumn = new TreeViewColumn("Population", new CellRendererText(), "text", 1);
		appendColumn(populationColumn);

	} // this()
	
} // class LocationTreeView


class LocationTreeStore : TreeStore
{
	private:
	TreeIter parentIterAsia, childIterChina, childIterJapan;
	TreeIter parentIterEurope, childIterUK, childIterFrance;
	TreeIter parentIterNorthAmerica, childIterCanada, childIterUSA;
	
	public:
	this()
	{
		super([GType.STRING, GType.STRING]);
		
		parentIterAsia = addLocation("Asia", cast(uint)4_588_227_400);
		childIterJapan = addLocation(parentIterAsia, "Japan", cast(uint)126_826_417);
		addLocation(childIterJapan, "Tokyo", cast(uint)37_435_191);
		childIterChina = addLocation(parentIterAsia, "China", cast(uint)1_420_493_823);
		addLocation(childIterChina, "Beijing", cast(uint)20_035_455);
		
		
		parentIterEurope = addLocation("Europe", cast(uint)743_141_618);
		childIterUK = addLocation(parentIterEurope, "United Kingdom", cast(uint)66_992_200);
		addLocation(childIterUK, "London", cast(uint)9_176_530);
		childIterFrance = addLocation(parentIterEurope, "France", cast(uint)65_502_015);
		addLocation(childIterFrance, "Paris", cast(uint)10_958_187);
		
		
		parentIterNorthAmerica = addLocation("North America", cast(uint)366_496_802);
		childIterCanada = addLocation(parentIterNorthAmerica, "Canada", cast(uint)37_307_925);
		addLocation(childIterCanada, "Ottawa", cast(uint)1_378_151);
		childIterUSA = addLocation(parentIterNorthAmerica, "United States", cast(uint)329_293_776);
		addLocation(childIterUSA, "Washington, DC", cast(uint)713_244);

	} // this()


	// Adds a location and returns the TreeIter of the item added.
	public TreeIter addLocation(in string name, in uint population)
	{
		TreeIter iter = createIter();
		setValue(iter, 0, name);
		setValue(iter, 1, format("%,?d", ',', population));
		
		return(iter);
		
	} // addLocation()
	

	// Adds a child location to the specified parent TreeIter.
	public TreeIter addLocation(TreeIter parent, in string name, in uint population)
	{
		TreeIter childIter = createIter(parent);
		setValue(childIter, 0, name);
		setValue(childIter, 1, format("%,?d", ',', population));
		
		return(childIter);
		
	} // addLocation()
	
} // class LocationTreeStore
