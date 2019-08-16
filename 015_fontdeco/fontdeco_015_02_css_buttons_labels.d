// CSS-enabled Labels & Buttons

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.Button;
import gtk.Label;

void main(string[] args)
{
	Main.init(args);

	TestRigWindow myTestRig = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string windowTitle = "CSS & Button Labels";
	AppBox appBox;
	CSS css;
	
	this()
	{
		super(windowTitle);
		addOnDestroy(&quitApp);
		
		css = new CSS(); // enable CSS
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow


class AppBox : Box
{
	CSSButton cssButton1, cssButton2;
	CSSLabel cssLabel1, cssLabel2, cssLabel3;
	string button1Text = "CSS Button 1", button2Text = "CSS Button 2";
	string button1CSSName = "button1", button2CSSName = "button2";
	string label1Text = "Hello 1", label2Text = "Hello 2 U", label3Text = "Hello 3";
	string label1CSSName = "label1", label2CSSName = "label2",label3CSSName = "label3";
	
	this()
	{
		super(Orientation.VERTICAL, 25);
		
		cssButton1 = new CSSButton(button1Text, button1CSSName);
		cssLabel1 = new CSSLabel(label1Text, label1CSSName);
		cssLabel2 = new CSSLabel(label2Text, label2CSSName);
		cssLabel3 = new CSSLabel(label3Text, label3CSSName);
		cssButton2 = new CSSButton(button2Text, button2CSSName);
		
		setHomogeneous(true);

		// packStart(<child object>, false, false, 0); // LEFT justify
		add(cssButton1);
		add(cssLabel1);
		add(cssLabel2);
		add(cssLabel3);
		add(cssButton2);
				
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox


class CSSButton : Button
{
	this(string textLabel, string cssName)
	{
		super(textLabel);
		setName(cssName);
		
	} // this()
	
} // class CSSButton


class CSSLabel : Label
{
	this(string textLabel, string cssName)
	{
		super(textLabel);
		setName(cssName);
		
	} // this()
	
} // class CSSLabel


class CSS
{
	import gdk.Display;
	import gdk.Screen;
	import gtk.StyleContext;
	import gtk.CssProvider;
	
	string cssPath = "./css/button_label.css";

	this()
	{
		CssProvider provider = new CssProvider();
		provider.loadFromPath(cssPath);
		
		Display display = Display.getDefault();
		Screen screen = display.getDefaultScreen();
		StyleContext.addProviderForScreen(screen, provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);

	} // this()

} // CSS
