// ComboBox Weather Control

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ComboBox;
import gtk.ListStore;
import gtk.TreeIter;
import gtk.TreeViewColumn;
import gtk.CellRendererText;
import gtk.CellRendererPixbuf;
import gdk.RGBA;
import pango.PgFontDescription;
import gdk.Pixbuf;

// local imports
import singleton.S_DetectedOS;

void main(string[] args)
{
	Main.init(args);
	
	TestRigWindow myTestRig = new TestRigWindow("Test Rig");

	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	AppBox appBox;
	
	this(string title)
	{
		super(title);
		
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
	WeatherComboBox weatherComboBox;
	WeatherListStore weatherListStore;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		weatherListStore = new WeatherListStore();
		weatherComboBox = new WeatherComboBox(weatherListStore);
		packStart(weatherComboBox, true, true, 0);
		
	} // this()

} // class AppBox


class WeatherComboBox : ComboBox
{
	private:
	bool entryOn = false;
	WeatherListStore _weatherListStore;
	CellRendererText cellRendererText;
	CellRendererPixbuf cellRendererPixbuf;
	int visibleColumn = 0;
	int activeItem = 0;
	
	public:
	this(WeatherListStore weatherListStore)
	{
		super(entryOn);

		// set up and bring in the store
		_weatherListStore = weatherListStore;
		setModel(_weatherListStore);
		setActive(activeItem);
		
		// hook up signals
		addOnChanged(&doSomething);
		
		// set up the ComboBox's column to render text
		cellRendererText = new CellRendererText();
		packStart(cellRendererText, false);
		addAttribute(cellRendererText, "text", _weatherListStore.Column.TEXT);
		addAttribute(cellRendererText, "font-desc", _weatherListStore.Column.FONT);
		addAttribute(cellRendererText, "foreground-rgba", _weatherListStore.Column.FG_COLOR);
		addAttribute(cellRendererText, "foreground-set", _weatherListStore.Column.COLOR_ON);
		addAttribute(cellRendererText, "background-rgba", _weatherListStore.Column.BG_COLOR);
		addAttribute(cellRendererText, "background-set", _weatherListStore.Column.COLOR_ON);		

		cellRendererPixbuf = new CellRendererPixbuf();
		packStart(cellRendererPixbuf, false);
		addAttribute(cellRendererPixbuf, "pixbuf", _weatherListStore.Column.IMAGE);
		
	} // this()
	
	
	void doSomething(ComboBox cb)
	{
		string data;
		TreeIter treeIter;

		write("index of selection: ", getActive(), ", "); // returns the index of the selected item
		
		if(getActiveIter(treeIter) == true) // bool indicates if retrieval successed or not
		{
			data = getModel().getValueString(treeIter, 0); // get what's in the 1st (and only) column
			writeln("data: ", data);
		}

	} // doSomething()

} // class WeatherComboBox


class WeatherListStore : ListStore
{
	private:
	S_DetectedOS s_detectedOS;

	string[] _textItems = ["Sunny", "Partly Cloudy", "Cloudy", "Rainy", "Thunderstorm", "Snowy"];
	string[] _fontNames;
	int[] _fontSizes = [12, 13, 14, 15, 16, 17];

	float[][] _fgColors = [[.027, .067, .855, 1.0], [.02, .043, .576, 1.0], [.012, .031, .404, 1.0], 
								 [.741, .757, .816, 1.0], [.894, 1.0, 0.0, 1.0], [0.0, .933, 1.0, 1.0]];
								 
	float[][] _bgColors = [[.592, .957, 1.0, 1.0], [.522, .847, .882, 1.0], [.365, .596, .62, 1.0], 
								 [.259, .42, .435, 1.0], [.18, .29, .302, 1.0], [1.0, 1.0, 1.0, 1.0]];

	string[] _images = ["_images/sun_50x.png", "_images/partly_cloudy_50x.png", "_images/cloudy_50x.png",
							 "_images/rainy_50x.png", "_images/thunder_50x.png", "_images/snowy_50x.png"];
	PgFontDescription fontDesc;
	TreeIter _treeIter;
	
	public:
	enum Column
	{
		TEXT = 0,
		FONT = 1,
		COLOR_ON = 2,
		FG_COLOR = 3,
		BG_COLOR = 4,
		IMAGE = 5
		
	} // enum Column
	
	
	this()
	{
		string textItem, fontName, imageName;
		float fgRed, bgRed, fgGreen, fgAlpha, bgGreen, fgBlue, bgBlue, bgAlpha;
		int fontSize;
		
		super([GType.STRING, PgFontDescription.getType(), GType.INT, RGBA.getType(), RGBA.getType(), Pixbuf.getType()]);
		
		assignFonts();
		
		for(int i; i < _textItems.length; i++)
		{
			textItem = _textItems[i];
			fontName = _fontNames[i];
			fontSize = _fontSizes[i];

			fgRed = _fgColors[i][0];
			fgGreen = _fgColors[i][1];
			fgBlue = _fgColors[i][2];
			fgAlpha = _fgColors[i][3];
			
			bgRed = _bgColors[i][0];
			bgGreen = _bgColors[i][1];
			bgBlue = _bgColors[i][2];
			bgAlpha = _bgColors[i][3];
			
			imageName = _images[i];

			_treeIter = createIter();
			setValue(_treeIter, Column.TEXT, textItem);
			
			fontDesc = new PgFontDescription(fontName, fontSize);
			
			if(fontDesc !is null)
			{
				writeln(fontDesc, " was found");
			}
			else
			{
				writeln(fontName, " not found");
			}

			setValue(_treeIter, Column.FONT, fontDesc);
			setValue(_treeIter, Column.COLOR_ON, true);
			setValue(_treeIter, Column.FG_COLOR, new RGBA(fgRed, fgGreen, fgBlue, fgAlpha));
			setValue(_treeIter, Column.BG_COLOR, new RGBA(bgRed, bgGreen, bgBlue, bgAlpha));
			setValue(_treeIter, Column.IMAGE, new Pixbuf(imageName));
		}

	} // this()


	void assignFonts()
	{
		s_detectedOS = s_detectedOS.get();
		
		switch(s_detectedOS.getOS())
		{
			case "Windows":
				writeln("Windows found");
				_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
			break;
			
			case "OSX":
				_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
			break;				
		
			case "Posix":
				writeln("Linux found");
				_fontNames = ["FreeSerif", "Garuda", "Century Schoolbook L", "Kalimati", "Purisa", "FreeMono"];
			break;

			default:
				writeln("No known OS found");
				_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
			break;
		} // switch
		
	} // assignFonts()
	
} // class WeatherListStore

/*
 * Font equivalency cross-platform:
 * 
 * Windows - Times New Roman
 * Linux - FreeSerif
 * Mac OSX - Times New Roman
 * 
 * Windows - Arial
 * Linux - Garuda
 * Mac OSX - Arial
 * 
 * Windows - Georgia
 * Linux - Century Schoolbook L (Nimbus Roman No9 L)
 * Mac OSX - Georgia
 * 
 * Windows - Verdana
 * Linux - Kalimati
 * Mac OSC - Verdana
 * 
 * Windows - Comic Sans MS
 * Linux - Purisa, Bold
 * Mac OSX - Comic Sans MS
 * 
 * Windows - Courier New
 * Linux - FreeMono
 * Mac OSX - Courier New
 * 
 */