// Entry widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow testRig = new TestRigWindow("Entry example");
	
	testRig.showAll();
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	Entry entry;
	
	this(string titleText)
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entry = new Entry();
		add(entry);
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", entry.getText());
		
	} // endProgram()
	
} // class TestRigWindow
