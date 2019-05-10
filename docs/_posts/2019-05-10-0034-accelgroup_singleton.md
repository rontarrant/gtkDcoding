---
title: 0034 – AccelGroup as a Singleton
layout: post
description: Wrapping an AccelGroup in a Singleton.
author: Ron Tarrant
keywords:
- GtkD
- GTK+ 3
- dlang
- D language
- Menu
- MenuBar
- MenuItem
- Widget
- Event
- AccelGroup
- c.types
- Singleton

---

## 0034 – AccelGroup as a Singleton

Something about how the `AccelGroup` was used in *gtkDcoding* blog post #32 ([*Adding Accelerator Keys to MenuItems*](http://gtkdcoding.com/2019/05/03/0032-accelerator_keys.html)) needs to be addressed. It’s this business of instantiating the `AccelGroup` at the top level (ie. `TestRigWindow`) and then passing it down through multiple layers of other UI objects until it gets to where it’s actually needed, in the `MenuItem` objects.

Not that there’s anything technically wrong with passing the AccelGroup object down like that. It works, so why fix it?

Because if we use a singleton class to hold the `AccelGroup`, we gain a few things:

- we only need to deal with the `AccelGroup` where it's actually needed:
	- in the top-level window, and
	- in the `MenuItem` class definitions that have shortcut keys,
- which means we can dispense with the cumbersome-ness of handing down, and
- we gain elegance.

And for good measure, we'll cover some *Other Useful Stuff <sup>TM</sup>* as we go along.

### The Singleton

There’s a lot of discussion about whether or not the singleton should be taken out back and shot. All I will say is that, because it can *only* be instantiated once, no matter how many times we try, we avoid the ad infinitum passing down and this makes it an elegant solution for the AccelGroup.

Be aware, however, that we don’t instantiate in the normal way. But let's not get ahead of ourselves. We'll start with just the naked singleton and go from there.

What we’re starting with to build our `AccelGroupSingleton` class can be found in [the D Wiki Low-lock Singleton example]( https://wiki.dlang.org/Low-Lock_Singleton_Pattern). And here’s what it looks like:

	class MySingleton
	{
	    private this() {}
	
	    // Cache instantiation flag in thread-local bool
	    private static bool instantiated_;
	
	    // Thread global
	    private __gshared MySingleton instance_;
	
	    static MySingleton get()
	    {
	        if(!instantiated_)
	        {
	            synchronized(MySingleton.classinfo)
	            {
	                if(!instance_)
	                {
	                    instance_ = new MySingleton();
	                }
	
	                instantiated_ = true;
	            }
	        }
	
	        return(instance_);
	    }
	}

Seems complicated, right? Well, the only things we really need to know are:

- we instantiate or get a reference with a call to `get()` wherever we need to deal with this object,
- never *ever* call the constructor (if we do this up right, we can't call it directly, anyway),
- the `private` keyword will only do its job if this class is in a `module` of its own, and
- anything we add to this to make it useful goes into the constructor.

So, our `SingletonAccelGroup` class (which you can find in [this example file right here](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/singleton/SingletonAccelGroup.d)) looks like this:

	module SingletonAccelGroup;
	
	import std.stdio;
	
	import gtk.AccelGroup;
	
	class SingletonAccelGroup : AccelGroup
	{
		private:
		// Cache instantiation flag in thread-local bool
		static bool instantiated_;
	
		// Thread global
		__gshared SingletonAccelGroup instance_;
	
		this()
		{
			super();
			
		} // this()
	
		public:
		
		static SingletonAccelGroup get()
		{
			write("getting...");
			
			if(!instantiated_)
			{
				synchronized(SingletonAccelGroup.classinfo)
				{
					if(!instance_)
					{
						instance_ = new SingletonAccelGroup();
						writeln("creating");
					}
	
					instantiated_ = true;
				}
			}
			else
			{
				writeln("not created");
			}
	
			return(instance_);
			
		} // get()
	
	} // class SingletonAccelGroup

*Note: If you use this locally, don't forget to put this in its own sub-directory.*
 
Right at the top, we have:

	module SingletonAccelGroup;

Technically, you could put a similar statement at the top of every one of your `.d` files, turning them all into modules and it wouldn't really change anything for that code file, per se. What it does is give us a way to import it for those times when we want the code from one file available to another.

*Note that the `module` statement has to be the first statement in the file. You can have a comment above it, but nothing else.*

The file needs to be saved as `SingletonAccelGroup.d` (the `module` name plus a `.d` extension) and just for kicks, I put it in its own sub-directory which means the path and filename in relation to our dev directory is:

	./singleton/SingletonAccelGroup.d

Hold that thought as we go into the next section...

### Other Useful Stuff #1: Using an External Class

To bring the external file into the mix for compiling/linking, we need an `import` statement which you’ll find near the top of [today’s primary code file](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_18_singleton_accel_menus.d). Any time the file you want to import is in a sub-directory, replace the slash (`/`) with a dot (`.`) in your import statement... like this:

	import singleton.SingletonAccelGroup;

If I'd put this file in the same directory as our primary `.d` file, the import statement would look like this instead:

	import SingletonAccelGroup;

Okay, now you can let go of that thought from the previous section.

### Attaching the `SingeltonAccelGroup` to the `MainWindow`

Just like with the stock `AccelGroup`, we need to attach it to the `MainWindow` which means our `TestRigWindow` class now looks like this:

	class TestRigWindow : MainWindow
	{
		string title = "Multiple Menus Example";
		SingletonAccelGroup singletonAccelGroup;
	
		this()
		{
			super(title);
			setDefaultSize(640, 480);
			addOnDestroy(&quitApp);
	
			singletonAccelGroup = singletonAccelGroup.get();
			addAccelGroup(singletonAccelGroup);
	
			AppBox appBox = new AppBox();
			add(appBox);
			
			showAll();
			
		} // this()
		
		
		void quitApp(Widget w)
		{
			// do other quit stuff here if necessary
			
			Main.quit();
			
		} // quitApp()
		
	} // class TestRigWindow

I’ll draw your attention to three things here:

- the definition of `singletonAccelGroup` near the top,
- the constructor where we call `singletonAccelGroup.get()` to instantiate, and
- also in the constructor, where we `addAccelGroup()` to attach it to the window.

### The Other End of Things: Inside the `MenuItem` Class

For each `MenuItem` that has a hotkey, we rewrite its definition to look similar to this:

	class NewFileItem : MenuItem
	{
		string itemLabel = "New";
		char accelKey = 'n';
		SingletonAccelGroup singletonAccelGroup;
		   
		this()
		{
			singletonAccelGroup = singletonAccelGroup.get();
			super(&doSomething, itemLabel, "activate", false, singletonAccelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
			
		} // this()
		
		
		void doSomething(MenuItem mi)
		{
			writeln("New file created.");
			
		} // doSomething()
		
	} // class NewFileItem

Again, we need three statements to set up and use the `SingletonAccelGroup`:

- the declaration near the top,
- the call to `singletonAccelGroup.get()` in the constructor, and
- the fifth argument that's passed to `super()`.

And if you want to prove to yourself that all these `MenuItem`s really do use the same `SingletonAccelGroup`, add this line as the last statement in the constructors of a few of the `MenuItem`s:

	writeln(&singletonAccelGroup);

The address echoed to the terminal will be the same for each.

## Other Useful Stuff #2: Important Compiling Note

When you go to compile this, because our code is now in two separate files, you’ll need to add the `–i` switch on the command line. Here's the Windows version:

	dmd –de –w –m64 –Lgtkd.lib –i <filename>.d

It’s the same in Linux, just add `–i` to whatever compile command you usually use:

	dmd -de -w -m64  -i -I/usr/include/dmd/gtkd3 -L-L/usr/lib/x86_64-linux-gnu -L-L/usr/lib/i386-linux-gnu -L-l:libgtkd-3.so -L-l:libdl.so.2 -L--no-warn-search-mismatch -defaultlib=libphobos2.so <code-filename>.d -of<executable-filename>

or the short form:

	dmd -de -w -m64  -i `pkg-config --cflags --libs gtkd-3` <code-filename>.d -of<executable-filename>

or the alias:

	dbuild -i <code_filename>.d

## Conclusion

Even though doing the `AccelGroup` up as a singleton isn’t necessary, it’s more elegant and more readily reusable. We just need to remember that wherever we refer to the singleton, no matter what it's used for, we:

- define it,
- call `<singleton_name>.get()` to instantiate or get a reference, and
- then use whatever we've added to the singleton's constructor for whatever nefarious purpose we have.

As an extra bonus today, we also went over how to split our code over more than one file. In a nutshell:

- move the code for a class into its own file,
	- name it using CamelCase, and
	- give it a `.d` extension,
- to the very top of the file, add the line:
	- `module <FileNameWithoutExtension>;`
- `import` it into your primary code file just as you would any other library or wrapper, and
- use the `–i` flag when compiling.

And that’s it for another *gtkDcoding* blog post. Until next time…
