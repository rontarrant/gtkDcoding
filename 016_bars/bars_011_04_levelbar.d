// LevelBar

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.LevelBar;
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
	string title = "LevelBar Example";
	StrengthLevelBar strengthLevelBar;
	
	this()
	{
		super(title);
		addOnDestroy(&endProgram);
		
		strengthLevelBar = new StrengthLevelBar();
		add(strengthLevelBar);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		// writeln("The text entry box holds: ", levelBar.getUri());
		
	} // endProgram()
	
} // class TestRigWindow


class StrengthLevelBar : LevelBar
{
	double initialValue = 0.5;
	int width = 200, height = 10;
	
	this()
	{
		// super() is called via constructor chaining and so it's implied
		setWidth(width);
		setHeight(height);
		setValue(initialValue);
		
	} // this()

} // class StrengthLevelBar
