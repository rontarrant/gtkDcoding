// ComboBox with two columns containing strings and integers

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
	DayComboBox dayComboBox;
	DayListStore dayListStore;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		dayListStore = new DayListStore();
		dayComboBox = new DayComboBox(dayListStore);
		packStart(dayComboBox, false, false, 0);
		
	} // this()

} // class AppBox


class DayComboBox : ComboBox
{
	private:
	bool entryOn = false;
	DayListStore _dayListStore;
	CellRendererText cellRendererText;
	int visibleColumn = 1;
	int activeItem = 0;
	
	public:
	this(DayListStore dayListStore)
	{
		super(entryOn);
		
		// set up the ComboBox's column to render text
		cellRendererText = new CellRendererText();
		packStart(cellRendererText, false);
		addAttribute(cellRendererText, "text", visibleColumn);
		
		// set up and bring in the store
		_dayListStore = dayListStore;
		setModel(_dayListStore);
		setActive(activeItem);
		
		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBox cb)
	{
		string day;
		int number;
		TreeIter treeIter;
		
		if(getActiveIter(treeIter)) // bool indicates if retrieval successed or not
		{
			day = getModel().getValueString(treeIter, 0); // get what's in the 0th column
			number = getModel().getValueInt(treeIter, 1);
			
			writeDayOfTheWeek(day, number);
		}
		
	} // doSomething()


	void writeDayOfTheWeek(string day, int number)
	{
		string suffix;
		
		switch(number)
		{
			case 1:
			suffix = "st";
			break;
			
			case 2:
			suffix = "nd";
			break;
			
			case 3:
			suffix = "rd";
			break;
			
			case 4: .. case 7:
			suffix = "th";
			break;
			
			default:
			suffix = "th";
			break;
			
		}

		writeln("The ", number, suffix, " day of the week is ", day, ".");		
		
	} // writeDayOfTheWeek()

} // class DayComboBox


class DayListStore : ListStore
{
	string[] days = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
	int[] lettersInDays = [1, 2, 3, 4, 5, 6, 7];
	
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
