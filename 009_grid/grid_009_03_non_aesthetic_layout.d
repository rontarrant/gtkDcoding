// esthetic layout example using a Grid

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Grid;
import gtk.Label;
import gtk.Widget; // needed for setHalign() and setValign() functions
import gtk.Box;

// Note: StateFlags are found in gtk.c.types

void main(string[] args)
{
	testRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new testRigWindow();

	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	int width = 400;
	int height = 100;
	string title = "Grid with Centre-aligned Elements";
	MyGrid myGrid;
	
	this()
	{
		super(title);
		
		myGrid = new MyGrid();
		add(myGrid);
		
		showAll();
		
	} // this()
		
} // class testRigWindow


class MyGrid : Grid
{
	private:
	Label zeroZero, oneZero, zeroOne, oneOne;
	
	public:
	this()
	{
		super();

		// row 0
		zeroZero = new Label("this is a long bit of text");
		attach(zeroZero, 0, 0, 1, 1);
		
		oneZero = new Label("cell 1, 0");
		attach(oneZero, 1, 0, 1, 1);

		// row 1
		zeroOne = new Label("and this is shorter");
		attach(zeroOne, 0, 1, 1, 1);
				
		oneOne = new Label("cell 1, 1");
		attach(oneOne, 1, 1, 1, 1);

	} // this()
	
} // class MyGrid
