// Test Rig Foundation for Learning GtkD Coding

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

} // class myAppWindow


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
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	StockID[] stockIDs = [StockID.CONNECT, StockID.DISCONNECT];
	int responseID;
	ResponseType[] responseTypes = [ResponseType.YES, ResponseType.NO];
	string messageText = "";
	string titleText = "Do you know where the monkey is?";

	
	this(Window _parentWindow)
	{
		super(titleText, _parentWindow, flags, stockIDs, responseTypes);
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()

	
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.YES:
				writeln("Connecting...");
			break;
			
			case ResponseType.NO:
				writeln("Disconnecting...");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class ClicheMessageDialog
