/*
 Diagram:
 
 TestMenuBar
 	File MenuHeader
 	
 */

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gdk.Event;

void main(string[] args)
{
	TestRig testRig;
	
	Main.init(args);
    
	testRig = new TestRig();
	 
	Main.run();
	
} // main()


class TestRig : MainWindow
{
	TestBox testBox;
	
	string title = "Test Rig: Menu with no items";
	
	this()
	{
		super(title);
		setDefaultSize(640, 480);
		
		testBox = new TestBox();
		add(testBox);
		
		showAll();
		
	} // this()
	
	
} // class TestRig


class TestBox : Box
{
	TestMenuBar menuBar;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		menuBar = new TestMenuBar();
		packStart(menuBar, false, false, 0);
		
	} // this()
	
} // class TestBox


class TestMenuBar : MenuBar
{
	MenuItem fileMenuHeader;
	string fileMenuName = "File";
	
	this()
	{
		fileMenuHeader = new MenuItem(fileMenuName);
		append(fileMenuHeader);
		
	} // this()

} // class TestMenuBar
