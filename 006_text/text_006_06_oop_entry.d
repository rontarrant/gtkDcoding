// OOP Entry

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Widget;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "Entry example";
	TextEntry textEntry;
	
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		textEntry = new TextEntry();
		add(textEntry);

		showAll();
				
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", textEntry.getText());
		
	} // endProgram()
	
} // class TestRigWindow


class TextEntry : Entry
{
	string predefinedText = "Untitled";
	
	this()
	{
		super(predefinedText);
		
	} // this()

} // class TextEntry
