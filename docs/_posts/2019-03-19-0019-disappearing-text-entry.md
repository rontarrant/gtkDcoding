# 0019 Disappearing Entry Text and Font Selection

Today’s examples are quite unrelated. The only reason they appear in the same blog post is because my mind skipped from disappearing text Entry boxes to font selection. I don’t know why and it really doesn’t matter, so let’s just get on with it.

Here are the code files:

- [Disappearing Entry box](https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_04_disappearing_entry.d), and
- [Font selection button](https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_05_fontbutton.d).

## Disappearing Entry

Because the `TextRigWindow` class does a drill-down into the Entry to grab the text, I’ll start with the `Entry` and work backwards to `TextRigWindow`’s `endProgram()` function so as to keep things in context.

Firstly, we’re stuffing our two widgets—a text `Entry` and a `CheckButton`—into a Box and because we want to do that drill-down I mentioned, the `Box` will be manifested in the `EntryBox` class. This allows us, as we’ve done before, to use variables to access the widgets in the `Box`:

	Entry entry;
	CheckButton checkButton;

We also have the padding and the `CheckButton` label text here:

	int padding = 5;
	string checkText = "Visible";

The constructor is very much the same as so many other example we’ve already examined:

	this()
	{
		super(Orientation.VERTICAL, padding);
		
		entry = new Entry();
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&entryVisible);
		checkButton.setActive(true);
				
		add(entry);
		add(checkButton);
		
	} // this()

First we create the `Box`, passing along the orientation and padding we want, then create the widgets. Hook up the `onToggled` signal and set the default state of the `CheckButton` so it’s checked. Dump them into the box and off we go.

### The Callback Function

It looks like this:

	void entryVisible(ToggleButton button)
	{
		string[] state = ["invisible", "visible"];
		
		entry.setVisible(button.getActive());
		writeln("The Entry field is now ", state[button.getActive()]);
		
	} // entryVisible()

This should be familiar by now, too. The message we'll be writing to the command shell is built from bits and pieces:

- a string array with descriptions of the two states,
- the live state of the `CheckButton` which we'll use to pick from the above-mentioned array, and
- a sentence fragment used as an argument in the `writeln()` function itself followed by a second argument where we do the picking.

That’s one down. Now let’s look at…

## The Font Button Example

This one is so straightforward, it almost doesn’t need any explanation. And the reason is that **GTK**’s `FontButton` wears its heart on its sleeve, so to speak. The selected font and its size show up on the button itself. Click the button and a list of fonts appears along with a set of sizing widgets. Jammed in between the font list and the sizing widgets is an `Entry` field where you can type example text so you know exactly what you’re getting into when you select a font.

But all I’ve talked about here is just what the `FontButton` does. What about the code?

It’s so dead simple as to be almost laughable. The only thing I’ll point out is that the `TestRigWindow`’s `endProgram()` function grabs the currently-selected font along with it’s weight and size and dumps all this info to the command shell.

	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", fontButton.getFontName());
		
	} // endProgram()

And that’s two down.

Next time, I’ll introduce you to images on buttons and how to swap them. Until then, happy D-coding and may you find a less tired cliché than I have in these blog posts.

