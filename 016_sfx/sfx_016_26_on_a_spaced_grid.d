// This source code is in the public domain.

// GTK Grid Row & Column Spacing Example

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
	string title = "Grid Row & Column Spacing";
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
	ButtonGrid buttonGrid;
	int globalPadding = 0, localPadding = 0;
	int marginBottom = 10;
		
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		buttonGrid = new ButtonGrid();
		packStart(buttonGrid, false, false, localPadding);
		
		setBorderWidth(10);
//		setMarginBottom(marginBottom);
		
	} // this()

} // class AppBox


class ButtonGrid : Grid
{
	int rowSpacing = 10, columnSpacing = 10;
	Button button1, button2;
	int marginBottom = 10;

	this()
	{
		button1 = new Button("Normal");
		attach(button1, 0, 0, 1, 1);
		
		button2 = new Button("Not so Normal");
		attach(button2, 0, 1, 1, 1);

		setRowSpacing(rowSpacing);
		setColumnSpacing(columnSpacing);
		setMarginBottom(marginBottom);
		
	} // this()

} // class ButtonGrid
