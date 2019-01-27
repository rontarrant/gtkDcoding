// FontButton widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.FontButton;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "FontButton example";
	
	FontButton fontButton;
	
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		fontButton = new FontButton();
		add(fontButton);

		showAll();
				
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", fontButton.getFontName());
		
	} // endProgram()
	
} // class TestRigWindow
