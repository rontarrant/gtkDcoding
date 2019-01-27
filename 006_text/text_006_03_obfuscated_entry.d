// Entry widget
// Notes:
//   may need an observer - rethink, rewrite

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Button;
import gtk.Widget;
import gtk.Box;
import gtk.CheckButton;
import gtk.ToggleButton;                                                        // *** NOTE *** needed for toggle signal

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "Entry Obfuscated";
	
	EntryBox entryBox;
		
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entryBox = new EntryBox();
		add(entryBox);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", entryBox.entry.getText());
		
	} // endProgram()
	
} // class TestRigWindow


class EntryBox : Box
{
	int padding = 5;
	Entry entry;
	CheckButton checkButton;
	string checkText = "Visibility";
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		entry = new Entry();
		entry.setEditable(true);
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&entryVisibility);
		checkButton.setActive(true);
				
		add(entry);
		add(checkButton);
		
	} // this()
	
	
	void entryVisibility(ToggleButton button)
	{
		string messageEnd;
		
		if(button.getActive() == true)
		{
			messageEnd = " that we can see the text.";
		}
		else
		{
			messageEnd = " because we cannot see the text.";
		}

		entry.setVisibility(button.getActive());
		writeln("It's ", button.getActive(), messageEnd);
		
	} // entryVisibility()

} // class EntryBox
