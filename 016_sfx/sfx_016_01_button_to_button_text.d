// This source code is in the public domain.

// GTK Button Interaction - changing one button via the actions of another - Text

import std.stdio;
import std.array;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.Label;

import gdk.Event;
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
	string title = "Button Interaction - Text";
	string byeBye = "Bye-bye";
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
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

	
} // class TestRigWindow


class AppBox : Box
{
	string ralph = "Ralph", george = "George";
	PingPongButton pingButton, pongButton;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.HORIZONTAL, globalPadding);
		
		pingButton = new PingPongButton(ralph);
		packStart(pingButton, false, false, localPadding);

		pongButton = new PingPongButton(george);
		packStart(pongButton, false, false, localPadding);

		// partner up the buttons
		pingButton.addPartner(pongButton);
		pongButton.addPartner(pingButton);
		
	} // this()

} // class AppBox


class PingPongButton : Button
{
	int labelNumber = 0;
	string labelText;
	string[] nameSuffixes = [" Tra", " La", " Li"];
	PingPongButton partnerButton;

	this(string buttonLabel)
	{
		super(buttonLabel ~ nameSuffixes[0]);
		labelText = buttonLabel;
		
		addOnButtonPress(&onButtonPress);
		
	} // this()


	bool onButtonPress(Event event, Widget widget)
	{
		if(event.button.button == 1 && event.type != EventType.DOUBLE_BUTTON_PRESS && event.type != EventType.TRIPLE_BUTTON_PRESS)
		{
			string newLabel;
			
			labelNumber++;
			
			if(labelNumber == nameSuffixes.length)
			{
				labelNumber = 0;
			}
			
			newLabel = partnerButton.labelText ~ nameSuffixes[labelNumber];
			partnerButton.setLabel(newLabel);
			
			writeln("Partner button label has changed to: ", labelNumber, ", ", newLabel);
		}
		
		return(true);
		
	} // onButtonPress()
	
	
	void addPartner(PingPongButton newPartnerButton)
	{
		writeln("New partner button for ", getLabel(), ": ", newPartnerButton.getLabel());
		partnerButton = newPartnerButton;
		
	} // addPartner()
	
} // class PingPongButton
