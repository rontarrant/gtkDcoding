// This source code is in the public domain.

// report all available monitors on a computer

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

import gdk.Device;
import gdk.Display;
import gdk.Seat;
import gdk.Window;
import gtk.Button;
import gdk.Rectangle;
import gdk.MonitorG;
import gdk.Screen;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	// Show the window and its contents...
	myTestRig.showAll();
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	Seat seat;
	Display myDisplay;
	int numberOfMonitors;
	Device keyboard, pointer;
	GdkRectangle rectangle;
	MonitorG monitorG;
	Screen screen;
	ReportButton reportButton;
	
	this(string title)
	{
		super(title);

		screen = Screen.getDefault();
		writeln("screen width: ", screen.width(), ", height: ", screen.height());
		
		myDisplay = Display.getDefault();
		seat = myDisplay.getDefaultSeat();
		monitorReport();

		reportButton = new ReportButton(myDisplay, monitorG);
		add(reportButton);
		
		
		addOnDestroy(&quitApp);
		
	} // this() CONSTRUCTOR
	
		
	void monitorReport()
	{
		numberOfMonitors = myDisplay.getNMonitors();

		writeln("Your set-up has ", numberOfMonitors, " monitors...\n\n");
		
		if(numberOfMonitors > 1)
		{
			for(int i; i < numberOfMonitors; i++)
			{
				monitorG = myDisplay.getMonitor(i);
				monitorG.getGeometry(rectangle);
				
				writeln("monitor #", i);
				writeln("monitor position within the display area - x = ", rectangle.x, ", y = ", rectangle.y);
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
		writeln("Bye.");
		Main.quit();

	} // quitApp()

} // class myAppWindow


class ReportButton : Button
{
	string labelText = "Report Window Location";
	Display _myDisplay;
	MonitorG _monitorG;
	
	this(Display myDisplay, MonitorG monitorG)
	{
		_myDisplay = myDisplay;
		_monitorG = monitorG;
		
		super(labelText);
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button button0)
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
