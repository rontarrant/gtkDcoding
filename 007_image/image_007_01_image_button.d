// This source code is in the public domain.

// a Button with an Image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Image;                                                 // *** NEW ***

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Image Button Example";
	ImageButton imageButton;
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );

		imageButton = new ImageButton();
		add(imageButton);

		showAll();
		
	} // this()
	
	
	void quitApp()
	{
		string byeBye = "Bye bye";

		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ImageButton : Button
{
	Image appleImage;
	string imageFilename = "images/apples.jpg";
	string actionMessage = "You have added one (1) apple to your cart.";
		
	this()
	{
		super();
		
		appleImage = new Image(imageFilename);
		add(appleImage);
		
		addOnClicked(&doSomething);
		
	} // this()
	
	
	void doSomething(Button b)
	{
		writeln(actionMessage);
		
	} // doSomething()
	
} // class ImageButton
