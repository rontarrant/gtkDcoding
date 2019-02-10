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

	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Image Button Example";
	string byeBye = "Bye bye";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		ImageButton myButt = new ImageButton();     // *** NEW ***
		add(myButt);

		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class ImageButton : Button                                        // *** NEW ***
{
	string imageFilename = "images/apples.jpg";
	string actionMessage = "You have added one (1) apple to your cart.";
		
	this()
	{
		super();
		
		Image oranges = new Image(imageFilename);
		add(oranges);
		
		addOnClicked(&doSomething);
		
	} // this()
	
	
	void doSomething(Button b)
	{
		writeln(actionMessage);
		
	} // doSomething()
	
} // class ImageButton
