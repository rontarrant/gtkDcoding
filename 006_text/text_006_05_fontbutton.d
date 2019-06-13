// FontButton widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.FontButton;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRig = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
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
		writeln("The selected font face, (weight and style if applicable) and size are: ", fontButton.getFontName());
		
	} // endProgram()
	
} // class testRigWindow
