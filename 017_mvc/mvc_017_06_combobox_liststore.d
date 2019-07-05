// MVC ComboBox with ListStore - one column containing strings

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
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "MVC ComboBox with ListStore";
	AppBox appBox;
	
	this()
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
	CellRendererText cellRendererText;
	int visibleColumn = 0;
	int activeItem = 0;
	
	public:
	this(SignListStore signListStore)
	{
		super(entryOn);
		
		// set up the ComboBox's column to render text
		cellRendererText = new CellRendererText();
		packStart(cellRendererText, false);
		addAttribute(cellRendererText, "text", visibleColumn);
		
		// set up and bring in the store
		_signListStore = signListStore;
		setModel(_signListStore);
		setActive(activeItem);
		
		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBox cb)
	{
		string data;
		TreeIter treeIter;

		write("index of selection: ", getActive(), ", "); // returns the index of the selected item
		
		if(getActiveIter(treeIter) == true) // bool indicates if retrieval successed or not
		{
			data = getModel().getValueString(treeIter, 0); // get what's in the 1st (and only) column
			writeln("data: ", data);
		}

	} // doSomething()

} // class SignComboBox


class SignListStore : ListStore
{
	string[] items = ["bike", "bump", "cow", "deer", "crumbling cliff", "man with a stop sign", "skidding vehicle"];
	TreeIter treeIter;
	
	this()
	{
		super([GType.STRING]);
		
		for(int i; i < items.length; i++)
		{
			string message = items[i];
			treeIter = createIter();
			setValue(treeIter, 0, message);
		}

	} // this()

} // class SignListStore
