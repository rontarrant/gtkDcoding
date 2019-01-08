// Waiting to see if args are possible with addOnButtonRelease()
import std.stdio;
import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

void main(string[] args)
{
	string title = "Test Rig OOP";
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow(title);
	
	MyButton button = new MyButton("Click this", args);
	myTestRig.add(button);
	
	myTestRig.showAll();
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow

 
class MyButton : Button
{
	this(string label, string[] args)
	{
		super(label);
		//addOnClicked(delegate void(Button b) { buttonAction(message); });
		addOnClicked(delegate void(_) { buttonAction(args); });
		
	} // this()
	
	
	void buttonAction(string[] args)
	{
		foreach(message; args)
		{
			writeln("The message is: ", message);
		}
		
	} // buttonAction()
	
} // class MyButton
