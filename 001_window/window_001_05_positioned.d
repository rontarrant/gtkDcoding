// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Box;

void main(string[] args)
{
	testRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new testRigWindow();
		
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(300, 400);

		AppBox appBox = new AppBox(this);
		add(appBox);

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class testRigWindow


class AppBox : Box
{
	LeftButton leftButton;
	RightButton rightButton;
	
	this(MainWindow mainWindow)
	{
		super(Orientation.VERTICAL, 5);
		
		leftButton = new LeftButton(mainWindow);
		add(leftButton);

		rightButton = new RightButton(mainWindow);
		add(rightButton);

	}
	
} // class AppBox


interface PositionButton                                                        // *** NOTE ***
{
	void moveWindow(MainWindow window);
	
} // interface PositionButton


class LeftButton : Button, PositionButton
{
	this(MainWindow window)
	{
		super("Left");
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()


	void moveWindow(MainWindow window)
	{
		int x, y;
		window.getPosition(x, y);
		writeln("window position: x = ", x, "y = ", y);
		window.move(x - 40, y - 60);
		
	} // moveWindowLeft()

} // class LeftButton


class RightButton : Button, PositionButton
{
	this(MainWindow window)
	{
		super("Right");
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()

	
	void moveWindow(MainWindow window)
	{
		int x, y;
		window.getPosition(x, y);
		writeln("window position: x = ", x, "y = ", y);
		window.move(x + 40, y + 60);
		
	} // moveWindowRight()

} // class RightButton
