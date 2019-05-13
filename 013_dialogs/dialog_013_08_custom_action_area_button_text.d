// Custom Dialog - using a string array for Button names in the Action Area

import std.stdio;

import gtk.MainWindow;
import gtk.Window;
import gtk.Main;
import gtk.Box;
import gtk.Button;
import gtk.Dialog;
import gtk.c.types;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox(this);
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	DialogButton dialogButton;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, 10);
		
		dialogButton = new DialogButton(parentWindow);
		
		packStart(dialogButton, false, false, 0);
		
	} // this()

} // class AppBox


class DialogButton : Button
{
	private:
	string labelText = "Open a Dialog";
	
	ScratchDialog scratchDialog;
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(labelText);
		addOnClicked(&doSomething);
		_parentWindow = parentWindow;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		scratchDialog = new ScratchDialog(_parentWindow);
		
	} // doSomething()

} // class: DialogButton


class ScratchDialog : Dialog
{
	private:
	DialogFlags flags = DialogFlags.MODAL;
	ResponseType[] responseTypes = [ResponseType.YES, ResponseType.NO, ResponseType.ACCEPT];
	
	string[] buttonLabels = ["Yes", "No", "In the Barrel"];
	string titleText = "Do you know where the monkey is?";

	public:
	this(Window _parentWindow)
	{
		super(titleText, _parentWindow, flags, buttonLabels, responseTypes);
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()

	
	private:
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.YES:
				writeln("So, you know where the monkey is.");
			break;
			
			case ResponseType.NO:
				writeln("You don't know where the monkey is.");
			break;
			
			case ResponseType.ACCEPT:
				writeln("That's a bit on the nose, a monkey in a barrel.");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class ScratchDialog
