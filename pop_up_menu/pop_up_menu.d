import gio.Application : GioApplication = Application;
import gtk.Application;
import gtk.ApplicationWindow;
import gtk.EventBox;
import gtk.Menu;
import gtk.Label;
import gtk.ImageMenuItem;
import gtk.Widget;
import gtk.AccelGroup;
import gdk.Event;

int main(string[] args)
{
	auto application = new Application("org.gtkd.demo.popupmenu", GApplicationFlags.FLAGS_NONE);
	application.addOnActivate(delegate void(GioApplication app) { new PopupMenuDemo(application); });
	
	return(application.run(args));
	
} // main()


class PopupMenuDemo : ApplicationWindow
{
	PopUpMenu popUpMenu;

	this(Application application)
	{
		super(application);
		setTitle("GtkD: Popup Menu");
		setDefaultSize(200, 200);

		auto eventBox = new EventBox();
		eventBox.add( new Label("Right click") );
		eventBox.addOnButtonPress(&onButtonPress);
		add(eventBox);

		popUpMenu = new PopUpMenu(eventBox);

		showAll();
		
	} // this()
	

	public bool onButtonPress(Event event, Widget widget)
	{
		bool result = false; // always assume the state you're NOT explicitly setting in the function
		
		if(event.type == EventType.BUTTON_PRESS)
		{
			GdkEventButton* buttonEvent = event.button;

			if(buttonEvent.button == 3)
			{
				popUpMenu.showAll();
				popUpMenu.popup(buttonEvent.button, buttonEvent.time);

				result = true;
			}
		}

		return(result);
		
	} // onButtonPress()
}


class PopUpMenu : Menu
{
	this(EventBox eventBox)
	{
		append(new ImageMenuItem(StockID.CUT, cast(AccelGroup)null));
		append(new ImageMenuItem(StockID.COPY, cast(AccelGroup)null));
		append(new ImageMenuItem(StockID.PASTE, cast(AccelGroup)null));
		append(new ImageMenuItem(StockID.DELETE, cast(AccelGroup)null));
		
		super.attachToWidget(eventBox, null);
		
	} // this()

} // class PopUpMenu
