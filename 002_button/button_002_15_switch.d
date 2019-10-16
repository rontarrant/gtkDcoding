// This source code is in the public domain.

// GTK Switch Example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Switch;
import gtk.Label;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Switch Example";
	string byeBye = "Bye-bye";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();
		
	} // this()
		
		
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

	
} // class TestRigWindow


class AppBox : Box
{
	MySwitch mySwitch;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.HORIZONTAL, globalPadding);
		
		mySwitch = new MySwitch();
		packStart(mySwitch, false, false, localPadding);

	} // this()

} // class AppBox


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
