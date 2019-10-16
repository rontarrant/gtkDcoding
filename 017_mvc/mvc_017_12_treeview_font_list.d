// This source code is in the public domain.

// MVC Dynamically-loaded TreeView - List of System Fonts

import std.stdio;
import std.math;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ScrolledWindow;
import gtk.TreeView;
import gtk.ListStore;
import gtk.TreeIter;
import gtk.TreePath;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;
import pango.PgFontDescription;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "MVC Dynamically-loaded TreeView";
	AppBox appBox;
	int minimumWidth, naturalWidth, minimumHeight, naturalHeight;
	
	this()
	{
		super(title);
		setSizeRequest(750, 400);
		
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	MyScrolledWindow myScrolledWindow;
	
	this()
	{
		super(Orientation.VERTICAL, 10);

		myScrolledWindow = new MyScrolledWindow();
		packStart(myScrolledWindow, true, true, 0);
		
	} // this()

} // class AppBox


class MyScrolledWindow : ScrolledWindow
{
	FontTreeView fontTreeView;
	
	this()
	{
		fontTreeView = new FontTreeView();
		super();
		setSizeRequest(500, 400);
		add(fontTreeView);
		
	} // this()
	
} // class MyScrolledWindow


class FontTreeView : TreeView
{
	FontFamilyColumn fontFamilyColumn;
	FontSizeColumn fontSizeColumn;
	FontPangoSizeColumn fontPangoSizeColumn;
	FontStyleColumn fontStyleColumn;
	FontWeightColumn fontWeightColumn;
	FontListStore fontListStore;
	
	this()
	{
		super();

		addOnRowActivated(&onRowActivated);
		
		fontListStore = new FontListStore();
		setModel(fontListStore);
		
		fontFamilyColumn = new FontFamilyColumn(fontListStore);
		appendColumn(fontFamilyColumn);

		fontSizeColumn = new FontSizeColumn();
		appendColumn(fontSizeColumn);
		
		fontPangoSizeColumn = new FontPangoSizeColumn();
		appendColumn(fontPangoSizeColumn);
		
		fontStyleColumn = new FontStyleColumn();
		appendColumn(fontStyleColumn);
		
		fontWeightColumn = new FontWeightColumn();
		appendColumn(fontWeightColumn);

	} // this()
	
	
	void onRowActivated(TreePath treePath, TreeViewColumn tvc, TreeView tv)
	{
		int columnNumber;
		TreeIter treeIter = new TreeIter(fontListStore, treePath);
		
		// find the column number...
		if(tvc.getTitle() == "Font Family")
		{
			columnNumber = 0;
		}
		else if(tvc.getTitle() == "Size")
		{
			columnNumber = 1;
		}
		else if(tvc.getTitle() == "Pango Units")
		{
			columnNumber = 2;
		}
		else if(tvc.getTitle() == "Style")
		{
			columnNumber = 3;
		}
		else if(tvc.getTitle() == "Weight")
		{
			columnNumber = 4;
		}

		writeln("TreePath (row): ", treePath, " columnNumber: ", columnNumber);
		
		// get the contents of the cell double-clicked by the user
		// Because there are nothing but strings in the store, we don't have to
		// do any more digging, just echo the string to the terminal.
		auto value = fontListStore.getValue(treeIter, columnNumber);
		writeln("cell contains: ", value.getString());
		writeln(); // a blank line to separate each report
		
	} // onRowActivated()
	
} // class FontTreeView


class FontFamilyColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Font Family";
	string attributeType = "text";
	int columnNumber = 0; // numbering starts at '0'

	this(FontListStore fontListStore)
	{
		cellRendererText = new CellRendererText();
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		addAttribute(cellRendererText, "font-desc", fontListStore.Column.FONT_DESC);
		setSortColumnId(columnNumber);
		
	} // this()

} // class FontFamilyColumn


class FontSizeColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Size";
	string attributeType = "text";
	int columnNumber = 1; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		setSortColumnId(columnNumber);
		
	} // this()

} // class FontSizeColumn


class FontPangoSizeColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Pango Units";
	string attributeType = "text";
	int columnNumber = 2; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		setSortColumnId(columnNumber);
		
	} // this()

} // class FontPangoSizeColumn


class FontStyleColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Style";
	string attributeType = "text";
	int columnNumber = 3; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		setSortColumnId(columnNumber);
		
	} // this()

} // class FontStyleColumn


class FontWeightColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Weight";
	string attributeType = "text";
	int columnNumber = 4; // numbering starts at '0'

	this()
	{
		cellRendererText = new CellRendererText();
		
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		setSortColumnId(columnNumber);
		
	} // this()

} // class FontWeightColumn


class FontListStore : ListStore
{
	SysFontListPango sysFontListPango;
	PgFontDescription[] fontList;
	TreeIter treeIter;
	
	enum Column
	{
		FAMILY = 0,
		SIZE,
		PANGO_SIZE,
		STYLE,
		WEIGHT,
		FONT_DESC
		
	} // enum Column
	
	this()
	{
		super([GType.STRING, GType.STRING, GType.STRING, GType.STRING, GType.STRING, PgFontDescription.getType()]);

		sysFontListPango = new SysFontListPango();
		fontList = sysFontListPango.getList();
		
		foreach(font; fontList)
		{
			treeIter = createIter();
			
			setValue(treeIter, 0, font.getFamily());
			setValue(treeIter, 1, font.getSize() / 1024);
			setValue(treeIter, 2, font.getSize());
			setValue(treeIter, 3, font.getStyle());
			setValue(treeIter, 4, font.getWeight());
			setValue(treeIter, 5, font);
		}

	} // this()

} // class FontListStore


class SysFontListPango
{
	private:
	PgFontMap _pgFontMap;
	PgFontFamily[] _pgFontFamilies;
	PgFontFamily _font;
	PgFontDescription[] _pgFontDescriptions;
	PgFontDescription _fontDesc;
	int _fontSize = 9, counter = 1;

	public:
	this()
	{	
		_pgFontMap = PgCairoFontMap.getDefault();
		_pgFontMap.listFamilies(_pgFontFamilies);

		counter = 1;
		
		foreach(_font; _pgFontFamilies)
		{
			_fontDesc = new PgFontDescription(_font.getName(), _fontSize);
			_pgFontDescriptions ~= _fontDesc;

			if(fmod(counter, 4) == 0)
			{
				varyFontBySize();
			}

			if(fmod(counter, 5) == 0)
			{
				varyFontByWeight(PangoWeight.BOLD);
			}
			else if(fmod(counter, 6) == 0)
			{
				varyFontByWeight(PangoWeight.THIN);
			}

			_fontSize++;
			counter++;
	
			if(_fontSize > 19)
			{
					_fontSize = 9;
			}
		}

	} // this()
	
	
	void varyFontBySize()
	{
		_fontDesc.setStyle(PangoStyle.ITALIC);
		
	} // varyFontBySize()
	
	
	void varyFontByWeight(PangoWeight weight)
	{
		_fontDesc.setWeight(weight);
		
	} // varyFontByWeight()


	PgFontDescription[] getList()
	{
		return(_pgFontDescriptions);
		
	} // getList()
	
	
	void printList()
	{
		int counter = 1;
		
		foreach(_fontDesc; _pgFontDescriptions)
		{
			writeln("counter: ", counter);
			writeln("family: ", _fontDesc.getFamily());
			writeln("gravity: ", _fontDesc.getGravity());
			writeln("size in points: ", _fontDesc.getSize() / 1024); // pango _font units are 1024 x points
			writeln("size in Pango units: ", _fontDesc.getSize()); // pango _font units are 1024 x points		
			writeln("stretch: ", _fontDesc.getStretch());
			writeln("style: ", _fontDesc.getStyle());
			writeln("variant: ", _fontDesc.getVariant());
			writeln("weight: ", _fontDesc.getWeight());
			writeln();
			counter++;

		} // foreach

	} // printList()
	
} // class SysFontListPango
