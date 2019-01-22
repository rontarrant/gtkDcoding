// FontButton widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.FontButton;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow testRig = new TestRigWindow("FontButton example");
	
	testRig.showAll();
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	FontButton fontButton;
	
	this(string titleText)
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		fontButton = new FontButton();
		add(fontButton);
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", fontButton.getFontName());
		
	} // endProgram()
	
} // class TestRigWindow
