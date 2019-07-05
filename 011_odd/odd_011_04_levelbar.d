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
	LevelBar levelBar;
	
	this()
	{
		super(title);
		addOnDestroy(&endProgram);
		
		levelBar = new LevelBar();
		levelBar.addOffsetValue("myValue", 0.5);
//		levelBar.setWidth(300);
//		levelBar.setHeight(100);
		
		add(levelBar);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		// writeln("The text entry box holds: ", levelBar.getUri());
		
	} // endProgram()
	
} // class TestRigWindow
