// This source code is in the public domain.

// GTK Buttons Example, one ghosted, the other not ghosted

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Grid;
import gtk.Button;
import gtk.Switch;
import gtk.Label;
import gdk.Event;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Ghosted and Non-ghosted";
	string byeBye = "Bye-bye";
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
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

	
} // class TestRigWindow


class AppBox : Box
{
	Button button1, button2;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		button1 = new Button("Normal");
		packStart(button1, false, false, localPadding);
		
		button2 = new Button("Ghosted");
		packStart(button2, false, false, localPadding);
		button2.setOpacity(0.5);
		setBorderWidth(10);
		
	} // this()

} // class AppBox
