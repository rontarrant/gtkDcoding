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
	
	CenterButton centerButton = new CenterButton(myTestRig);
	ToMouseButton toMouseButton = new ToMouseButton(myTestRig);
	
	Box box = new Box(Orientation.VERTICAL, 5);
	
	box.add(toMouseButton);
	box.add(centerButton);
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


interface PositionButton
{
	// Derived buttons will use one of the enum WindowPosition values:
	// 	NONE = No influence is made on placement
	// 	CENTER = Window should be placed in the center of the screen
	// 	MOUSE = Window should be placed at the current mouse position
	// 	CENTER_ALWAYS = Keep window centered as it changes size, etc.
	// 	CENTER_ON_PARENT = Center the window on its transient

	void moveWindow(MainWindow window);
	
} // interface PositionButton


class CenterButton : Button, PositionButton
{
	this(MainWindow window)
	{
		super("Center Window");
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()


	void moveWindow(MainWindow window)
	{
		writeln("Centering the window...");
		window.move(WindowPosition.CENTER);
		
	} // moveWindow()

} // class CenterButton


class ToMouseButton : Button, PositionButton
{
	this(MainWindow window)
	{
		super("Move to Mouse");
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()

	
	void moveWindow(MainWindow window)
	{
		writeln("Moving the window to the mouse position...");
		window.move(45, 60);
		
	} // moveWindow()

} // class ToMouseButton
