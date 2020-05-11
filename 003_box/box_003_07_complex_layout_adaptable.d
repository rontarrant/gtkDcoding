// This source code is in the public domain.

// Demonstrates a layout that adapts to the Window size.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;
import gtk.TextBuffer;
import gtk.Button;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	private:
	string title = "Adaptable Layout";
	AppBox appBox;
	
	public:
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setSizeRequest(300, 200);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
	private:
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	private:
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	TopBox topBox;
	MiddleBox middleBox;
	BottomBox bottomBox;
	
	public:
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		topBox = new TopBox();
		middleBox = new MiddleBox();
		bottomBox = new BottomBox();
		
		packStart(topBox, expand, fill, localPadding); // TOP justify
		packStart(middleBox, expand, fill, localPadding); // TOP justify
		packStart(bottomBox, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class AppBox


class BottomBox : VerticalBox
{
	private:
	TopButtonBox topButtonBox;
	MiddleButtonBox middleButtonBox;
	BottomButtonBox bottomButtonBox;
	
	public:
	this()
	{
		
		topButtonBox = new TopButtonBox();
		middleButtonBox = new MiddleButtonBox();
		bottomButtonBox = new BottomButtonBox();
		
		packStart(topButtonBox, expand, fill, localPadding); // TOP justify
		packStart(middleButtonBox, expand, fill, localPadding); // TOP justify
		packStart(bottomButtonBox, expand, fill, localPadding); // TOP justify
		
	} // this()


} // class BottomBox


class TopButtonBox : HorizontalBox
{
	private:
	Button button01, button02;
	string button01Text = "Button 01", button02Text = "Button 02";
	
	public:
	this()
	{
		button01 = new Button(button01Text);
		button02 = new Button(button02Text);

		packStart(button01, expand, fill, localPadding);
		packStart(button02, expand, fill, localPadding);
		
	} // this()
	
} // class TopButtonBox


class MiddleButtonBox : HorizontalBox
{
	private:
	Button button03, button04, button05;
	string button03Text = "Button 03", button04Text = "Button 04", button05Text = "Button 05";
	
	public:
	this()
	{
		button03 = new Button(button03Text);
		button04 = new Button(button04Text);
		button05 = new Button(button05Text);
		
		packStart(button03, expand, fill, localPadding);
		packStart(button04, expand, fill, localPadding);
		packStart(button05, expand, fill, localPadding);

	} // this()
	
} // class MiddleButtonBox


class BottomButtonBox : HorizontalBox
{
	private:
	Button button06;
	string button06Text = "Button 06";
	
	public:
	this()
	{
		button06 = new Button(button06Text);
		
		packStart(button06, expand, fill, localPadding);

	} // this()

} // class BottomButtonBox


class MiddleBox : HorizontalBox
{
	private:
	MyTextView myTextView2, myTextView3;
	string content2 = "myTextView2", content3 = "myTextView3";
	string extraContent = ": and here is some text...";
	
	public:
	this()
	{
		myTextView2 = new MyTextView(content2 ~ extraContent);
		myTextView2.setSizeRequest(220, 200);
		myTextView3 = new MyTextView(content3 ~ extraContent);
		myTextView3.setSizeRequest(220, 200);
		
		packStart(myTextView2, expand, fill, localPadding); // TOP justify
		packStart(myTextView3, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class MiddleBox


class TopBox : HorizontalBox
{
	private:
	MyTextView myTextView1;
	string content = "myTextView1";
	string extraContent = ": and here is some text.";
	
	public:
	this()
	{
		myTextView1 = new MyTextView(content ~ extraContent);
		myTextView1.setSizeRequest(450, 200);
		
		packStart(myTextView1, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class TopBox


class VerticalBox : Box
{
	private:
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;

	public:
	this()
	{
		super(Orientation.	VERTICAL, globalPadding);
		
	} // this()
	
} // class VerticalBox


class HorizontalBox : Box
{
	private:
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;

	public:
	this()
	{
		super(Orientation.HORIZONTAL, globalPadding);
		
	} // this()
	
} // class HorizontalBox


class MyTextView : TextView
{
	private:
	TextBuffer textBuffer;
	string _content;
	
	public:
	this(string content)
	{
		super();
		textBuffer = getBuffer();
		_content = content;
		textBuffer.setText(_content);
		
	} // this()

} // class MyTextView
