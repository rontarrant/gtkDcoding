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

    testRigWindow testRig = new testRigWindow();
    
    Main.run();
    
} // main()


class testRigWindow : MainWindow
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
	
} // testRigWindow


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
	MyRadioMenuItem radioItem01, radioItem02, radioItem03;
	ListSG group;
	
	this()
	{
		super();
		
		// It's okay for 'group' to have no value the first time a RadioMenuItem
		// is created as long as it's declared as a ListSG object.
		radioItem01 = new MyRadioMenuItem(group, "Radio 01");

		radioItem02 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 02");
		radioItem03 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 03");
		
		append(radioItem01);
		append(radioItem02);
		append(radioItem03);
		
	} // this()
	
} // class FileMenu


// The first RadioMenuItem created will have its mode set automatically
class MyRadioMenuItem : RadioMenuItem
{
	string message = "The setting state is: ";
	
	this(ListSG group, string radioLabel)
	{
		super(group, radioLabel);
		addOnToggled(&choose);
		
	} // this()
	
	
	void choose(CheckMenuItem cmi)
	{
		bool radioMenuItemState;
		
		radioMenuItemState = getActive();
		
		if(radioMenuItemState == true)
		{
			writeln(getLabel(), " : active");
			workingCallback();
		}
		else
		{
			writeln(getLabel(), " : inactive. ");
		}
	}

	void workingCallback()
	{
		writeln("Callback called from ", getLabel());
		
	} // workingCallback()
	

} // class MyRadioMenuItem
