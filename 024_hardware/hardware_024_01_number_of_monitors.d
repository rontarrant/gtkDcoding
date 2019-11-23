// This source code is in the public domain.

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
	int numberOfMonitors;

	this()
	{
		super(title);

		myDisplay = Display.getDefault();
		numberOfMonitors = myDisplay.getNMonitors();
		monitorReport();

		addOnDestroy(&quitApp);

		showAll();

	} // this()


	void monitorReport()
	{
		writeln("Your set-up has ", numberOfMonitors, " monitors.");

	} // monitorReport()


	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";

		writeln(exitMessage);

		Main.quit();

	} // quitApp()

} // class TestRigWindow
