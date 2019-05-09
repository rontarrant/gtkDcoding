// Entry widget

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
	private:
	string _predefinedText;
	
	public:
	this(string text)
	{
		_predefinedText = text;
		
		super(_predefinedText);
		
		addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(Entry e)
	{
		writeln("the Entry text is: ", getText());
		
	} // doSomething()

} // class TextEntry
