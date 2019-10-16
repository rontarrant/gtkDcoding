// This source code is in the public domain.

// hook two signals to a single button so it tells us which signal is being processed

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

// Note: EventType flags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Which Signal?";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the window sensitive to mouse clicking (any button)
		addOnEnterNotify(&onEvent);
		addOnLeaveNotify(&onEvent);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		string byeBye = "Bye, bye.";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onEvent(Event event, Widget widget)
	{
		string messageStart = "We've experienced ";
		string article;
		
		// make the articles match the nouns
		if(event.type() == EventType.ENTER_NOTIFY)
		{
			article = "an ";
		}
		else
		{
			article = "a ";
		}
		
		writeln(messageStart, article, event.type(), " event.");

		return(false);
		
	} // onEvent()

} // class TestRigWindow
