// This source code is in the public domain.

// retrieving text from an Entry

import std.stdio;
// GTK
import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Widget;
// GDK
import gdk.Event;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "Retrieve Text from Entry";
	
	TextEntry textEntry;
	
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		textEntry = new TextEntry();
		add(textEntry);

		writeln("Type something in the Entry, then hit the Enter key.");
		
		showAll();
				
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", textEntry.getText());
		
	} // endProgram()
	
} // class TestRigWindow


class TextEntry : Entry
{
	private:
	string predefinedText = "Untitled";
	
	public:
	this()
	{
		super(predefinedText);
		
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(Entry e)
	{
		writeln("the Entry text is: ", getText());
		
	} // doSomething()

} // class TextEntry
