// a button with a label containing markup that can be turned on or off

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Label;
import gtk.Button;

void main(string[] args)
{
	Main.init(args);
	
	testRigWindow testRigWindow = new testRigWindow();

	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string title = "Pretty Label";
	MarkupSwitchButton button;
	
	this()
	{
		super(title);

		button = new MarkupSwitchButton();                     // *** NEW ***
		add(button);
	
		showAll();
		
	} // this()
	
} // class testRigWindow


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
	
	// a function to turn markup on and off
	void markupSwitch()	                                                        // *** NEW ***
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
