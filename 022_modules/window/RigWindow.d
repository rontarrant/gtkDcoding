// This source code is in the public domain.

module RigWindow;

// Dlang imports
import std.stdio;

// gtk, etc. imports
import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

// local imports
import container.AppBox;

class RigWindow : MainWindow
{
	string title = "<Insert Title>";
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

} // class RigWindow
