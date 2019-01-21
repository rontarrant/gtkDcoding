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
	TestRigWindow testRig = new TestRigWindow("Entry example");
	
	testRig.showAll();
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	EntryBox entryBox;
		
	this(string titleText)
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entryBox = new EntryBox();
		add(entryBox);
		
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
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		entry = new Entry();
		entry.setEditable(true);
		
		checkButton = new CheckButton("Visibility");
		checkButton.addOnToggled(&entryVisibility);
		checkButton.setActive(true);
				
		add(entry);
		add(checkButton);
		
	} // this()
	
	
	void entryVisibility(ToggleButton button)
	{
		entry.setVisibility(button.getActive());
		
	} // entryVisibility()

} // class EntryBox
