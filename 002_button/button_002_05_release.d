// use the onButtonRelease signal instead of onClicked

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

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string windowTitle = "Button Release";
	MyButton myButton;
	
	this()
	{
		super(windowTitle);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		myButton = new MyButton();
		add(myButton);
		
		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyButton : Button
{
	string buttonText = "My Butt";
	string actionMessage = "Action was taken.";
	
	this()
	{
		super(buttonText);
		addOnButtonRelease(&takeAction);
		
	} // this()
	
	
	bool takeAction(Event event, Widget widget)
	{
		writeln(actionMessage);
		
		return(false);
		
	} // takeAction()
	
} // class MyButton
