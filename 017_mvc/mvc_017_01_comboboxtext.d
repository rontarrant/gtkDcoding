// ComboBoxText example #1 - simple

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ComboBoxText;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "MVC ComboBoxText";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	DayComboBoxText dayComboBoxText;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		dayComboBoxText = new DayComboBoxText();
		packStart(dayComboBoxText, false, false, 0);
		
	} // this()

} // class AppBox


class DayComboBoxText : ComboBoxText
{
	private:
	string[] days = ["yesterday", "today", "tomorrow"];
	bool entryOn = false;
	
	public:
	this()
	{
		super(entryOn);
		
		foreach(day; days)
		{
			appendText(day);
		}

		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBoxText cbt)
	{
		writeln(getActiveText());
		
	} // doSomething()

} // class DayComboBoxText
