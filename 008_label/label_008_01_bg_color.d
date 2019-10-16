// This source code is in the public domain.

// label with a colored background
// has to be done by dropping the Label into an EventBox

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.EventBox; // Labels can't have a background color, so we pack them in EventBoxes which can
import gtk.Label;
import gdk.RGBA; // needed for defining colors for the label backgrounds

// Note: StateFlags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "A Label with a Colored Background";
	
	this()
	{
		super(title);
		
		RedLabel redLabel = new RedLabel();
		add(redLabel);

		showAll();
		
	} // this()
	
	
} // class TestRigWindow


class RedLabel : EventBox
{
	Label label;
	RGBA redishColor;
	// extra spaces at start and end so it doesn't look crowded
	string labelText = "  Label with Red Background  ";
	
	this()
	{
		super();
		label = new Label(labelText);
		redishColor = new RGBA(1.0, 0.420, 0.557, 1.0);
		overrideBackgroundColor(StateFlags.NORMAL, redishColor);
		
		add(label);
		
	} // this()
	
} // class RedLabel
