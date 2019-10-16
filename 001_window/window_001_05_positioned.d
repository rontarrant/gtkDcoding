// This source code is in the public domain.

// Position a window programmatically

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Box;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
		
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	int width = 300, height = 400;
	string title = "Positioned Window";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(width, height);

		AppBox appBox = new AppBox(this);
		add(appBox);

		showAll();

	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	int globalPadding = 5;
	LeftButton leftButton;
	RightButton rightButton;
	
	this(MainWindow mainWindow)
	{
		super(Orientation.VERTICAL, globalPadding);
		
		leftButton = new LeftButton(mainWindow);
		add(leftButton);

		rightButton = new RightButton(mainWindow);
		add(rightButton);

	} // this()
	
} // class AppBox


interface PositionButton                                                        // *** NOTE ***
{
	void moveWindow(MainWindow window);
	
} // interface PositionButton


class LeftButton : Button, PositionButton
{
	string buttonText = "Left";
	
	this(MainWindow window)
	{
		super(buttonText);
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()


	void moveWindow(MainWindow window)
	{
		int x, y;
		int xDistance = 40, yDistance = 60;
		
		window.getPosition(x, y);
		writeln("window position: x = ", x, "y = ", y);
		window.move(x - xDistance, y - yDistance);
		
	} // moveWindow()

} // class LeftButton


class RightButton : Button, PositionButton
{
	string buttonText = "Right";
	
	this(MainWindow window)
	{
		super(buttonText);
		addOnClicked(delegate void(Button b) { moveWindow(window); });
		
	} // this()

	
	void moveWindow(MainWindow window)
	{
		int x, y;
		int xDistance = 40, yDistance = 60;
		
		window.getPosition(x, y);
		writeln("window position: x = ", x, "y = ", y);
		window.move(x + xDistance, y + yDistance);
		
	} // moveWindow()

} // class RightButton
