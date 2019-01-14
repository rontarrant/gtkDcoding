// Just a button with an image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Image;                                                 // *** NEW ***

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	ImageButton myButt = new ImageButton("images/apples.jpg");     // *** NEW ***
	myTestRig.add(myButt);
	
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
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class ImageButton : Button                                        // *** NEW ***
{
	this(string imageName)
	{
		super();
		
		Image oranges = new Image(imageName);
		add(oranges);
		
		addOnClicked(&doSomething);
		
	} // this()
	
	
	void doSomething(Button b)
	{
		writeln("You have added one (1) orange to your cart.");
		
	} // doSomething()
	
} // class ImageButton
