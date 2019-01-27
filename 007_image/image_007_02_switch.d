// switch the button's image each time it's clicked
// a study in propagation/fall-through

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

	TestRigWindow myTestRig = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		ImageButton myButt = new ImageButton();
		add(myButt);

		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class ImageButton : Button                                                      // *** NEW ***
{
	InnerBox innerBox;
	
	this()
	{
		super();
		
		innerBox = new InnerBox(); // orientation, padding
		add(innerBox);
		
		addOnButtonRelease(&changeBoth);
		
	} // this()


	bool changeBoth(Event event, Widget widget)                                // *** NEW ***
	{
		innerBox.changeBoth();	
		
		return(true);
		
	} // changeBoth()

} // class ImageButton


class InnerBox : Box
{
	SwitchLabel switchLabel;
	SwitchImage switchImage;

	this()
	{
		super(Orientation.VERTICAL, 10);
		switchLabel = new SwitchLabel();                                  // *** NEW ***
		add(switchLabel);

		switchImage = new SwitchImage();                                  // *** NEW ***
		add(switchImage);
		
	} // this()
	
	
	void changeBoth()
	{
		switchLabel.change();
		switchImage.change();
		
	} // changeBoth()
	
} // class InnerBox


class SwitchImage : Image                                                    // *** NEW ***
{
	string apples = "images/apples.jpg";
	string oranges = "images/oranges.jpg";
	string current;
	
	this()
	{
		super();
		current = apples;
		setFromFile(current);	
	}
	
	void change()
	{
		if(current == apples)
		{
			current = oranges;
		}
		else
		{
			current = apples;
		}

		setFromFile(current);
		
	} // change()
	
} // class SwitchImage


class SwitchLabel : Label
{
	string apples = "Apples";
	string oranges = "Oranges";
	string current;
	
	this()
	{
		current = apples;
		super(apples);
		
	} // this()
	
	
	void change()
	{
		if(current == apples)
		{
			current = oranges;
		}
		else
		{
			current = apples;
		}

		setText(current);
		
	} // change()

} // class SwitchLabel
