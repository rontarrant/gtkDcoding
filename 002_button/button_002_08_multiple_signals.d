// connect multiple signals to a single button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow(args);
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string bye = "Bye, bye.";
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// a button that does something
		MyButton myButt = new MyButton(args);
		add(myButt);
	
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(bye);
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class MyButton : Button
{
	string label = "My Butt";
	
	this(string[] args)
	{
		super(label);
		addOnClicked(&clickReport);
		addOnButtonRelease(&takeAction);
		addOnButtonRelease(delegate bool(Event e, Widget w) { showArgs(args); return(true); });
		
	} // this()
	
	
	void clickReport(Button button)
	{
		writeln("Reporting a click.");
		
	} // clickReport()
	
	
	bool takeAction(Event event, Widget widget)
	{
		writeln("Action was taken.");
		
		return(false);
		
	} // takeAction()
	
	
		
	public bool showArgs(string[] buttonArgs)
	{
		foreach(arg; buttonArgs)
		{
			if(arg != buttonArgs[0]) // skip arg 0, it's the name of the program
			{
				writeln("\t", arg);
			}
		}

		return(true); // countermands the 'false' return of the callback definition above
		
	} // buttonAction()

} // class MyButton
