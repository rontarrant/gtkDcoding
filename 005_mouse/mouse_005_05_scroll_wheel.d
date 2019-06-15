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
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Scrollwheel Reporting";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse wheel scrolling
		addOnScroll(&onScroll);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		string byeBye = "Bye, bye.";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onScroll(Event event, Widget widget)
	{
		bool value = false; // assume no scrolling
		string upText = "scrolling up...";
		string downText = "scrolling down...";
		
		if(event.scroll.direction == ScrollDirection.DOWN)
		{
			value = true;
			writeln(downText);
		}
		else if(event.scroll.direction == ScrollDirection.UP)
		{
			value = true;
			writeln(upText);
		}

		return(value);

	} // onScroll()

} // class TestRigWindow
