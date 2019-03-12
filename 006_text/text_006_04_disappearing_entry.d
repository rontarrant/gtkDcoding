// Entry widget

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
	string titleText = "Disappearing Entry";
	
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
	Entry entry;
	CheckButton checkButton;

	int padding = 5;
	string checkText = "Visible";
	
	this()
	{
		super(Orientation.VERTICAL, padding);
		
		entry = new Entry();
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&entryVisible);
		checkButton.setActive(true);
				
		add(entry);
		add(checkButton);
		
	} // this()
	
	
	void entryVisible(ToggleButton button)
	{
		string[] state = ["invisible", "visible"];
		
		entry.setVisible(button.getActive());
		writeln("The Entry field is now ", state[button.getActive()]);
		
	} // entryVisible()

} // class EntryBox
