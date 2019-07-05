// LinkButton without Text

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.LinkButton;
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
	string title = "LinkButton without Text";
	string link = "http://gtkDcoding.com";
	string message = "The text entry box holds: ";
	LinkButton linkButton;
	
	this()
	{
		super(title);
		addOnDestroy(&endProgram);
		
		linkButton = new LinkButton(link);
		add(linkButton);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln(message, linkButton.getUri());
		
	} // endProgram()
	
} // class TestRigWindow
