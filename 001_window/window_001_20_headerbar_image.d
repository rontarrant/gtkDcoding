// This source code is in the public domain.

// HeaderBar demo with an image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.HeaderBar;
import gtk.Button;
import gdk.Event;
import gtk.Image;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "HeaderBar with Image";
	MyHeaderBar  myHeaderBar;
	AppBox appBox;
	string iconName = "images/road_crew.png";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		myHeaderBar = new MyHeaderBar();
		setTitlebar(myHeaderBar);
		setIconFromFile(iconName);

		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyHeaderBar : HeaderBar
{
	bool decorationsOn = true;
	string title = "HeaderBar Demo";
	string subtitle = "complete with a full array of titlebar buttons";
	HeaderBarButton headerBarButton;
	string imageName = "images/video-64.png";
	Image headerBarImage;
	
	this()
	{
		super();
		setShowCloseButton(decorationsOn); // turns on all buttons: close, max, min
		setDecorationLayout("close,maximize,minimize:icon"); // no spaces between button IDs
		setTitle(title);
		setSubtitle(subtitle);
		
		headerBarImage = new Image(imageName);
		packStart(headerBarImage); // unlike Box.packStart() which takes four arguments

	} // this()
	
} // class MyHeaderBar


class HeaderBarButton : Button
{
	string labelText = "Click Me";
	
	this()
	{
		super(labelText);
		
		addOnClicked(&onClicked);
		
	} // this()
	
	
	void onClicked(Button b)
	{
		writeln("HeaderBar extra button clicked");
		
	} // onClicked()
	
} // class HeaderBarButton


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	// add child object and variable definitions here
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		// instantiate child objects here
		
		// packStart(<child object>, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox
