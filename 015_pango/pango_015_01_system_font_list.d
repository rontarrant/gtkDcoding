// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	PgFontMap pgFontMap;
	PgFontFamily[] pgFontFamilies;
	PgFontFamily font;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);

// this becomes part of MVC IX - TreeView with a list of system fonts (may even have font samples)
		pgFontMap = PgCairoFontMap.getDefault();
		pgFontMap.listFamilies(pgFontFamilies);
		
		writeln("A list of all fonts available to Pango on this computer:");

		foreach(font; pgFontFamilies)
		{
			writeln(font.getName());
			
		}
		
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
	// add child object definitions here
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		// instantiate child objects here
		
		// packStart(<child object>, false, false, 0); // LEFT justify
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox
