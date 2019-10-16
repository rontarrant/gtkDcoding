// This source code is in the public domain.

module main;

// Dlang imports
import std.stdio;

// gtk, etc. imports
import gtk.Main;

// local imports
import window.RigWindow;

void main(string[] args)
{
	RigWindow rigWindow;
	
	Main.init(args);

	rigWindow = new RigWindow();
	
	Main.run();
	
} // main()
