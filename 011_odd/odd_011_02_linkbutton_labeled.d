// LinkButton widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.LinkButton;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow testRig = new TestRigWindow("LinkButton example");
	
	testRig.showAll();
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	LinkButton linkButton;
	
	this(string titleText)
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		linkButton = new LinkButton("http://gtkDcoding.com", "GTK D-coding");
		add(linkButton);
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", linkButton.getUri());
		
	} // endProgram()
	
} // class TestRigWindow
