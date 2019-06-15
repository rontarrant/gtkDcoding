// Find number of monitors

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gdk.Display;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Number of Monitors";
	Display myDisplay;
	int monitors;
	
	this()
	{
		super(title);
		
		myDisplay = Display.getDefault();
		monitors = myDisplay.getNMonitors();
		
		addOnDestroy(&quitApp);

		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		monitorReport();
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()


	void monitorReport()
	{
		writeln("Your set-up has ", monitors, " monitors");
		
	} // monitorReport()

} // class TestRigWindow
