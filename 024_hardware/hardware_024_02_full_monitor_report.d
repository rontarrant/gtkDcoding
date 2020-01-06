// This source code is in the public domain.

// report all available monitors on a computer

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;

import gdk.Display;
import gdk.Device;
import gdk.Seat;
import gdk.Window;
import gdk.Rectangle;
import gdk.MonitorG;
import gdk.Screen;

void main(string[] args)
{
	TestRigWindow testRigWindow;

	Main.init(args);

	testRigWindow = new TestRigWindow();

	Main.run();

} // main()


class TestRigWindow : MainWindow
{
	string title = "Monitor Report";
	Display myDisplay;
	Screen screen;
	ReportButton reportButton;

	this()
	{
		super(title);

		myDisplay = Display.getDefault();
		monitorReport();

		screen = Screen.getDefault();
		writeln("screen width: ", screen.width(), ", height: ", screen.height());

		reportButton = new ReportButton(myDisplay);
		add(reportButton);

		addOnDestroy(&quitApp);

		showAll();

	} // this()


	void monitorReport()
	{
		MonitorG monitorG;
		GdkRectangle rectangle;
		int numberOfMonitors = myDisplay.getNMonitors();

		writeln("Your set-up has ", numberOfMonitors, " monitors...\n\n");

		if(numberOfMonitors > 1)
		{
			for(int i; i < numberOfMonitors; i++)
			{
				monitorG = myDisplay.getMonitor(i);
				monitorG.getGeometry(rectangle);

				writeln("monitor #", i);
				writeln("monitor position within the screen area - x = ", rectangle.x, ", y = ", rectangle.y);
				writeln("monitor size: width = ", rectangle.width, ", height = ", rectangle.height);
				writeln("manufacturer: ", monitorG.getManufacturer());
				write("monitor model: ", monitorG.getModel());

				if(monitorG.isPrimary())
				{
					write(" and it's your primary display.");
				}

				writeln();
				writeln();
			}
		}
		else
		{
			monitorG = myDisplay.getMonitor(0);

			writeln("You have a single monitor");
			writeln("monitor position within the display - x = ", rectangle.x, ", y = ", rectangle.y);
			writeln("monitor size: width = ", rectangle.width, ", height = ", rectangle.height);
			writeln("manufacturer: ", monitorG.getManufacturer());
			write("monitor model: ", monitorG.getModel());

			writeln(" and it's your only display.");
		}

	} // monitorReport()


	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";

		writeln(exitMessage);
		Main.quit();

	} // quitApp()

} // class TestRigWindow


class ReportButton : Button
{
	string labelText = "Report Window Location";
	Display _myDisplay;
	MonitorG _monitorG;

	this(Display myDisplay)
	{
		super(labelText);
		setSizeRequest(250, 30);

		addOnClicked(&onClicked);

		_myDisplay = myDisplay;

	} // this()


	void onClicked(Button b)
	{
		MonitorG monitorG4Window;
		monitorG4Window = _myDisplay.getMonitorAtWindow(this.getWindow());

		int numberOfMonitors = _myDisplay.getNMonitors();

		for(int i; i < numberOfMonitors; i++)
		{
			_monitorG = _myDisplay.getMonitor(i);

			if(_monitorG is monitorG4Window)
			{
				writeln("The current window is on monitor #", i);
			}
		}

	} // onClicked()

} // class ReportButton
