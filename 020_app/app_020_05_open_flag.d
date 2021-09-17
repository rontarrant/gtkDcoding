/*
 * pass file name(s) via the command line so the application can open it/them.
 */
import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;
import gio.ApplicationCommandLine;
import gio.FileIF;

import std.stdio;

void main(string[] args)
{
	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	// HANDLES_OPEN is for opening files from the command line. 
	ApplicationFlags flags = ApplicationFlags.HANDLES_OPEN;
	string id = "com.gtkdcoding.app.app_020_04_open_signal"; // rules

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
	void activate(string arg)
	{
        AppWindow appWindow = new AppWindow(this, arg);

	} // activate()
	

	void onOpen(FileIF[] files, string fileStream, GioApplication app)
	{
		writeln("triggered onOpen...");
		
		foreach(file; files)
		{
			string name = file.getUri();
			writeln("file name: ", name);
			activate(name);
		}
		
		writeln("fileStream: ", fileStream);
		
		writeln("\there, you would open the file stream, load it and...");
		
	} // onOpen()
	

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

} // class MyApplication


class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Application Open Signal";
	
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
		
		showAll();
		
	} // this()
	
} // class AppWindow
