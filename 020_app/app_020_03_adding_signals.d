import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;

import std.stdio;

void main(string[] args)
{

	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	ApplicationFlags flags = ApplicationFlags.FLAGS_NONE;
	string id = "com.gtkdcoding.app.app_020_01_barebones"; // rules

	this(string[] args)
	{
		super(id, flags);
		
		addOnActivate(&onActivate);
		addOnStartup(&onStartup);
		addOnShutdown(&onShutdown);
		
		run(args);
		
	} // this()


	void onActivate(GioApplication app) // non-advanced syntax
	{
        AppWindow appWindow = new AppWindow(this);
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
	string title = "Application with Signals";
	
	this(MyApplication myApp)
	{
		super(myApp);
		setSizeRequest(width, height);
		setTitle(title);
		showAll();
		
	} // this()
	
} // class AppWindow
