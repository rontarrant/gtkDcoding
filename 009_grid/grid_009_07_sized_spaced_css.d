// This source code is in the public domain.

// checkerboard grid example with sized cells and spacing

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
	string title = "Grid - Padded & Spaced";
	Grid grid;
	
	this()
	{
		super(title);
		
		grid = new SpacedGrid();
		add(grid);
		
		showAll();

	} // this()
		
} // class GridWindow


class SpacedGrid : Grid
{
	int rowSpacing = 5, columnSpacing = 10;
	RedLabel zeroZero, twoZero, oneOne, threeOne, zeroTwo, twoTwo, oneThree, threeThree;
	BlueLabel oneZero, threeZero, zeroOne, twoOne, oneTwo, threeTwo, zeroThree, twoThree;
	
	this()
	{
		// red labels
		zeroZero = new RedLabel("cell 0, 0");
		attach(zeroZero, 0, 0, 1, 1);
		twoZero = new RedLabel("cell 2, 0");
		attach(twoZero, 2, 0, 1, 1);
		oneOne = new RedLabel("cell 1, 1");
		attach(oneOne, 1, 1, 1, 1);
		threeOne = new RedLabel("cell 3, 1");
		attach(threeOne, 3, 1, 1, 1);
		zeroTwo = new RedLabel("cell 0, 2");
		attach(zeroTwo, 0, 2, 1, 1);
		twoTwo = new RedLabel("cell 2, 2");
		attach(twoTwo, 2, 2, 1, 1);
		oneThree = new RedLabel("cell 1, 3");
		attach(oneThree, 1, 3, 1, 1);
		threeThree = new RedLabel("cell 3, 3");
		attach(threeThree, 3, 3, 1, 1);
		
		//blue labels
		oneZero = new BlueLabel("cell 1, 0");
		attach(oneZero, 1, 0, 1, 1);
		threeZero = new BlueLabel("cell 3, 0");
		attach(threeZero, 3, 0, 1, 1);
		zeroOne = new BlueLabel("cell 0, 1");
		attach(zeroOne, 0, 1, 1, 1);
		twoOne = new BlueLabel("cell 2, 1");
		attach(twoOne, 2, 1, 1, 1);
		oneTwo = new BlueLabel("cell 1, 2");
		attach(oneTwo, 1, 2, 1, 1);
		threeTwo = new BlueLabel("cell 3, 2");
		attach(threeTwo, 3, 2, 1, 1);
		zeroThree = new BlueLabel("cell 0, 3");
		attach(zeroThree, 0, 3, 1, 1);
		twoThree = new BlueLabel("cell 2, 3");
		attach(twoThree, 2, 3, 1, 1);
		
		setRowSpacing(rowSpacing);
		setColumnSpacing(columnSpacing);
		
	} // this()

} // class SpacedGrid


class BlueLabel : Label
{
	CSS css;
	string blueLabelName = "blue_label";

	this(string labelText)
	{
		super(labelText);
		setName(blueLabelName);
		css = new CSS(getStyleContext());
		setSizeRequest(60, 60);
		
	} // this()
	
} // class BlueLabel


class RedLabel : Label
{
	string redLabelName = "red_label";
	CSS css;

	this(string labelText)
	{
		super(labelText);
		setName(redLabelName);
		css = new CSS(getStyleContext());
		setSizeRequest(60, 60);
		
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
