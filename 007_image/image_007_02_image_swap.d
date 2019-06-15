// switch Button Image each time it's clicked
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
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Switch Images on a Button";
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
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class ImageButton : Button
{
	InnerBox innerBox;
	
	this()
	{
		super();
		
		innerBox = new InnerBox();
		add(innerBox);
		
		addOnButtonRelease(&changeBoth);
		
	} // this()


	bool changeBoth(Event event, Widget widget)
	{
		innerBox.changeBoth();	
		
		return(true);
		
	} // changeBoth()

} // class ImageButton


class InnerBox : Box
{
	int globalPadding = 10;
	SwitchingLabel switchingLabel;
	SwitchingImage switchingImage;

	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		switchingLabel = new SwitchingLabel();
		add(switchingLabel);

		switchingImage = new SwitchingImage();
		add(switchingImage);
		
	} // this()
	
	
	void changeBoth()
	{
		switchingLabel.change();
		switchingImage.change();
		
	} // changeBoth()
	
} // class InnerBox


class SwitchingImage : Image
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
	
} // class SwitchingImage


class SwitchingLabel : Label
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

} // class SwitchingLabel
