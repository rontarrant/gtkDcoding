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
	Widget[] labels;
	
	this(string title)
	{
		int x, y; // positions within the grid
		int xOddEven, yOddEven;
		string labelText;
		
		super(title);
		
		Grid grid = new Grid();
		
		for(x = 0; x < 4; x++)
		{
			for(y = 0; y < 4; y++)
			{
				xOddEven = x % 2;
				yOddEven = y % 2;
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
