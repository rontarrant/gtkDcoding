// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ComboBoxText;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow("Test Rig");
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


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
	string[] days = ["yesterday", "today", "tomorrow"];
	bool entryOn = false;
	
	this()
	{
		super(entryOn);
		
		foreach(day; days)
		{
			appendText(day);
		}

		setActive(0); // preselect the first item in the drop-down

		addOnChanged(&doSomething);
		
	} // this()
	
	
	void doSomething(ComboBoxText cbt)
	{
		writeln(getActiveText());
		
	} // doSomething()

} // class DayComboBoxText
