// This source code is in the public domain.

// example of Application

import std.stdio;

import gtk.Application;
import gtk.Window;

main(string[] args)
{
	MyApplication myApplication;
	int status;
	
	myApplication = new MyApplication();
	
} // main()


class MyApplication : Application
{
	string appName = "My Application";
	MyWindow myWindow;
	
	this()
	{
		
		
	} // this()
	
	
	
} // class MyApplication


class MyWindow : Window
{
	
	
} // class MyWindow
