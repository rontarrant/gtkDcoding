// report what's happening with the mouse's scroll wheel

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;
import gtk.c.types;

// Note: ScrollDirection flags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	string byeBye = "Bye, bye.";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse wheel scrolling
		addOnScroll(&onScroll);                                                   // *** NEW ***
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR


	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onScroll(Event event, Widget widget)                             // *** NEW ***
	{
		bool value = false; // assume no scrolling
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			value = true;
			writeln("scrolling down...");
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			value = true;
			writeln("scrolling up...");
		}

		return(value);

	} // onScroll()

} // class TestRigWindow
