// Minimal TreeView with one column

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ComboBox;
import gtk.ListStore;
import gtk.TreeIter;
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
	SignComboBox signComboBox;
	DayListStore dayListStore;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		dayListStore = new DayListStore();
		signComboBox = new SignComboBox(dayListStore);
		packStart(signComboBox, false, false, 0);
		
	} // this()

} // class AppBox


class SignComboBox : ComboBox
{
	private:
	bool entryOn = false;
	DayListStore _dayListStore;
	CellRendererText cellRendererText;
	
	public:
	this(DayListStore dayListStore)
	{
		super(entryOn);
		
		// set up the ComboBox's column to render text
		cellRendererText = new CellRendererText();
		packStart(cellRendererText, false);
		addAttribute(cellRendererText, "text", 0); // column = 0
		
		// set up and bring in the store
		_dayListStore = dayListStore;
		setModel(_dayListStore);
		
		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBox cb)
	{
		string day;
		int number;
		TreeIter treeIter;
		
		writeln(getActive()); // returns the index of the selected item
		getActiveIter(treeIter); // bool indicates if retrieval successed or not
		day = getModel().getValueString(treeIter, 0); // get what's in the 1st (and only) column
		number = getModel().getValueInt(treeIter, 1);
		writeln("day: ", day, "number: ", number);

	} // doSomething()

} // class SignComboBox


class DayListStore : ListStore
{
	string[] days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	int[] lettersInDays = [6, 6, 7, 9, 8, 6, 8];
	
	TreeIter treeIter;
	
	this()
	{
		string day;
		int number;
		
		super([GType.STRING, GType.INT]);
		
		for(int i; i < days.length; i++)
		{
			day = days[i];
			number = lettersInDays[i];
			
			treeIter = createIter();
			setValue(treeIter, 0, day);
			setValue(treeIter, 1, number);
		}

	} // this()

} // class DayListStore
