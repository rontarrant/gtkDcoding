private import gtk.MainWindow;
private import gtk.Main;
private import gtk.Widget;
private import gtk.Entry;
private import gtk.CheckButton;
private import gtk.Button;
private import gtk.Label;
private import gtk.Grid;

// private import glib.Str;

private import std.stdio;
/**
 * This tests the GtkD Entry widget
 */
class TestEntries : Grid
{
	/**
	 * Our main widget to test
	 */
	Entry entry;

	// constructor
	this()
	{
		super();

		// create the main test widget
		entry = new Entry("Change me!");
		Label entryLabel = new Label("Input text");
		attach(entryLabel, 0, 0, 1, 1);
		attach(entry, 1, 0, 2, 1);

		// create a button that will print the content of the entry to stdout
		Button testButton = new Button("Show entry", &showEntry);
		attach(testButton, 3, 0, 1, 1);
		//testButton.setTooltip("This is just a test",null);

		// create a button that will change the entry display mode to invisible
		// i.e. like a password entry
		CheckButton entryVisible = new CheckButton("Visible", &entryVisible);
		entryVisible.setActive(true);
		attach(entryVisible, 0, 1, 2, 1);

		// create a button that will change the entry mode to not editable
		CheckButton entryEditable = new CheckButton("Editable", &entryEditable);
		entryEditable.setActive(true);
		attach(entryEditable, 2, 1, 2, 1);
	} // this()


	void showEntry(Button button)
	{
		writef("text field contains \"%s\"\n", entry.getText());
		
	} // showEntry()


	void entryEditable(CheckButton button)
	{
		entry.setEditable(button.getActive());
		
		if(button.getActive() == true)
		{
			writeln("Editable");
		}
		else
		{
			writeln("not editable.");
		}
		
	} // entryEditable()


	void entryVisible(CheckButton button)
	{
		entry.setVisibility(button.getActive());
		
		if(button.getActive() == true)
		{
			writeln("Text Entry is visible.");
		}
		else
		{
			writeln("Text Entry is invisible.");
		}
		
	} // entryVisible()

} // class TestEntries

void main(string[] args)
{
	Main.init(args);
	TestRigWindow myWindow = new TestRigWindow("Test Rig");
	
	TestEntries testEntries = new TestEntries();
	myWindow.add(testEntries);
	
	myWindow.showAll();
	Main.run();

} // main()


class TestRigWindow : MainWindow
{
	this(string title)
	{
		super(title);
		
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// Show the window and its contents...
		showAll();
		
	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		// This exists in case we want to do anything
		// before exiting such as warn the user to
		// save work.
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TextRigWindow
