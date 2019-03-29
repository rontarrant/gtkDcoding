0033 – An Image, a Label and an AccelKey

Remember how I said that the GTK ImageMenuItem is deprecated? And with it went the easy way to add an accelerator key to a MenuItem that also sported its own image?

Well, forget all that. We can fake this. Here the code and her goes nothing…

Don’t Forget to Add AccelGroup to Your Window

Because if you do forget, nothing’s gonna work. Here’s TestRigWindow’s constructor:

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

Such an important line: addAccelGroup(accelGroup);

Add the Fake ImageMenuItem to the Menu

This really hasn’t changed since last time we did a fake image MenuItem:

class FileMenu : Menu
{
	FakeImageMenuItem appleItem;
	ExitMenuItem exitMenuItem;
	
	this(AccelGroup accelGroup)
	{
		super();
		
		appleItem = new FakeImageMenuItem(accelGroup);
		append(appleItem);
		
		exitMenuItem = new ExitMenuItem(accelGroup);
		append(exitMenuItem);

	} // this()
	
	
} // class FileMenu

The All-new Fake Image MenuItem

This is the mouthful of code you’ll need to chew on to get this working:

class FakeImageMenuItem : MenuItem
{
	string actionMessage = "You have added one (1) apple to your cart.";
	Box imageMenuBox;
	string labelText = "Buy an Apple";
	string imageFilename = "images/apples.jpg";
	Image image;
	AccelLabel accelLabel;
	char accelKey = 'a';
   
	this(AccelGroup accelGroup)
	{
		super();
		addOnActivate(&reportStuff);
				
		imageMenuBox = new Box(Orientation.HORIZONTAL, 0);
		add(imageMenuBox);

		image = new Image(imageFilename);

		accelLabel = new AccelLabel(labelText);
		accelLabel.setXalign(0.0);
		accelLabel.setAccelWidget(this);
		
		addAccelerator("activate", accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);

		imageMenuBox.add(image);
		imageMenuBox.packEnd(accelLabel, true, true, 0);
	
	} // this()
	
	
	void reportStuff(MenuItem mi)
	{
		writeln(actionMessage);
		
	} // exit()
	
} // class FakeImageMenuItem

There’s a lot going on here, but skipping over the bits we’ve covered in earlier posts, here’s what’s new or unusual:

First is this line:

addOnActivate(&reportStuff);

I bring this to your attention because in the previous example of accelerator keys, we didn’t need this line. But this time, we do and we’ll see why in a moment.

After that we:

- create the Box,
- stuff the Box into the MenuItem (container, remember?),
- we build an Image,
- and a Label…

Not a Label, an AccelLabel. And why? Because we have to do all these extra bits of twiddling to get this to work:

accelLabel.setXalign(0.0);
accelLabel.setAccelWidget(this);


The Xalign() call gives us room in the Box so the accelerator key (that’s Ctrl-A) won’t overlap the Label.

And then the AccelLabel needs to know which Widget to pair up with. In this case, it’s the FakeImageMenuItem (which is really a MenuItem).

Now with this line, we get to the other half of why we still need to hook up the signal:

addAccelerator("activate", accelGroup, accelKey, ModifierType.CONTROL_MASK, AccelFlags.VISIBLE);

When we added accelerators the other way (which I’ve done in this example with the Exit MenuItem so you have both close to hand for comparison) we did it via an overload call to the superclass.

But here, we can’t because the work is delegated to several widgets. So we use the addAccelerator() function instead.

Now another crucial thing to bear in mind: When you pack the Image and the AccelLabel into the Box, you have to add() the image and packEnd() the AccelLabel, which is these lines:

imageMenuBox.add(image);
imageMenuBox.packEnd(accelLabel, true, true, 0);

And that just about sums up today’s exploration of accelerator keys and imagery on menus. Be kind to each other and we’ll talk again.

