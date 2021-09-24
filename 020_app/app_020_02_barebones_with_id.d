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
	string id = "com.gtkdcoding.app.app_020_02_barebones_with_id"; // rules

	this(string[] args)
	{
		super(id, flags);
		
		addOnActivate(&onActivate);
		run(null);
		
	} // this()
	
	
	void onActivate(GioApplication app) // non-advanced syntax
	{
		AppWindow appWindow = new AppWindow(this);
		writeln("triggered onActivate...");
		writeln("Application ID: ", getApplicationId());

    } // onActivate()

} // class MyApplication


class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Application with ID";
	
	this(MyApplication myApp)
	{
		super(myApp);
		setSizeRequest(width, height);
		setTitle(title);
		showAll();
		
	} // this()
	
} // class AppWindow
