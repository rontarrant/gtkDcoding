---
topic: text
layout: post
description: How to obfuscate text in a GTK Entry widget and how to make it non-editable - a D language tutorial.
author: Ron Tarrant

---

## 0018 - Variations on a Text Entry Widget

Let’s move away from buttons for the moment, both mouse and GUI, and look at the `Entry` widget… yeah, the one used for gathering a small bit of text from the user.

This is pretty much the easiest widget to use and the code amounts to this:

	entry = new Entry();
	add(entry); // depending on the container type, of course

And to bring the entered text into your program is dead simple:

	entry.getText()

Assign it to a variable, stick it in a `writeln()` function, whatever’s your poison. [And here’s the full code](https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_01_entry.d).

Moving right along…

### Non-editable Entry

[The code for the second example can be found here](https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_02_no_edit_entry.d).

Sometimes, you may want the user to enter text, but once it’s entered, you don’t want it changed. In this example, I’ve set up a `CheckButton` to control editability:

	class EntryBox : Box
	{
		int globalPadding = 5;
		Entry entry;
		CheckButton checkButton;
		string checkText = "Editable";
		
		this()
		{
			super(Orientation.VERTICAL, globalPadding);
			entry = new Entry();
			entry.setEditable(false);
			
			checkButton = new CheckButton(checkText);
			checkButton.addOnToggled(&entryEditable);
			checkButton.setActive(false);
					
			add(entry);
			add(checkButton);
			
		} // this()
		
		
		void entryEditable(ToggleButton button)
		{
			entry.setEditable(button.getActive());
			
			if(button.getActive() == true)
			{
				writeln(checkText);
			}
			else
			{
				writeln("Not ", checkText);
			}
			
		} // entryEditable()
	
	} // class EntryBox

Rather than sub-classing the `Entry` and `CheckButton`, I used a sub-class of `Box` as a way to track the data and hand it around as needed. In effect, the `Box` acts as a parent handing out the goodies.

Note that both the `Entry` and `CheckButton` states are set to `false` which means if you compile and run this example, you won’t be able to type into the `Entry` until you check the `CheckButton`.

### Obfuscation

Now let’s think about what else text `Entry` widgets are used for. One thing that comes to mind is collecting login information. In our third example, we’ll mimic a login with a `Username` field left in the clear (readable, in other words) and an obscured `Password` field. The `LoginBox` class serves as the parent handing out candy, so we need an extra `Entry` widget with `Visibility` set to `false`, which means our constructor now looks like this:

	this()
	{
		super(Orientation.VERTICAL, globalPadding);

		usernameEntry = new Entry();
		passwordEntry = new Entry();
		passwordEntry.setVisibility(false);
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&passwordVisibility);
		checkButton.setActive(false);
		
		add(usernameEntry);
		add(passwordEntry);
		add(checkButton);
		
	} // this()


We set `Visibility` to `false` for the `Password` `Entry` and then in the callback function `passwordVisibility()`, we make allowances for finding either `true` or `false`:

	void passwordVisibility(ToggleButton button)
	{
		string messageEnd;
		
		bool answer = button.getActive();
		
		if(button.getActive() == true)
		{
			messageEnd = " I can shoulder-surf your password.";
		}
		else
		{
			messageEnd = " I canNOT shoulder-surf your password.";
		}
		
		passwordEntry.setVisibility(button.getActive());
		writeln("With ", button.getLabel(), " set to ", button.getActive(), messageEnd);
		
	} // passwordVisibility()

And just before the callback finishes up, we cobble together a message for the user about computer security. I could tell you what the messages say, but I think it’ll be more educational if you compile [the code for the obfuscated Entry example](https://github.com/rontarrant/gtkDcoding/blob/master/006_text/text_006_03_obfuscated_entry.d) and run it yourself.

Next time, we’ll continue with two more variations on the `Entry` widget. Until then, happy D-coding and may the `Widgets` find room in your top pocket.


<BR>
<div style="float: left;">
	<a href="https://gtkdcoding.com/2019/03/12/0017-change-pointer.html">Previous: Mouse Pointer</a>
</div>
<div style="float: right;">
	<a href="https://gtkdcoding.com/2019/03/19/0019-disappearing-text-entry.html">Next: Disappearing Text Entry</a>
</div>
<BR>
