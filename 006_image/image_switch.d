// Just a button with an image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gtk.Button;
import gtk.Image;
import gtk.Label;
import gtk.Box;
import gdk.Event;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	/////////////////////
	// Test Code Start //
	/////////////////////

	ImageButton myButt = new ImageButton();
	myTestRig.add(myButt);
	
	////////////////////////////////
	// Test Code End (more below) //
	////////////////////////////////
	
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

/////////////////////
// Test Code Start //
/////////////////////

class ImageButton : Button
{
	Box myBox;
	SwitchingLabel mySwitchingLabel;
	SwitchingImage mySwitchingImage;
	
	this()
	{
		super();
		
		// add a multi-widget container
		myBox = new Box(Orientation.VERTICAL, 10); // orientation, padding
		add(myBox);
		
		// and fill it
		mySwitchingLabel = new SwitchingLabel();
		mySwitchingImage = new SwitchingImage();
		myBox.add(mySwitchingLabel);
		myBox.add(mySwitchingImage);
		
		// finally, hook it up
		addOnButtonRelease(&switchThings);
		
	} // this()


	bool switchThings(Event event, Widget widget)
	{
		if(mySwitchingLabel.getText() == "Apples")
		{
			mySwitchingLabel.setText("Oranges");
			mySwitchingImage.setFromFile("images/oranges.jpg");

			//box.image.
		}
		else
		{
			mySwitchingLabel.setText("Apples");
			mySwitchingImage.setFromFile("images/apples.jpg");
		}
		//add(image);
	
		
		return(true);
		
	} // switchThings()

} // class ImageButton


class SwitchingImage : Image
{
	this()
	{
		super("images/apples.jpg");	
	}
	
} // class SwitchingImage


class SwitchingLabel : Label
{
	this()
	{
		super("Apples");
		
	} // this()

} // class SwitchingLabel

///////////////////
// Test Code End //
///////////////////
