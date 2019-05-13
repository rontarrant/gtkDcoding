// ComboBoxText example #5 - add or remove Entry item from drop-down list

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

} // class TextRigWindow


class AppBox : Box
{
	DayComboBoxText dayComboBoxText;
	AddToComboButton addToComboButton;
	RemoveFromComboButton removeFromComboButton;
	
	this()
	{
		super(Orientation.HORIZONTAL, 10);
		
		dayComboBoxText = new DayComboBoxText();
		packStart(dayComboBoxText, false, false, 0);
		
		addToComboButton = new AddToComboButton(dayComboBoxText);
		packEnd(addToComboButton, false, false, 0);

		removeFromComboButton = new RemoveFromComboButton(dayComboBoxText);
		packEnd(removeFromComboButton, false, false, 0);
		
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

// Because the 'changed' signal fires whether the user is typing or selecting
// from the drop-down list, in order for this to be a useful signal, we have to 
// distinguish between these two events.
// And since we don't have an Event struct to disect, we have to look to other
// data available within the ComboBox object, namely the index. If the index of 
// the active text is -1, it hasn't been added to the list and therefore, we're
// dealing with typing, not selection from the list.

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
		_entry = cast(Entry) _comboBoxText.getChild();
		
		addOnReleased(&doSomething);		
		
	} // this()
	
	
	void doSomething(Button b)
	{
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


class RemoveFromComboButton : Button
{
	private:
	ComboBoxText _comboBoxText;
	Entry _entry;
	string _entryText, buttonText = "Delete";
	
	public:
	this(ComboBoxText comboBoxText)
	{
		super(buttonText);
		
		_comboBoxText = comboBoxText;
		_entry = cast(Entry) _comboBoxText.getChild();
		
		addOnReleased(&doSomething);		
		
	} // this()
	
	
	void doSomething(Button b)
	{
		int activeTextIndex;
		
		_entryText = _entry.getText();
		activeTextIndex = _comboBoxText.getIndex(_entryText);
		
		if(activeTextIndex !is -1)
		{
			_comboBoxText.remove(activeTextIndex);
			writeln(_entryText, " has been removed.");
			_comboBoxText.setActive(0); // if we don't reset the active text, the item remains in the Entry
		}
		else
		{
			writeln("Cannot complete operation. '", _entryText, "' isn't on the list.");
		}
		

	} // doSomething()
	
} // class RemoveFromComboButton
