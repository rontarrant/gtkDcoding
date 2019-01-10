/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

module TestEntries;

private import gtk.Table;
private import gtk.MainWindow;
private import gtk.Main;
private import gtk.Widget;
private import gtk.Entry;
private import gtk.CheckButton;
private import gtk.Button;
private import gtk.Label;

private import glib.Str;

private import std.stdio;
/**
 * This tests the GtkD Entry widget
 */
class TestEntries : Table
{
	/**
	 * Out main widget to test
	 */
	Entry entry;

	// constructor
	this()
	{
		super(3, 2, false);

		// create the main test widget
		entry = new Entry("Change me!");
		attach(new Label("Input text"), 0, 1, 0, 1, AttachOptions.SHRINK, AttachOptions.SHRINK, 4, 4);
		attach(entry, 1, 2, 0, 1, AttachOptions.EXPAND, AttachOptions.EXPAND, 4, 4);

		// create a button that will print the content of the entry to stdout
		Button testButton = new Button("Show entry", &showEntry);
		attach(testButton, 2, 3, 0, 1, AttachOptions.SHRINK, AttachOptions.SHRINK, 4, 4);
		//testButton.setTooltip("This is just a test",null);

		// create a button that will change the entry display mode to invisible
		// i.e. like a password entry
		CheckButton entryVisible = new CheckButton("Visible", &entryVisible);
		entryVisible.setActive(true);
		attach(entryVisible, 2, 3, 1, 2, AttachOptions.SHRINK, AttachOptions.SHRINK, 4, 4);

		// create a button that will change the entry mode to not editable
		CheckButton entryEditable = new CheckButton("Editable", &entryEditable);
		entryEditable.setActive(true);
		attach(entryEditable, 1, 2, 1, 2, AttachOptions.SHRINK, AttachOptions.SHRINK, 4, 4);
	} // this()


	void showEntry(Button button)
	{
		writef("text field contains '%s'\n", entry.getText());
		
	} // showEntry()


	void entryEditable(CheckButton button)
	{
		entry.setEditable(button.getActive());
		
	} // entryEditable()


	void entryVisible(CheckButton button)
	{
		entry.setVisibility(button.getActive());
		writeln("getActive = ", button.getActive());
		
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

} // class myAppWindow
