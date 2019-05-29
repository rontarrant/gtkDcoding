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

		// despite being hooked up first, the onClicked signal will fire last
		addOnClicked(&onClicked);
		addOnPressed(&onPressed);
		addOnReleased(&onReleased);
		addOnButtonRelease(&onButtonRelease);
		
		// needs to be defined as returning 'false' or the onClicked signal won't fire
		addOnButtonRelease(delegate bool(Event e, Widget w) { showArgs(args); return(false); });
				
	} // this()
	
	
	void onClicked(Button button)
	{
		writeln("Reporting a click.");
		
	} // onClicked()
	
	
	void onPressed(Button button)
	{
		writeln("A mouse button was pressed.");
		
	} // onPressed()
	
	
	void onReleased(Button button)
	{
		writeln("A mouse button was released.");
		
	} // onReleased()
	
	
	bool onButtonRelease(Event event, Widget widget)
	{
		writeln("Action was taken.");
		
		return(false);
		
	} // onButtonRelease()
	
	
		
	public bool showArgs(string[] buttonArgs)
	{
		foreach(arg; buttonArgs)
		{
			if(arg != buttonArgs[0]) // skip arg 0, it's the name of the program
			{
				writeln("\t", arg);
			}
		}

		return(true); // needs to be false or the onClicked() callback won't fire
		
	} // showArgs()

} // class MyButton
