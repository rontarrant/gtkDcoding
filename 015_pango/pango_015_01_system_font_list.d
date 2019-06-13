// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;

import singleton.S_FontList;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AppBox : Box
{
	S_FontList s_FontList;
	// add child object definitions here
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		// instantiate child objects here
		s_FontList = s_FontList.get();
		s_FontList.listFonts();
		
		// packStart(<child object>, false, false, 0); // LEFT justify
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox
