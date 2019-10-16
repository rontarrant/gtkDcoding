// This source code is in the public domain.

// a button with a label containing markup that can be turned on or off

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Label;
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
	string title = "Label with Switchable Mark-up";
	MarkupSwitchButton button;
	
	this()
	{
		super(title);

		button = new MarkupSwitchButton();
		add(button);
	
		showAll();
		
	} // this()
	
} // class TestRigWindow


class MarkupSwitchButton : Button
{
	MarkupLabel muLabel;
	
	this()
	{
		super();
		muLabel = new MarkupLabel();
		add(muLabel);
		
		addOnClicked(&switchStuff);

	} // this()


	void switchStuff(Button b)
	{
		muLabel.markupSwitch();
		
	} // switchStuff()
	
} // class MarkupSwitchButton


class MarkupLabel : Label
{
	string markupText = "<i>Fancy</i> <b>Schmancy</b>";
	string onMessage = "Markup is ON.";
	string offMessage = "Markup is OFF.";
	string currentStateMessage;
	
	this()
	{
		super(markupText);
		setUseMarkup(true);
		currentStateMessage = onMessage;
		markupState();
		
	} // this()
	
	
	void markupSwitch()
	{
		if(getUseMarkup() == true)
		{
			setUseMarkup(false);
			currentStateMessage = offMessage;
		}
		else
		{
			setUseMarkup(true);
			currentStateMessage = onMessage;
		}

		markupState();

	} // markupSwitch()
	
	
	void markupState()
	{
		writeln(currentStateMessage);
		
	} // markupState()

} // class MarkupLabel
