// This source code is in the public domain.

// MessageDialog

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Box;
import gtk.Window;
import gtk.Button;
import gtk.Dialog;
import gtk.MessageDialog;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	TestBox testBox;
	
	string windowTitle = "MessageDialog demo";
	
	this()
	{
		super(windowTitle);
		setDefaultSize(640, 480);
		
		testBox = new TestBox(this);
		add(testBox);
		
		showAll();
		
	} // this()

} // class: TestRigWindow


class TestBox : Box
{
	int padding = 5;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);
		
		Button button = new MessageButton(parentWindow);
		add(button);
		
	} // this()
	
} // class: TestBox


class MessageButton : Button
{
	private:
	string labelText = "Alert the User";
	
	ClicheMessageDialog messageDialog;
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
		messageDialog = new ClicheMessageDialog(_parentWindow);
		
	} // doSomething()

} // class: MessageButton


class ClicheMessageDialog : MessageDialog
{
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	ButtonsType buttonType = ButtonsType.OK;
	int responseID;
	string messageText = "It was a cliché love triangle,\nIt was heaven on Earth, but with hell to pay.\nA cliché love triangle,\nThey're as common as dirt, or so they say,\nA cliché love triangle,\nHe went off half-cocked and got blown away.";

	
	this(Window _parentWindow)
	{
		super(_parentWindow, flags, messageType, buttonType, messageText);
		setTitle("Alert the User:");
		setSizeRequest(200, 150);
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()

	
	void doSomething(int response, Dialog d)
	{
		writeln("Dialog closed.");
		
	} // doSomething()
	
} // class ClicheMessageDialog
