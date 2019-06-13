// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
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

} // class testRigWindow


class AppBox : Box
{
	// add child object definitions here
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		// instantiate child objects here
		
		// packStart(<child object>, false, false, 0); // LEFT justify
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox


