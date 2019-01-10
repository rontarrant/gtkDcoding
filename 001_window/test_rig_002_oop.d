// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");       // *** NEW ***
	
	myTestRig.sayHi(); // *** NEW ***
	
	// Show the window and its contents...
	myTestRig.showAll();
	
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow                                  // *** NEW ***
{
	this(string title)
	{
		super(title);
		
		addOnDestroy(&quitApp);
		
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
