// connect multiple signals to a single button

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow(args);
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string bye = "Bye, bye.";
	MyButton myButton;
	
	this(string[] args)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		myButton = new MyButton(args);
		add(myButton);
	
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(bye);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyButton : Button
{
	string label = "My Button";
	
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
		writeln("onButtonRelease is a Widget signal.");
		
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
			else
			{
				writeln("No arguments were supplied.");
			}
		}

		return(false); // This return values does matter. The delegate definition
							// decides the actual return value. 
		
	} // showArgs()

} // class MyButton
