// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ComboBoxText;
import gtk.Entry; // because we have an Entry in this ComboBoxText
import gtk.Bin; // needed for getChild() to retrieve the Entry and, from there, retrieve its text
import gtk.Button;
import gtk.EditableT;

import gdk.Event; // needed for addOnKeyRelease() and addOnReleased()
import gdk.Keysyms; // needed for detecting which key was pressed
import gobject.ParamSpec;

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

} // class myAppWindow


class AppBox : Box
{
	DayComboBoxText dayComboBoxText;
	RetrieveEntryButton retrieveEntryButton;
	
	this()
	{
		super(Orientation.HORIZONTAL, 10);
		
		dayComboBoxText = new DayComboBoxText();
		packStart(dayComboBoxText, false, false, 0);
		
		retrieveEntryButton = new RetrieveEntryButton(dayComboBoxText);
		packEnd(retrieveEntryButton, false, false, 0);
		
		writeln("Type something into the Entry, then hit the Add button.");
		writeln("You can also hit Enter to echo the contents of the Entry to the terminal, but this action doesn't add the contents to the list.");
	} // this()

} // class AppBox


class DayComboBoxText : ComboBoxText
{
	string[] days = ["yesterday", "today", "tomorrow"];
	bool entryOn = true;
	Entry _entry;
	
	this()
	{
		super(entryOn);
		
		foreach(day; days)
		{
			appendText(day);
		}

		_entry = cast(Entry)getChild();

// Because the 'changed' signal fires whether the user is typing or selecting
// from the drop-down list, we have to distinguish between these two events.
// And since we don't have an Event to disect, we have to look to other data
// available within the ComboBox object, namely the index. If the index of 
// the active text is -1, it hasn't been added to the list and therefore, we're
// dealing with typing, not selection from the list.

		addOnChanged(&onChanged);

	} // this()

	
	void onChanged(ComboBoxText cbt)
	{
		if(getIndex(getActiveText()) !is -1)
		{
			writeln("this is a list item: ", getActiveText());
		}
		else
		{
			writeln("and this isn't: ", getActiveText());
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
		
	} // echoToTerminal()

} // class DayComboBoxText


class RetrieveEntryButton : Button
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
		_comboBoxText.appendText(_entryText);

	} // doSomething()
	
} // class DayEntry
