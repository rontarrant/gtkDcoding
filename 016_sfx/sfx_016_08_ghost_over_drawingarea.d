// This source code is in the public domain.

// GTK Ghosting over an Image

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.Button;
import gtk.Layout;
import gtk.DrawingArea;
import gdkpixbuf.Pixbuf;
import gdk.Event;

import cairo.Context;
import cairo.ImageSurface;
import cairo.Surface;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Ghosting Over an Image";
	string byeBye = "Bye-bye";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();
		
	} // this()
		
		
	void quitApp(Widget widget)
	{
		writeln(byeBye);
		
		Main.quit();
		
	} // quitApp()

	
} // class TestRigWindow


class AppBox : Box
{
	BGLayout bgLayout;
	int globalPadding = 10, localPadding = 5;
		
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		bgLayout = new BGLayout();
		packStart(bgLayout, false, false, localPadding);
		
	} // this()

} // class AppBox


class BGLayout : Layout
{
	MyButton myButton1, myButton2, myButton3;
	BGDrawingArea bgDrawing;
	
	this()
	{
		super(null, null);
		setSizeRequest(640, 426); // has to be set so signals get through from child widgets
		
		bgDrawing = new BGDrawingArea();
		put(bgDrawing, 0, 0);		
		
		myButton1 = new MyButton(0);
		put(myButton1, 226, 213);
		myButton1.setOpacity(0.5);

		myButton2 = new MyButton(1);
		put(myButton2, 320, 120);

		myButton3 = new MyButton(2);
		put(myButton3, 175, 306);
		myButton3.setSensitive(false);
		
	} // this()
	
} // class NodeLayout


class BGDrawingArea : DrawingArea
{
	Surface surface;
	string imageFilename = "images/playing_piano.png";
	int width, height;
	GtkAllocation size;

	this()
	{
		surface = ImageSurface.createFromPng(imageFilename);
		Pixbuf.getFileInfo(imageFilename, width, height); // get the image size

		addOnDraw(&onDraw);
		
	} // this()
	
	
	bool onDraw(Scoped!Context context, Widget w)
	{
		context.setSourceSurface(surface, 0, 0);
		getAllocation(size);
		setSizeRequest(width, height);

		context.paint();
		
		return(true);
		
	} // onDraw()

} // class BGDrawingArea


class MyButton : Button
{
	string[] labelText = ["Ghosted", "Non-ghosted", "Insensitive"];
	
	this(int labelIndex)
	{
		super(labelText[labelIndex]);
		addOnButtonPress(&onButtonPress);

	} // this()

	
	bool onButtonPress(Event e, Widget w)
	{
		if(getOpacity() is 1.0)
		{
			setLabel(labelText[0]);
			setOpacity(0.5);
			writeln("opacity = ", getOpacity(), ", turning it to half.");
		}
		else
		{
			setLabel(labelText[1]);
			setOpacity(1.0);
			writeln("opacity = ", getOpacity(), ", turning it to full.");
		}
		writeln("Button pressed is: ", getLabel());
		
		return(true);
		
	} // onButtonPress()

/*
	bool onButtonPress(Event e, Widget w)
	{
		if(getLabel() == labelText[0])
		{
			setLabel(labelText[1]);
			setOpacity(1.0);
			writeln("label: ", getLabel(), ", opacity = ", getOpacity(), ", turning it to full.");
		}
		else
		{
			setLabel(labelText[0]);
			setOpacity(0.5);
			writeln("label: ", getLabel(), ", opacity = ", getOpacity(), ", turning it to half.");
		}
		writeln("Button pressed is: ", getLabel());
		
		return(true);
		
	} // onButtonPress()
*/
} // class MyButton
