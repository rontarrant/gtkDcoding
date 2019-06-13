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
	
} // class testRigWindow
