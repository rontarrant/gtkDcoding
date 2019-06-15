// Playing with the window's size requirements

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	// give control over to gtkD.
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	int width = 640, height = 480;
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setDefaultSize(width, height);                                                 // *** NEW ***

		ResizeButton button = new ResizeButton(this);
		add(button);

		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ResizeButton : Button                                                     // *** NEW ***
{
	int width = 640, height = 480;
	string buttonText = "Resize Window";
	
	this(MainWindow window)
	{
		super(buttonText);
		addOnClicked(delegate void(Button b) { resizeMe(window); });
		
	} // this()
	
	
	void resizeMe(MainWindow window)
	{
		int x, y;
		int defaultSize = -1;
		
		window.getSize(x, y);
		writeln("x = ", x, ", y = ", y);
		
		// GTK deals in minimum sizes, not absolute sizes, therefore we can set
		// a minimum size for a window, but not a maximum. Also, we can't set
		// a new size smaller than the current size.
		if(x < width)
		{
			window.setSizeRequest(width, height);
		}
		else if(x > (width + 1))
		{
			// The effect here is to set a minimum size and it can't be made smaller
			// after this condition becomes true.
			writeln("Minimum size is now set. You can shrink it, but not below the minimum size.");
			window.setSizeRequest(defaultSize, defaultSize);
		}

	} // resizeMe()

} // class ResizeButton
