// This source code is in the public domain.

// Simple Expander example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Expander;
import gtk.Label;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Simple Expander";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	MyExpander expander;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		expander = new MyExpander();
		packStart(expander, expand, fill, localPadding); // LEFT justify
		
	} // this()

} // class AppBox


class MyExpander : Expander
{
	string label = "An Expander";
	bool isMnemonic = false;
	Label childLabel;
	
	this()
	{
		super(label, isMnemonic);
		addOnActivate(&doSomething);
		
		childLabel = new Label("Child of expander");
		add(childLabel);
		
	} // this()
	
	
	void doSomething(Expander expander)
	{
		writeln("Expander was clicked and...");
		
		if(getExpanded == false)
		{
			writeln("Expander is expanded, child revealed.");
		}
		else
		{
			writeln("Expander child is now hidden.");
		}
		
	} // doSomething()
	
} // class MyExpander
