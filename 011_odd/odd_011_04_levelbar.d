// LevelBar widget

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.LevelBar;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	testRigWindow testRig = new testRigWindow("LevelBar example");
	
	testRig.showAll();
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	LevelBar levelBar;
	
	this(string titleText)
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		levelBar = new LevelBar();
		levelBar.addOffsetValue("myValue", 0.5);
//		levelBar.setWidth(300);
//		levelBar.setHeight(100);
		
		add(levelBar);
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		// writeln("The text entry box holds: ", levelBar.getUri());
		
	} // endProgram()
	
} // class testRigWindow
