// LinkButton widget

// import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.LinkButton;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "LinkButton example";
	string link = "http://gtkdcoding.com/2019/01/11/0000-introduction-to-gtkDcoding.html";
	string linkText = "GTK D-coding";
//	string message = "The text entry box holds: ";
	LinkButton linkButton;
	
	this()
	{
		super(title);
		addOnDestroy(&endProgram);
		
		linkButton = new LinkButton(link, linkText);
		add(linkButton);
		
		showAll();

	} // this()
	
	
	void endProgram(Widget w)
	{
		//writeln(message, linkButton.getUri());
		
	} // endProgram()
	
} // class TestRigWindow
