// Entry widget

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
	
	Entry entry;
	
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entry = new Entry();
		add(entry);

		showAll();
				
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", entry.getText());
		
	} // endProgram()
	
} // class TestRigWindow
