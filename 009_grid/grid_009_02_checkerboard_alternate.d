// This source code is in the public domain.

// alternate checkerboard grid example

import std.stdio;
import std.string;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.EventBox;
import gtk.Widget;
import gtk.Label;
import gdk.RGBA;

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
	Widget[] labels;
	
	this()
	{
		int xOddEven, yOddEven;
		string labelText;
		
		super(title);
		
		grid = new Grid();
		
		foreach(int x; 0..4)
		{
			foreach(int y; 0..4)
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
		showAll();
		
	} // this()
		
} // class GridWindow


class WideLabel : EventBox
{
	Label label;
	int width = 60, height = 60;
	
	this(string text)
	{
			super();
			label = new Label(text);
			label.setSizeRequest(width, height);
			add(label);
			
	} // this()
	
} // class WideLabel


class BlueLabel : WideLabel
{
	RGBA blueColor;
	float red = 0.518, green = 0.710, blue = 1.0, alpha = 1.0;
	
	this(string labelText)
	{
		super(labelText);
		
		blueColor = new RGBA(red, green, blue, alpha);
		
		overrideBackgroundColor(StateFlags.NORMAL, blueColor);
		
	} // this()
	
} // class BlueLabel


class RedLabel : WideLabel
{
	RGBA redColor;
	float red = 1.0, green = 0.420, blue = 0.557, alpha = 1.0;
	
	this(string labelText)
	{
		super(labelText);
		
		redColor = new RGBA(red, green, blue, alpha);

		overrideBackgroundColor(StateFlags.NORMAL, redColor);
		
	} // this()
	
} // class RedLabel
