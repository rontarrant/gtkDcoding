// a button with a label containing markup that can be turned on or off

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Label;
import gtk.Button;

void main(string[] args)
{
	Main.init(args);
	MainWindow mainWindow = new MainWindow("Pretty Label");

	// create a markup-switching button
	MarkupSwitchButton button = new MarkupSwitchButton("<i>Fancy</i> <b>Schmancy</b>");

	mainWindow.add(button);

	mainWindow.showAll();
	Main.run();
	
} // main()


class MarkupSwitchButton : Button
{
	Label label;
	
	this(string markupText)
	{
		super();
		label = new Label(markupText);
		label.setUseMarkup(true);
		add(label);
		
		addOnClicked(&markupSwitch);

	} // this()
	
	
	// a function to turn markup on and off
	void markupSwitch(Button b)
	{
		if(label.getUseMarkup() == true)
		{
			writeln("turning it off");
			label.setUseMarkup(false);
		}
		else
		{
			writeln("turning it off");
			label.setUseMarkup(true);
		}
	} // markupSwitch()
	
} // class MarkupSwitchButton
