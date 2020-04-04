import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;

void main(string[] args)
{

	MyApplication thisApp = new MyApplication(args);
	
} // main()


class MyApplication : GtkApplication
{
	GApplicationFlags flags = GApplicationFlags.FLAGS_NONE;
	string id = null; // if application uniqueness isn't important

	this(string[] args)
	{
		super(id, flags);
		addOnActivate(&onActivate);
		run(args);
		
	} // this()
	
	
	void onActivate(GioApplication app) // non-advanced syntax
	{
        AppWindow appWindow = new AppWindow(this);
		
    } // onActivate()

} // class MyApplication


class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Barebones Application";
	
	this(MyApplication myApp)
	{
		super(myApp);
		setSizeRequest(width, height);
		setTitle(title);
		showAll();
		
	} // this()
	
} // class AppWindow
