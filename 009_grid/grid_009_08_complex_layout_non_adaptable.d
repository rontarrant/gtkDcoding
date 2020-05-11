// This source code is in the public domain.

// Demonstrates a layout that adapts to the Window size.

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Grid;
import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;
import gtk.TextBuffer;
import gtk.Button;

import gtk.CssProvider;
import gtk.StyleContext;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Non-adaptable Layout";
	AppGrid appGrid;
	CSS css;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		css = new CSS(getStyleContext());
		setSizeRequest(300, 200);
		
		appGrid = new AppGrid();
		add(appGrid);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


/*
 * use setMarginTop, setMarginBottom, setMarginStart, and setMarginEnd
 * can also use setBorderWidth
 */
class AppGrid : Grid
{
	int borderWidth = 5;
	int margin = 5;
	int rowSpacing = 5, columnSpacing = 5;
	
	MyTextView myTextView1, myTextView2, myTextView3;
	string content1 = "myTextView1", content2 = "myTextView2", content3 = "myTextView3";
	string extraContent = ": and here is some text";
	
	Button button01, button02, button03, button04, button05, button06;
	string button01Text = "Button 01", button02Text = "Button 02";
	string button03Text = "Button 03", button04Text = "Button 04", button05Text = "Button 05";
	string button06Text = "Button 06";

	this()
	{
		// row 0
		myTextView1 = new MyTextView(content1 ~ extraContent);
		myTextView1.setSizeRequest(450, 200);
		attach(myTextView1, 0, 0, 6, 1);
		
		// row 1
		myTextView2 = new MyTextView(content2 ~ extraContent);
		myTextView2.setSizeRequest(220, 200);
		attach(myTextView2, 0, 1, 3, 1);
		myTextView3 = new MyTextView(content3 ~ extraContent);
		myTextView3.setSizeRequest(220, 200);
		attach(myTextView3, 3, 1, 3, 1);

		// row 2
		button01 = new Button(button01Text);
		attach(button01, 0, 2, 3, 1);
		button02 = new Button(button02Text);
		attach(button02, 3, 2, 3, 1);

		button03 = new Button(button01Text);
		attach(button03, 0, 3, 2, 1);
		button04 = new Button(button02Text);
		attach(button04, 2, 3, 2, 1);
		button05 = new Button(button03Text);
		attach(button05, 4, 3, 2, 1);
		
		button06 = new Button(button06Text);
		attach(button06, 0, 4, 6, 1);

		// spacing
		setBorderWidth(borderWidth);
		setRowSpacing(rowSpacing);
		setColumnSpacing(columnSpacing);
		setMarginBottom(borderWidth);

	} // this()

} // class AppBox


		


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


class CSS // GTK4 compliant
{
	CssProvider provider;

	enum WINDOW_CSS = "window
						{
							background-color: #F6F5F4;
						}";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(WINDOW_CSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
