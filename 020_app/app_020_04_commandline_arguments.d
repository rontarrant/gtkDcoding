/*
 * passing generic arguments from the command line.
 */
import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;
import gio.ApplicationCommandLine;

import std.stdio;
import std.conv;
import std.algorithm;

void main(string[] args)
{

	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	ApplicationFlags flags = ApplicationFlags.HANDLES_COMMAND_LINE;
	string id = "com.gtkdcoding.app.app_020_05_commandline_arguments"; // rules
	bool registration = false;

	this(string[] args)
	{
		super(id, flags);
		
		addOnActivate(&onActivate);
		addOnCommandLine(&onCommandLine);

		addOnStartup(&onStartup);
		addOnShutdown(&onShutdown);

		writeln("registration before: ", registration);
		registration = register(null);
		writeln("registration after: ", registration);

		run(args);

	} // this()


	int onCommandLine(ApplicationCommandLine acl, GioApplication app) // non-advanced syntax
	{
		int exitStatus = 0;
		string[] args = acl.getArguments();
		int[] dimensions = [0, 0];

		writeln("triggered onCommandLine...");
	
		// remove the application name from the string of args
		args = args.remove(0);

		writeln("\tcommandline args: ", args);
		writeln("\targs.length: ", args.length);
		
		if(args.length == 0) // make sure we still have arguments to process
		{
				writeln("\tno args");
				activate(null);
		}
		else
		{
			for(int i; i < args.length; i += 2) // and process them in pairs
			{
				string arg = args[i]; // grab the first of the arg pairs
				
				switch(arg)
				{
					case "width":
						dimensions[0] = to!int(args[i + 1]);
					break;
					
					case "height":
						dimensions[1] = to!int(args[i + 1]);
					break;
					
					default:
						writeln("arg: ", arg);
						writeln("arg: ", to!string(args[i + 1]));
					break;
				}
			}
			
			activate(dimensions);
		}
		
		return(exitStatus);
		
	} // onCommandLine()


	void activate(int[] dimensions) // override gio.Application.activate() so we can open a new window
	{
        AppWindow appWindow = new AppWindow(this, dimensions);

	} // activate()
	

	void onActivate(GioApplication app) // non-advanced syntax
	{
		writeln("triggered (super) onActivate...");
		
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
	string title = "Application Commandline Args ";
	
	this(MyApplication myApp, int[] dimensions)
	{
		super(myApp);
		
		if(dimensions[0] != 0)
		{
			width = dimensions[0];
		}
		
		if(dimensions[1] != 0)
		{
			height = dimensions[1];
		}
		
		setSizeRequest(width, height);
		setTitle(title);
		
		showAll();
		
	} // this()
	
} // class AppWindow
