/*
 * Trigger various actions using command line switches.
 * The switches can be -t, -v, or -c. They can also be combined:
 * as -cvt.
 */
import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;
import gio.ApplicationCommandLine;
import glib.VariantDict;

import std.stdio;
import std.algorithm;

void main(string[] args)
{
	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	ApplicationFlags flags = ApplicationFlags.HANDLES_COMMAND_LINE;
	string id = "com.gtkdcoding.app.app_020_06_commandline_options"; // rules
	bool registration = false;
	
	OptionFlags optionFlags = OptionFlags.NONE;
	OptionArg optionArg = OptionArg.NONE;

	this(string[] args)
	{
		super(id, flags);
		
		addOnActivate(&onActivate);
		addOnStartup(&onStartup);
		addOnShutdown(&onShutdown);
		addOnHandleLocalOptions(&onHandleLocalOptions);

		// Build dictionary of command line switches (local options).
		//	When given on the command line, the long name is preceeded by '--' and the short name by '-'.
		addMainOption("config", 'c', optionFlags, optionArg, "Configuration file", "to be filled in later");
		addMainOption("version", 'v', optionFlags, optionArg, "Report software version", "to be filled in later");
		addMainOption("test", 't', optionFlags, optionArg, "Just a test, no need to panic", "to be filled in later");

		writeln("registration before: ", registration);
		registration = register(null);
		writeln("registration after: ", registration);

		run(args);

	} // this()


	int onHandleLocalOptions(VariantDict vd, GioApplication app)
	{
		int exitStatus = 0;
		
		writeln("triggered onHandleLocalOptions...");
		
		if(vd.contains("test"))
		{
			writeln("\t'test' switch: opening window...");
			activate();
		}
		
		if(vd.contains("config"))
		{
			writeln("\t'config' switch: if we had one, we'd be reading the configuration file now.");
		}
		
		if(vd.contains("version"))
		{
			writeln("\t'version' switch: This software is pre-alpha. No version number assigned");
		}
		
		return(exitStatus); //implies success
		
	} // onHandleLocalOptions()
	
	
	void onActivate(GioApplication app) // non-advanced syntax
	{
		writeln("triggered onActivate...");
        AppWindow appWindow = new AppWindow(this);
		
    } // onActivate()


	void onStartup(GioApplication app) // non-advanced syntax
	{
		writeln("triggered onStartup...");
		
    } // onStartup()


	void onShutdown(GioApplication app) // non-advanced syntax
	{
		writeln("triggered onShutdown...");
		
    } // onShutdown()

} // class MyApplication


class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Command Line Option Switches";
	
	this(MyApplication myApp)
	{
		super(myApp);
		setSizeRequest(width, height);
		setTitle(title);
		showAll();
		
	} // this()
	
} // class AppWindow
