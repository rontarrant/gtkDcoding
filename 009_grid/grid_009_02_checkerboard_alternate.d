// checkerboard grid example

import std.stdio;
import std.string;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.EventBox; // Labels can't have a background color, so we pack them in EventBoxes which can
import gtk.Widget;
import gtk.Label;
import gdk.RGBA; // needed for defining colors for the label backgrounds

// Note: StateFlags are found in gtk.c.types

void main(string[] args)
{
	Main.init(args);
	GridWindow gridWindow = new GridWindow();
	gridWindow.showAll();
	Main.run();
	
} // main()


class GridWindow : MainWindow
{
	string title = "A simple grid example";
	Grid grid;
	Widget[] labels;
	
	this()
	{
		int x, y; // positions within the grid
		int xOddEven, yOddEven;
		string labelText;
		
		super(title);
		
		grid = new Grid();
		
		for(x = 0; x < 4; x++)
		{
			for(y = 0; y < 4; y++)
			{
				// where the row and column numbers are both odd or both even, squares are red
				// where one is odd and the other even, squares are blue
				xOddEven = x % 2; // find the row #, if it's odd or even
				yOddEven = y % 2; // find the column #, if it's odd or even
				labelText = format("cell %d, %d", x, y);
				
				if((xOddEven == 0 && yOddEven == 0) || (xOddEven != 0 && yOddEven != 0 ))
				{
					RedLabel label = new RedLabel(labelText);
					labels ~= label;                           // must be added in scope
					grid.attach(label, x, y, 1, 1);            // must be used in scope
				}
				else
				{
					BlueLabel label = new BlueLabel(labelText);
					labels ~= label;                           // ditto
					grid.attach(label, x, y, 1, 1);		       // ditto
				}
			}
		}

		add(grid);
		
	} // this()
		
} // class GridWindow


class WideLabel : EventBox
{
	Label label;
	
	this(string text)
	{
			super();
			label = new Label(text);
			label.setSizeRequest(60, 60);
			add(label);
			
	} // this()
	
} // class WideLabel


class BlueLabel : WideLabel
{
	RGBA blueColor;
	
	this(string labelText)
	{
		super(labelText);
		
		blueColor = new RGBA(0.518, 0.710, 1.0, 1.0);
		
		overrideBackgroundColor(StateFlags.NORMAL, blueColor);
		
	} // this()
	
} // class BlueLabel


class RedLabel : WideLabel
{
	RGBA redColor;
	
	this(string labelText)
	{
		super(labelText);
		
		redColor = new RGBA(1.0, 0.420, 0.557, 1.0);

		overrideBackgroundColor(StateFlags.NORMAL, redColor);
		
	} // this()
	
} // class RedLabel
