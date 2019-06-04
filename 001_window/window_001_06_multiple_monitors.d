// multiple monitors

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gdk.Display;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	Display myDisplay;
	int monitors;
	
	this(string title)
	{
		super(title);
		
		myDisplay = Display.getDefault();
		monitors = myDisplay.getNMonitors();
		
		addOnDestroy(&quitApp);

		// Show the window and its contents...
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		monitorReport();
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()


	void monitorReport()
	{
		writeln("Your set-up has ", monitors, " monitors");
		
	} // monitorReport()

} // class myAppWindow
