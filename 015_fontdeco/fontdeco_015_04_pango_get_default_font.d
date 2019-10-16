// This source code is in the public domain.

// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

// Pango: List System Fonts

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Settings;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;

import singleton.S_FontList;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Pango: List System Fonts";
	AppBox appBox;
	
	this()
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

} // class TestRigWindow


class AppBox : Box
{
	S_FontList s_FontList;
	// add child object definitions here
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		// instantiate child objects here
		import gtk.Label;
		Label label = new Label("my label");
		DefaultFont defaultFont = new DefaultFont(label);
		
		// packStart(<child object>, false, false, 0); // LEFT justify
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox


import gtk.Style;

class DefaultFont
{
	string defaultFontName;
	int defaultFontSize;
	Style style;
	
	this(Widget widget)
	{
		style = widget.getStyle();
		writeln("font: ", style.getFont());
//		defaultFontName = settings.getStyleProperty('gtk-font-name');

//		writeln("default font: ", defaultFontName);
		
	} // this()
	
} // class DefaultFont
