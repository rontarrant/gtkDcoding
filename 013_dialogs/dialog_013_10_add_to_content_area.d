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
import gtk.Box;
import gtk.Label;

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
	string[] buttonLabels = ["Up", "Down", "Sideways"];
	int responseID;
	ResponseType[] responseTypes = [ResponseType.YES, ResponseType.NO];
	string messageText = "";
	string titleText = "Select direction...";
	
	this(Window _parentWindow)
	{
		super();
		customizeContent();
		addButtons(buttonLabels, responseTypes);
		
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()


	void customizeContent()
	{
		// FARM it out to AreaContent class
		contentArea = getContentArea();

		areaContent = new AreaContent(contentArea);
		
		contentArea.showAll();
		
	} // customize()
	
	
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.YES:
				writeln("You picked 'up.'");
			break;
			
			case ResponseType.NO:
				writeln("You picked 'down.'");
			break;
			
			case ResponseType.CLOSE:
				writeln("You picked 'sideways.'");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class ClicheMessageDialog


class AreaContent
{
	Box _contentArea;
	Label authorLabel;
	Entry authorEntry;
	Label titleLabel;
	Entry titleEntry; 
	
	this(Box contentArea)
	{
		_contentArea = contentArea;
		
		authorLabel = new Label();
		authorEntry = new Entry();
		titleLabel = new Label();
		titleEntry = new Entry();
		
		
		
	} // this()
	
} // class AreaContent
