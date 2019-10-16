// This source code is in the public domain.

// OOP Test Rig Base

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye-bye";
	string message = "Hello, GtkD World.";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
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
