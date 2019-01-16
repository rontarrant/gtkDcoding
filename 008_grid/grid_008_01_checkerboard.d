// checkerboard grid example

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.EventBox; // Labels can't have a background color, so we pack them in EventBoxes which can
import gtk.Label;
import gdk.RGBA; // needed for defining colors for the label backgrounds
import gtk.c.types; // to bring in the StateFlags ENUM (an EventBox needs to know its state)

void main(string[] args)
{
	Main.init(args);
	GridWindow gridWindow = new GridWindow("A simple grid example");
	gridWindow.showAll();
	Main.run();
	
} // main()


class GridWindow : MainWindow
{
	this(string title)
	{
		super(title);
		
		Grid grid = new Grid();
		
		// row 0
		RedLabel zeroZero = new RedLabel("cell 0, 0");
		grid.attach(zeroZero, 0, 0, 1, 1);
		BlueLabel oneZero = new BlueLabel("cell 1, 0");
		grid.attach(oneZero, 1, 0, 1, 1);
		RedLabel twoZero = new RedLabel("cell 2, 0");
		grid.attach(twoZero, 2, 0, 1, 1);
		BlueLabel threeZero = new BlueLabel("cell 3, 0");
		grid.attach(threeZero, 3, 0, 1, 1);

		// row 1
		BlueLabel zeroOne = new BlueLabel("cell 0, 1");
		grid.attach(zeroOne, 0, 1, 1, 1);
		RedLabel oneOne = new RedLabel("cell 1, 1");
		grid.attach(oneOne, 1, 1, 1, 1);
		BlueLabel twoOne = new BlueLabel("cell 2, 1");
		grid.attach(twoOne, 2, 1, 1, 1);
		RedLabel threeOne = new RedLabel("cell 3, 1");
		grid.attach(threeOne, 3, 1, 1, 1);
		
		// row 2
		RedLabel zeroTwo = new RedLabel("cell 0, 2");
		grid.attach(zeroTwo, 0, 2, 1, 1);
		BlueLabel oneTwo = new BlueLabel("cell 1, 2");
		grid.attach(oneTwo, 1, 2, 1, 1);
		RedLabel twoTwo = new RedLabel("cell 2, 2");
		grid.attach(twoTwo, 2, 2, 1, 1);
		BlueLabel threeTwo = new BlueLabel("cell 3, 2");
		grid.attach(threeTwo, 3, 2, 1, 1);
		
		// row 3
		BlueLabel zeroThree = new BlueLabel("cell 0, 3");
		grid.attach(zeroThree, 0, 3, 1, 1);
		RedLabel oneThree = new RedLabel("cell 1, 3");
		grid.attach(oneThree, 1, 3, 1, 1);
		BlueLabel twoThree = new BlueLabel("cell 2, 3");
		grid.attach(twoThree, 2, 3, 1, 1);
		RedLabel threeThree = new RedLabel("cell 3, 3");
		grid.attach(threeThree, 3, 3, 1, 1);
		
		add(grid);
		
	} // this()
		
} // class GridWindow


class WideLabel : EventBox
{
	this(string text)
	{
			super();
			Label label = new Label(text);
			label.setSizeRequest(60, 60);
			add(label);
			
	} // this()
	
} // class WideLabel


class BlueLabel : WideLabel
{
	this(string labelText)
	{
		super(labelText);
		RGBA blueColor = new RGBA(0.518, 0.710, 1.0, 1.0); // 0.518	0.710	1.000
		overrideBackgroundColor(StateFlags.NORMAL, blueColor);
		
	} // this()
	
} // class BlueLabel


class RedLabel : WideLabel
{
	this(string labelText)
	{
		super(labelText);
		RGBA redColor = new RGBA(1.0, 0.420, 0.557, 1.0); // 1.000	0.420	0.557

		overrideBackgroundColor(StateFlags.NORMAL, redColor);
		
	} // this()
	
} // class RedLabel
