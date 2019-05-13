---
title: 0027 – Mnemonics – Shortcut Keys
layout: post
description: How to do set up keyboard shortcuts for GTK MenuItems - a D language tutorial.
author: Ron Tarrant

---

## 0027 – Mnemonics – Shortcut Keys

Today, we’ll cover two quick subjects, adding keyboard shortcuts to `MenuItem`s and separating menus into two areas. Let’s get at it.

### Mnemonic Shortcut Keys

There are two ways to set up a keyboard shortcut for a `MenuItem`. Both start with the call to `MenuItem`’s constructor, but one passes three arguments while the other passes only two.

[Here’s the example file containing both processes](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_07_mnemonic.d).

#### The Two-step Process

The code for creating this `MenuItem` with its shortcut key looks like this:

	class NewFileItem : MenuItem
	{
		string newFileLabel = "_New";
	   
		this()
		{
			super(newFileLabel, true); // true turns on the mnemonic
			addOnActivate(&newFile);
			
		} // this()
		
		
		void newFile(MenuItem mi)
		{
			writeln("New file created.");
			
		} // newFile()
		
	} // class NewFileItem

There are two things here that are different from our earlier examples:

- our constructor passes along an extra Boolean argument, and
- the `newFileLabel` text has an underscore in front of the ‘N.’

The extra argument (`true`) tells the super-class constructor to turn on the mnemonic for this `MenuItem`.

The underscore (`_`) decides which key, combined with ***Alt***, will activate the `MenuItem`.

And from there, it’s business as usual. Except that…

The `FileMenuHeader` also has a mnemonic. Have a peek:

	class FileMenuHeader : MenuItem
	{
		string headerTitle = "_File";
		FileMenu fileMenu;
		
		this()
		{
			super(headerTitle);
			
			fileMenu = new FileMenu();
			setSubmenu(fileMenu);
			
			
		} // this()
		
	} // class FileMenu

If you want a mnemonic on a `MenuItem`, you need a mnemonic on the `Menu`, too. It won’t show when your application is running (more’s the pity) and you don’t need to turn it on by passing a Boolean to the `MenuItem` that acts as a menu header, but the underscore does have to be there.

#### The One-step Process

With this method, a pointer to the callback is passed to the super-class along with the mnemonic label text and the Boolean switch:

	class ExitItem : MenuItem
	{
		string exitLabel = "E_xit";
	   
		this()
		{
			super(&exit, exitLabel, true);
			
		} // this()
		
		
		void exit(MenuItem mi)
		{
			Main.quit();
			
		} // exit()
		
	} // class ExitItem

Notice also that the underscore isn’t under the first letter in the Label text, indicating that any one of the letters in the text `Label` can be used as the shortcut key.

## Separators

This is just about the easiest thing to do in *GtkD*. Pick the spot for the separator and:

	SeparatorMenuItem separator = new SeparatorMenuItem();
	append(separator);

No muss, fuss, or foaming at the mouth, and [here's the code file to prove it](https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_08_separator.d).

## Conclusion

Well, that’s that. Mnemonic shortcut keys and separators… Yup.

Bye, now.

