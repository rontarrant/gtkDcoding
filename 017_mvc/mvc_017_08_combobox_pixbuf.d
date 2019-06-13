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
import gtk.CellRendererPixbuf;
import gdk.Pixbuf;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow testRigWindow = new TestRigWindow("Test Rig");

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
	SignListStore signListStore;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		signListStore = new SignListStore();
		signComboBox = new SignComboBox(signListStore);
		packStart(signComboBox, false, false, 0);
		
	} // this()

} // class AppBox


class SignComboBox : ComboBox
{
	private:
	bool entryOn = false;
	SignListStore _signListStore;
	CellRendererPixbuf cellRendererPixbuf;
	int activeItem = 0;
	
	public:
	this(SignListStore signListStore)
	{
		super(entryOn);

		// set up and bring in the store
		_signListStore = signListStore;
		setModel(_signListStore);
		setActive(activeItem);

		cellRendererPixbuf = new CellRendererPixbuf();
		packStart(cellRendererPixbuf, false);
		addAttribute(cellRendererPixbuf, "pixbuf", _signListStore.Column.IMAGE_COLUMN);
		
		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBox cb)
	{
		string sign;
		int number;
		string description;
		TreeIter treeIter;
		
		if(getActiveIter(treeIter)) // bool indicates if retrieval successed or not
		{
			sign = getModel().getValueString(treeIter, _signListStore.Column.THEME_COLUMN); // get what's in the 0th column
			number = getModel().getValueInt(treeIter, _signListStore.Column.NUMBER_COLUMN);
			description = getModel().getValueString(treeIter, _signListStore.Column.DESCRIPTION_COLUMN);
			
			writeDayOfTheWeek(sign, number, description);
		}
		
	} // doSomething()


	void writeDayOfTheWeek(string sign, int number, string description)
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

		writeln("The ", number, suffix, " sign shows a ", sign, " and its warning is: ", description, ".");		
		
	} // writeDayOfTheWeek()

} // class SignComboBox


class SignListStore : ListStore
{
	string[] items = ["bike", "bump", "cow", "deer", "crumbling cliff", "man with a stop sign", "skidding vehicle"];
	int[] signNumbers = [1, 2, 3, 4, 5, 6, 7];
	string[] images = ["_images/bicycle.png",
							 "_images/bump.png", 
							 "_images/cattle.png", 
							 "_images/deer.png", 
							 "_images/falling_rocks.png", 
							 "_images/road_crew.png", 
							 "_images/slippery_road.png"];
	string[] descriptions = ["Bicycles present",
									"Bump ahead",
									"Cattle crossing",
									"Deer crossing",
									"Falling rocks ahead",
									"Road crew ahead",
									"Slippery when wet"];
	enum Column
	{
		THEME_COLUMN = 0,
		NUMBER_COLUMN = 1,
		IMAGE_COLUMN = 2,
		DESCRIPTION_COLUMN = 3
		
	} // enum Column
	
	TreeIter treeIter;
	
	this()
	{
		string item, imageName, description;
		int number;

		super([GType.STRING, GType.INT, Pixbuf.getType(), GType.STRING]);
		
		for(int i; i < items.length; i++)
		{
			item = items[i];
			number = signNumbers[i];
			imageName = images[i];
			description = descriptions[i];
			
			treeIter = createIter();
			setValue(treeIter, Column.THEME_COLUMN, item);
			setValue(treeIter, Column.NUMBER_COLUMN, number);
			setValue(treeIter, Column.IMAGE_COLUMN, new Pixbuf(imageName));
			setValue(treeIter, Column.DESCRIPTION_COLUMN, description);
		}

	} // this()

} // class SignListStore
