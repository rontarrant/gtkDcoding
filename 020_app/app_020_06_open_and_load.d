/*
 * pass file name(s) via the command line so the application can open it/them.
 */
import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;
import gio.ApplicationCommandLine;
import gio.FileIF;

import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;
import gtk.TextBuffer;

import std.stdio;

void main(string[] args)
{
	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	// HANDLES_OPEN is for opening files from the command line. 
	ApplicationFlags flags = ApplicationFlags.HANDLES_OPEN;
	string id = "com.gtkdcoding.app.app_020_06_open_and_load"; // rules

	this(string[] args)
	{
		super(id, flags);
		
		addOnActivate(&onActivate);
		addOnStartup(&onStartup);
		addOnShutdown(&onShutdown);
		addOnOpen(&onOpen);

		run(args);

	} // this()


	// Override gio.Application.activate() so we can process arguments.
	// Add a TextView, open the file, load it into the TextView.
	void activate(string filename)
	{
		writeln("activate called");
		AppWindow appWindow = new AppWindow(this, filename);

	} // activate()
	

	void onActivate(GioApplication app) // non-advanced syntax
	{
		AppWindow appWindow = new AppWindow(this, null);
		writeln("triggered onActivate...");
		writeln("\tApplication ID: ", getApplicationId());
		
    } // onActivate()


	void onStartup(GioApplication app) // non-advanced syntax
	{
		writeln("triggered onStartup...");
		writeln("\tThis is where you'd read a config file.");
		
    } // onStartup()


	void onShutdown(GioApplication app) // non-advanced syntax
	{
		writeln("triggered onShutdown...");
		writeln("\tThis is where you'd write a config file.");

    } // onShutdown()


	void onOpen(FileIF[] files, string hint, GioApplication app)
	{
		writeln("triggered onOpen...");
		
		foreach(file; files)
		{
			string name = file.getPath();
			writeln("file name: ", name);
			activate(name);
		}

	} // onOpen()

} // class MyApplication


class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Application Open Signal";
	AppBox appBox;

	this(MyApplication myApp, string filename)
	{
		super(myApp);
		setSizeRequest(width, height);
		
		if(filename !is null)
		{
			setTitle(title ~ "- " ~ filename);
		}
		else
		{
			setTitle(title);
		}
		
		appBox = new AppBox(filename);
		add(appBox);

		showAll();
		
	} // this()
	
} // class AppWindow


class AppBox : Box
{
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	ScrolledTextWindow scrolledTextWindow;
	
	this(string filename)
	{
		super(Orientation.VERTICAL, globalPadding);
		
		scrolledTextWindow = new ScrolledTextWindow(filename);
		
		packStart(scrolledTextWindow, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class AppBox


class ScrolledTextWindow : ScrolledWindow
{
	MyTextView myTextView;
	
	this(string filename)
	{
		super();
		
		myTextView = new MyTextView(filename);
		add(myTextView);
		
	} // this()
	
} // class ScrolledTextWindow


class MyTextView : TextView
{
	TextBuffer textBuffer;
	string content;
	File file;
	
	this(string filename)
	{
		super();
		textBuffer = getBuffer();
		
		// Make this conditional so a window will still open even
		// if no file names are given on the command line.
		if(filename)
		{
			file = File(filename, "r");
			
			while (!file.eof())
			{
				string line = file.readln();
				content ~= line;
			}
			
			textBuffer.setText(content);
			file.close();		
		}
		
	} // this()

} // class MyTextView
