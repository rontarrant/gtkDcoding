// ComboBoxText example #4 - add Entry item to drop-down list

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ComboBoxText;
import gtk.Entry; // because we have an Entry in this ComboBoxText
import gtk.Bin; // needed for getChild() to retrieve the Entry and, from there, retrieve its text
import gtk.Button;

import gdk.Event; // needed for addOnKeyRelease() and addOnReleased()
import gdk.Keysyms; // needed for detecting which key was pressed

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
		
		appBox = new AppBox();
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
	DayComboBoxText dayComboBoxText;
	AddToComboButton addToComboButton;
	
	this()
	{
		super(Orientation.HORIZONTAL, 10);
		
		dayComboBoxText = new DayComboBoxText();
		packStart(dayComboBoxText, false, false, 0);
		
		addToComboButton = new AddToComboButton(dayComboBoxText);
		packEnd(addToComboButton, false, false, 0);
		
		writeln("Type something into the Entry, then hit the Add button.");
		writeln("You can also hit Enter to echo the contents of the Entry to the terminal, but this action doesn't add the contents to the list.");

	} // this()

} // class AppBox


class DayComboBoxText : ComboBoxText
{
	private:
	string[] days = ["yesterday", "today", "tomorrow"];
	bool entryOn = true;
	Entry _entry;
	
	public:
	this()
	{
		super(entryOn);
		
		foreach(day; days)
		{
			appendText(day);
		}

		_entry = cast(Entry)getChild();


		addOnChanged(&onChanged);
		addOnKeyRelease(&onKeyRelease);

	} // this()

	
	void onChanged(ComboBoxText cbt)
	{
		if(getIndex(getActiveText()) !is -1)
		{
			writeln("this is a list item: ", getActiveText());
		}
		
	} // onChanged()
	

	bool onKeyRelease(Event event, Widget w)
	{
		bool stopHereFlag = true;
		
		if(event.type == EventType.KEY_RELEASE)
		{
			GdkEventKey* keyEvent = event.key;
			
			if(keyEvent.keyval == GdkKeysyms.GDK_Return)
			{
				writeln("onKeyRelease: ", getActiveText());			
			}
		}

		return(stopHereFlag);
		
	} // onKeyRelease()

} // class DayComboBoxText


class AddToComboButton : Button
{
	private:
	ComboBoxText _comboBoxText;
	Entry _entry;
	string _entryText, buttonText = "Add";
	
	public:
	this(ComboBoxText comboBoxText)
	{
		super(buttonText);
		
		_comboBoxText = comboBoxText;

		addOnReleased(&doSomething);		
		
	} // this()
	
	
	void doSomething(Button b)
	{
		_entry = cast(Entry) _comboBoxText.getChild();
		_entryText = _entry.getText();
		
		if(_comboBoxText.getIndex(_entryText) is -1)
		{
			_comboBoxText.appendText(_entryText);
			writeln(_entryText, " is now on the list.");
		}
		else
		{
			writeln(_entryText, " is already on the list.");
		}
		

	} // doSomething()
	
} // class AddToComboButton
