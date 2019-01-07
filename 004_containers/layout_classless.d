// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

/////////////////////////////////////
// Additional import statements START
/////////////////////////////////////

import gdk.Event;
import gtk.Button;
import gtk.Layout;

///////////////////////////////////
// Additional import statements END
///////////////////////////////////

void main(string[] args)
{
	Main.init(args);
	MainWindow myTestRig = new MainWindow("Test Rig");
	myTestRig.addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	/////////////////////
	// Test Code Start //
	/////////////////////
	
	
	Layout layout = new Layout(null, null);
	
	Button button = new Button();
	button.setLabel("Button in a Layout");
	button.addOnClicked(delegate void(_) { doSomething(); } );
	
	Button otherButton = new Button("Something Else");
	otherButton.addOnClicked(delegate void(_) { doSomethingElse("Something else"); } );
	
	// The next two lines, or the single line following, do the same thing.
	// layout.add(button);
	// layout.move(button, 10, 20);
	layout.put(button, 10, 20); // x, y
	layout.put(otherButton, 10, 60);
	myTestRig.add(layout);
	

	///////////////////
	// Test Code End //
	///////////////////
	
	// Show the window and its contents...
	myTestRig.showAll();

	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp()
{
	// This exists in case we want to do anything
	// before exiting such as warn the user to
	// save work.
	writeln("Bye.");
	Main.quit();
	
} // quitApp()

/////////////////////
// Test Code Start //
/////////////////////


void doSomething()
{
	writeln("Something was done.");
	
} // doSomething()


void doSomethingElse(string somethingElse)
{
	writeln(somethingElse, " was done.");
	
} // doSomethingElse()

///////////////////
// Test Code End //
///////////////////
