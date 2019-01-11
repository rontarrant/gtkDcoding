// switch the button's image each time it's clicked

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gtk.Image;
import gtk.Label;
import gtk.Box;
import gdk.Event;

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	ImageButton myButt = new ImageButton();
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
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class ImageButton : Button                                                      // *** NEW ***
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
		mySwitchingLabel = new SwitchingLabel();                                  // *** NEW ***
		mySwitchingImage = new SwitchingImage();                                  // *** NEW ***
		myBox.add(mySwitchingLabel);
		myBox.add(mySwitchingImage);
		
		// finally, hook it up
		addOnButtonRelease(&switchThings);
		
	} // this()


	bool switchThings(Event event, Widget widget)                                // *** NEW ***
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


class SwitchingImage : Image                                                    // *** NEW ***
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
