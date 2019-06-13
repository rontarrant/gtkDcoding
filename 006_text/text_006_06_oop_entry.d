// Entry widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRig = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
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
	
} // class testRigWindow


class TextEntry : Entry
{
	string predefinedText;
	
	this(string text)
	{
		predefinedText = text;
		
		super(predefinedText);
		
	} // this()

} // class TextEntry
