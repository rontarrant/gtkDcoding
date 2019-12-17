// This source code is in the public domain.

// GTK Switch Example

import std.stdio;

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
	string title = "Switch Example";
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
	string[] variableNames = [" Ho", " Hum", " Hey"];
	PingPongButton partnerButton;

	this(string buttonLabel)
	{
		super(buttonLabel ~ variableNames[0]);
		labelText = buttonLabel;
		
		addOnButtonPress(&onButtonPress);
		
	} // this()


	bool onButtonPress(Event e, Widget w)
	{
		string newLabel;
		
		labelNumber++;
		
		if(labelNumber is 3)
		{
			labelNumber = 0;
		}
		
		newLabel = labelText ~ variableNames[labelNumber];
		partnerButton.setLabel(newLabel);
		
		writeln("Partner button label has changed to: ", newLabel);
		
		return(true);
		
	} // onButtonPress()
	
	
	void addPartner(PingPongButton newPartnerButton)
	{
		writeln("New partner button for ", getLabel(), ": ", newPartnerButton.getLabel());
		partnerButton = newPartnerButton;
		
	} // addPartner()
	
} // class PingPongButton
