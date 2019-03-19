// paned window example

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Image;
import gtk.Paned;
import gtk.Widget;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye-bye";
	string message = "Hello GtkD World!";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		// add things to the window
		SideBySide myPaned = new SideBySide();
		add(myPaned);
		
		showAll();
		
		greeting();
		
	} // this()
	
	
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()
	
	
	void greeting()
	{
		writeln(message);
		
	} // greeting()
	
} // class TestRigWindow


class SideBySide : Paned
{
	Image child01, child02;
	
	this()
	{
		super(Orientation.HORIZONTAL);
		
		auto child01 = new Image("images/e_blues_open.jpg"); 
		add1(child01);
		
		auto child02 = new Image("images/guitar_bridge.jpg");
		add2(child02);
		
		addOnButtonRelease(&showDividerPosition);
		
	} // this()
	
	
	public bool showDividerPosition(Event event, Widget widget)
	{
		writeln("The divider is set to: ", getPosition());
		
		return(true);
		
	} // showDividerPosition()
	
} // class SideBySide



