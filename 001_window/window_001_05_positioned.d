// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Box;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	LeftButton leftButton = new LeftButton(myTestRig);
	RightButton rightButton = new RightButton(myTestRig);
	
	Box box = new Box(Orientation.VERTICAL, 5);
	
	box.add(leftButton);
	box.add(rightButton);
	myTestRig.add(box);
	
	// Show the window and its contents...
	myTestRig.showAll();
	
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		setSizeRequest(300, 400);

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


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
