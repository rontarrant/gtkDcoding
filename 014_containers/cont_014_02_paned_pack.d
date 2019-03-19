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
		UppyDowny myPaned = new UppyDowny();
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


class UppyDowny : Paned
{
	Image child01, child02;
	
	this()
	{
		super(Orientation.VERTICAL);
		
		auto child01 = new Image("images/e_blues_open.jpg"); 
		pack1(child01, true, false);
		
		auto child02 = new Image("images/guitar_bridge_alt.jpg");
		pack2(child02, false, true);
		
		addOnButtonRelease(&showDividerPosition);
		
	} // this()
	
	
	public bool showDividerPosition(Event event, Widget widget)
	{
		writeln("The divider is set to: ", getPosition());
		
		return(true);
		
	} // showDividerPosition()
	
} // class UppyDowny



