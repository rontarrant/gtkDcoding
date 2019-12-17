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
	int[string] colorNumbers;
	PingPongButton pingButton, pongButton;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.HORIZONTAL, globalPadding);
		colorNumbers = ["red" : 0, "blue" : 1];
		
		pingButton = new PingPongButton(ralph, colorNumbers["red"]);
		packStart(pingButton, false, false, localPadding);

		pongButton = new PingPongButton(george, colorNumbers["blue"]);
		packStart(pongButton, false, false, localPadding);

		// partner up the buttons
		pingButton.addPartner(pongButton);
		pongButton.addPartner(pingButton);
		
	} // this()

} // class AppBox


class PingPongButton : Button
{
	CSS css;
	int labelNumber = 0;
	string labelText;
	string[] variableNames = [" Ho", " Hum", " Hey"];
	string[] labelNames = ["pingpongred", "pingpongblue"];
	PingPongButton partnerButton;

	this(string buttonLabel, int color)
	{
		super(buttonLabel ~ variableNames[0]);
		labelText = buttonLabel;
		
		addOnButtonPress(&onButtonPress);
		setName(labelNames[color]);
		css = new CSS(getStyleContext());
		
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
		
		if(partnerButton.getName() == "pingpongred")
		{
			writeln("CSS name is red, switching to blue");
			partnerButton.setName("pingpongblue");
		}
		else
		{
			writeln("CSS name is blue, switching to red");
			partnerButton.setName("pingpongred");
		}
		
		writeln("Partner button label has changed to: ", newLabel);
		
		return(true);
		
	} // onButtonPress()
	
	
	void addPartner(PingPongButton newPartnerButton)
	{
		writeln("Partner button for ", getLabel(), ": ", newPartnerButton.getLabel());
		partnerButton = newPartnerButton;
		
	} // addPartner()
	
} // class PingPongButton


class CSS // GTK4 compliant
{
	CssProvider provider;

	enum LABEL_CSS = ".text-button#pingpongred
						{
							background: #FFBFBF;
						}
						.text-button#pingpongblue
						{
							background: #BFC7FF;
						}";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(LABEL_CSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
