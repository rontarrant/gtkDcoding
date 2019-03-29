0032 – Adding Accelerator Keys to MenuItems

You say: Keyboard shortcuts… I say: Accelerator keys… [Let’s code the whole thing out]().

Lots of Keyboard Shortcut
Imports

First things first… We need the AccelGroup class and a couple of enums, so we bring them in:

import gtk.AccelGroup;
import gdk.c.types;

Make note, that’s another ‘gdk’ not ‘gtk’ library and from that library we get these enums:

AccelFlags

- VISIBLE (shows on the Menuitem), and
- LOCKED (can’t be remapped on the fly).

ModifierType

- SHIFT_MASK (Shift key),
- LOCK_MASK (usually the Caps Lock key),
- CONTROL_MASK (Control Key), and
- MOD1_MASK (usually the Alt key).

We’ll get to their use in a moment, but right now let’s take a quick look at…

The AccelGroup

This will be declared and instantiated in the Window class:

class TestRigWindow : MainWindow
{
	string title = "Multiple Menus Example";
	AccelGroup accelGroup;

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		accelGroup = new AccelGroup();
		addAccelGroup(accelGroup);

		AppBox appBox = new AppBox(accelGroup);
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		// do other exit stuff here if necessary
		
		Main.quit();
		
	} // quitApp()
	
} // TestRigWindow

Notice also that it gets passed to the AppBox constructor which passes it along to the MyMenuBar constructor, then FileMenuHeader, FileMenu, etc. down the line until it’s available to each individual MenuItem constructor like this:

class ExitItem : MenuItem
{
	string itemLabel = "Exit";
	char accelKey = 'x';
   
	this(AccelGroup accelGroup)
	{
		super(&doSomething, itemLabel, "activate", true, accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);
		//addOnActivate(&doSomething);
		
	} // this()
	
	
	void doSomething(MenuItem mi)
	{
		writeln("Quitting... Bye.");
		
		Main.quit();
		
	} // exit()
	
} // class ExitItem

Another thing to note: Because we pass the callback to the super-class instead of connecting it here. I left the addOnActivate() line there, but commented out. If you want to play around, uncomment it and see what happens.
Changes in How the Superclass Constructor is Called

The major departure from earlier examples is the call to the superclass. The arguments are as follows:

void delegate(MenuItem) dlg

This is exactly the same argument we would pass to a signal hook-up function.

string label

This is the text that’ll appear on the MenuItem.

string action

This takes the place of assigning a signal which is usually the “activate” signal when dealing with a MenuItem.

bool mnemonic

Just set this to true.

AccelGroup accelGroup

This is what we passed down from the RigTestWindow, the object containing a set of the keyboard shortcuts.

char accelKey

This is the letter key used in combination with ModifierType (the next argument) to designate the entire keyboard shortcut.

ModifierType.<MODIFIER>

This decides which qualifier key is held while pressing the letter key. These take the form of Modifier.CONTROL_MASK, and can be OR’ed together to get Control-Shift-<key>.

Here are the options you can use here:

ModifierType enum:

- SHIFT_MASK (Shift key),
- LOCK_MASK (usually the Caps Lock key),
- CONTROL_MASK (Control Key), and
- MOD1_MASK (usually the Alt key).

And lastly, the AccelFlags. This flag is optional and you can actually leave it out. The main form seems to be AccelFlags.LOCKED which is used if you don’t want people remapping the shortcut keys.

And that is it for this time. Until next time…

