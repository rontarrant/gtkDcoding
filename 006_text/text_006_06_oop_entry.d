// Entry widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRig = new TestRigWindow();
	
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
		
		textEntry = new TextEntry("Untitled");
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
	string predefinedText;
	
	this(string text)
	{
		predefinedText = text;
		
		super(predefinedText);
		
	} // this()

} // class TextEntry
