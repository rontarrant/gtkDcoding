// Switch Light ON/OFF with Color Changes

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.ColorButton;
import gtk.Button;
import gtk.Widget;
import gtk.Switch;
import gdk.RGBA;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Switch Light ON/OFF with Color Changes";
	string byeBye = "Bye-bye";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		SwitchBox switchBox = new SwitchBox();
		add(switchBox);
		
		showAll();
		
	} // this()
	
		
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class SwitchBox : Box
{
	LightBulb lightBulb;
	LightSwitch lightSwitch;
	ResetButton resetButton;
	
	this()
	{
		super(Orientation.VERTICAL, 5);
		
		lightBulb = new LightBulb();
		add(lightBulb);
		
		lightSwitch = new LightSwitch(lightBulb);
		add(lightSwitch);
		
		ResetButton resetButton = new ResetButton(lightBulb);
		add(resetButton);
		
	} // this()
	
} // class SwitchBox


class LightSwitch : Switch
{
	LightBulb lightBulb;
	
	this(LightBulb extLightBulb)
	{
		super();
		addOnStateSet(&onStateSet);
		
		lightBulb = extLightBulb;
	
	} // this()


	bool onStateSet(bool state, Switch s)
	{
		setState(state);
		
		if(state == true) // light in ON
		{
			lightBulb.setRgba(lightBulb.onColor);
		}
		else // light is OFF
		{
			lightBulb.setRgba(lightBulb.offColor);
		}
		
		lightBulb.switchState();
		
		return(true);
		
	} // onStateSet()

} // class LightSwitch


class LightBulb : ColorButton
{
	bool state; // ON or OFF
	RGBA defaultOffColor, offColor, defaultOnColor, onColor;
	float redOff = .75, greenOff = .75, blueOff = .75, alphaOff = 1.0;
	float redOn = 1.0, greenOn = .9803, blueOn = .7686, alphaOn = 1.0; 
	
	this()
	{
		super();

		defaultOffColor = new RGBA(redOff, greenOff, blueOff, alphaOff); // mid-gray
		offColor = defaultOffColor;

		defaultOnColor = new RGBA(redOn, greenOn, blueOn, alphaOn);
		onColor = defaultOnColor;
		
		addOnColorSet(&setColor);
		
		state = false; // OFF at start-up
		
	} // this()
	
	
	void switchState()
	{
		if(state == false)
		{
			state = true;
		}
		else
		{
			state = false;
		}
		
	} // switchState()
	
	
	bool getState()
	{
		return(state);
		
	} // getState()
	
	
	void setColor(ColorButton cb)
	{
		RGBA rgba;
		getRgba(rgba);

		if(getState() == true) // ON
		{
			onColor = rgba;
			setRgba(rgba);
		}
		else
		{
			offColor = rgba;
			setRgba(rgba);
		}
		
	} // setColor()


	void reset()
	{
		onColor = defaultOnColor;
		offColor = defaultOffColor;
		
	} // reset()
	
} // class LightBulb


class ResetButton : Button
{
	string labelText = "Reset";
	LightBulb lightBulb;
	
	this(LightBulb extLightBulb)
	{
		super(labelText);
		addOnClicked(&reset);
		
		lightBulb = extLightBulb;
		
	} // this()
	
	
	void reset(Button b)
	{
		lightBulb.reset();
		
		if(lightBulb.getState() == true)
		{
			lightBulb.setRgba(lightBulb.onColor);			
		}
		else
		{
			lightBulb.setRgba(lightBulb.offColor);
		}
	
	} // reset()
	
} // class ResetButton
