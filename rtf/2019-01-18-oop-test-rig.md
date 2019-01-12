# OOP Test Rig Breakdown
When you look at the imperative test rig alongside the OOP version, it becomes quickly apparent that it’s mostly about code organization. The changes start in the **main()** function:

	void main(string[] args)
	{
		Main.init(args);
		TestRigWindow myTestRig = new TestRigWindow("Test Rig");
		
		myTestRig.sayHi();
		
		// Show the window and its contents...
		myTestRig.showAll();
		
		
		// give control over to gtkD.
		Main.run();
		
	} // main()

On line 2 of **main()**, the window declaration is quite different because instead of instantiating the *MainWindow* class directly, there’s a derived class called *TestRigWindow*. Other than that, everyone else is the same, so let’s move on.

**quitApp()** is no longer a standalone function as it’s been incorporated into the *TestRigWindow* class which looks like this:

	class TestRigWindow : MainWindow
	{
		this(string title)
		{
			super(title);
			
			addOnDestroy(&quitApp);
			
		} // this() CONSTRUCTOR
		
		void quitApp(Widget widget)
		{
			writeln("Bye.");
			Main.quit();
			
		} // quitApp()
	
		void sayHi()
		{
			writeln("Hello GtkD OOP.");
		}
	
	} // class myAppWindow

The first function is the constructor. D uses **this()** instead of  the class name (Java) or construct() (PHP) and inside we:

 - call **super()**, a shorthand for calling the parent class’s constructor,
 -	while passing along the window’s title, and
 -	hook up the window’s close button.

You’ll notice that connecting the *onDestroy* signal is done differently here. In the imperative version, because **quitApp()** is external to **main()**, we have to carefully preserve *quitApp*’s scope so it doesn’t disappear on us before we can use it. But in the OOP version, the syntax is simplified because we don’t need to worry about scope. As long as the class object exists, everything within it will exist as well. This simplification of syntax makes our job easier, although it’ll get difficult again under certain circumstances. I’ll talk about that in later posts.

Another thing you’ll notice is that *TestRigWindow*’s **sayHi()** function has taken the place of a simple **writeln()** call in the imperative version of **main()**. We could have left it where it was, but this way all functions are part of the *TestRigWindow* class and there’s a certain orderliness to that.

Now let’s talk about the next code example.
#Window Resized
There’s only one new line of code here and it appears in the *TestRigWindow*’s constructor:

	setSizeRequest(300, 400);

You may wonder why size is being requested instead of demanded, but that’s a question for the original GTK+ devs. I have no idea, but it really doesn’t matter.

The numbers are, of course, the x and y dimensions of the window we’re opening.
# Conclusion
So, now we have two test rigs and we’ve looked at how to size a window to exact specifications. That gives us a foundation to build from in the coming posts.

Until next time when we take an initial look at buttons (not mouse buttons, GUI buttons) happy D-coding and may the widgets be with you.

