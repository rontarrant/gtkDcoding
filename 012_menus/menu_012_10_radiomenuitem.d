import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.RadioMenuItem;
import gtk.CheckMenuItem;
import gtk.Widget;
import gdk.Event;
import glib.ListSG;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "RadioMenuItems Example";

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		AppBox appBox = new AppBox();
		add(appBox);

		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other exit stuff here if necessary
		// like call an external function
		
		Main.quit();
		
	} // quitApp()
	
} // TestRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	
	this()
	{
		super(Orientation.VERTICAL, padding);

		menuBar = new MyMenuBar();
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	FileMenuHeader fileMenuHeader;
	
	this()
	{
		super();
		
		fileMenuHeader = new FileMenuHeader();
		append(fileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string headerTitle = "File";
	FileMenu fileMenu;
	
	this()
	{
		super(headerTitle);
		
		fileMenu = new FileMenu();
		setSubmenu(fileMenu);
		
	} // this()
	
} // class FileMenu


class FileMenu : Menu
{
	Observed observed;
	MyRadioMenuItem radioItem01, radioItem02, radioItem03;
	ListSG group;
	
	this()
	{
		super();
		
		observed = new Observed(null);
		
		// The variable 'group' can have no value the first time a RadioMenuItem is created
		// as long as it's declared as a ListSG object.
		radioItem01 = new MyRadioMenuItem(group, "Radio 01", observed);

		radioItem02 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 02", observed);
		radioItem03 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 03", observed);
		
		append(radioItem01);
		append(radioItem02);
		append(radioItem03);
		
	} // this()
	
	
} // class FileMenu


// The first RadioMenuItem created will have its mode set automatically?
class MyRadioMenuItem : RadioMenuItem
{
	string message = "The setting state is: ";
	
	Observed observed;
	
	this(ListSG group, string radioLabel, Observed extObserved)
	{
		super(group, radioLabel);
writeln("Got this far 3.");
//		setLabel(radioLabel);
		addOnToggled(&onToggle);
		
		observed = extObserved;
		
	} // this()
	
	
	void onToggle(CheckMenuItem rmi) // 
	{
		observed.setState(getLabel());
		writeln("The setting state is: ", observed.getState());
		
	} // exit()
	
} // class MyCheckMenuItem


class Observed
{
	private:
	string observedState;
	
	this(string extState)
	{
		setState(extState);
		
	} // this()
	
// end private
	
	public:
	
	void setState(string extState)
	{
		observedState = extState;

	} // toggleState()


	string getState()
	{
		return(observedState);
		
	} // getState()

} // class Observed
