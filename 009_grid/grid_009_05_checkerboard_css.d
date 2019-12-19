// This source code is in the public domain.

// checkerboard grid example

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.Label;

import gtk.CssProvider;
import gtk.StyleContext;

// Note: StateFlags are found in gtk.c.types

void main(string[] args)
{
	GridWindow gridWindow;
	
	Main.init(args);
	
	gridWindow = new GridWindow();

	Main.run();
	
} // main()


class GridWindow : MainWindow
{
	string title = "A simple grid example";
	Grid grid;
	
	this()
	{
		super(title);
		
		grid = new Grid();
		
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
		
		showAll();

	} // this()
		
} // class GridWindow


class WideLabel : Label
{
	this(string text)
	{
		super(text);
		
		setSizeRequest(60, 60);
			
	} // this()
	
} // class WideLabel


class BlueLabel : WideLabel
{
	CSS css;
	string blueLabelName = "blue_label";

	this(string labelText)
	{
		super(labelText);
		setName(blueLabelName);
		css = new CSS(getStyleContext());
		
	} // this()
	
} // class BlueLabel


class RedLabel : WideLabel
{
	string redLabelName = "red_label";
	CSS css;

	this(string labelText)
	{
		super(labelText);
		setName(redLabelName);
		css = new CSS(getStyleContext());
		
	} // this()
	
} // class RedLabel


class CSS // GTK4 compliant
{
	CssProvider provider;

	enum LABEL_CSS = "label#red_label
						{
							background-color: #84B5FF;
						}
						label#blue_label
						{
							background-color: #FF6B8E;
						}";

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromData(LABEL_CSS);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		
	} // this()	
	
} // class CSS
