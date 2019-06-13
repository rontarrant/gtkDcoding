// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();       // *** NEW ***
		
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow                                  // *** NEW ***
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);

		sayHi(); // *** NEW ***
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)                                    // *** NEW ***
	{                                                              // becomes a class function
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

	void sayHi()
	{
		writeln("Hello GtkD OOP."); // appears in the console, not the GUI
	}

} // class myAppWindow
