// Description of example

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;
import gtk.TextBuffer;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Textview Shared Buffer";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setSizeRequest(300, 200);
		
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


class AppBox : Box
{
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	ScrolledTextWindow scrolledTextWindow;
	TextView masterTextView;
	DependentTextView dependentTextView;
	TextBuffer sharedTextBuffer;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		scrolledTextWindow = new ScrolledTextWindow();
		packStart(scrolledTextWindow, expand, fill, localPadding); // TOP justify
		
		// grab the TextBuffer pointer
		masterTextView = cast(TextView)scrolledTextWindow.getChild();
		sharedTextBuffer = masterTextView.getBuffer();
		dependentTextView = new DependentTextView(sharedTextBuffer);
		packStart(dependentTextView, expand, fill, localPadding);
		
	} // this()

} // class AppBox


class ScrolledTextWindow : ScrolledWindow
{
	MyTextView myTextView;
	
	this()
	{
		super();
		
		myTextView = new MyTextView();
		add(myTextView);
		
	} // this()
	
} // class ScrolledTextWindow


class MyTextView : TextView
{
	TextBuffer textBuffer;
	string content = "Now is the English of our discontent.";
	
	this()
	{
		super();
		textBuffer = getBuffer();
		textBuffer.setText(content);
		
	} // this()

} // class MyTextView


class DependentTextView : TextView
{
	this(TextBuffer sharedTextBuffer)
	{
		super(sharedTextBuffer);
		
	} // this()
	
} // class DependentTextView
