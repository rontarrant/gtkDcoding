// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Switch;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Switch Example";
	string byeBye = "Bye-bye";
	MySwitch lightSwitch;

	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		lightSwitch = new MySwitch();
		add(lightSwitch);
		
		showAll();
		
	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()


	
} // class myAppWindow


class MySwitch : Switch
{
	
	this()
	{
		super();
		addOnStateSet(&onStateSet);
		
	} // this()


	bool onStateSet(bool state, Switch s)
	{
		setState(state);
		writeln("State set is: ", getState(), " and state is: ", state);
		
		return(true);
		
	} // onStateSet()
	
} // class MySwitch
