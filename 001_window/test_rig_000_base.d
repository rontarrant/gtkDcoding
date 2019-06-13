// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
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
		
	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()


	void greeting()
	{
		writeln(message);
		
	} // greeting()
	
} // class testRigWindow
