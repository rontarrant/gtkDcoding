---
title: 0035 – The About Dialog
layout: post
description: How to use a GTK AboutDialog - a D-language tutorial.
author: Ron Tarrant

---

## 0035 – Help/About – a Dialog

Starting today, and for the next few weeks, we'll be looking at `Dialog` windows of various types. We'll get started with one of the simpler ones, the AboutDialog, but to make it more interesting, we'll toss in a `Pixbuf`. [Here’s the code]( https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_01_help_about.d).

Let's get going by checking out…

### The Imports

These are the ones we haven’t worked with yet:

	import gtk.AboutDialog;
	import gdk.Pixbuf;

Okay… `main()` is the same and we've seen `TestRigWindow` more than 30 times, and these aren't new, either:

- `AppBox`,
- `MyMenuBar`,
- `HelpHeader` (except for the name, anyway), and
- `HelpMenu`.

And that brings us to…

### The AboutItem

We have a ton of string tied around the initialization section and maybe that's so the other stray items don't wander off:

	string itemLabel = "About";
	string sectionName = "Them What Done Stuff";
	string[] people = ["Laurence Find", "Jerome Hayward", "Dick van Puddlesopper"];
	string[] artists = ["Alice Warhol", "Salvador Deli", "My Brother-in-law, Bill"];
	string comments = "This is a fine bit of software built for the rigors of testing dialog windows.";
	string[] documenters = ["Billy Buck Thorndyke", "Phil Gates"];
	string license = "This is a FOSS Budget build of a GNOLD project";
	string programName = "About Dialog Demo";
	string protection = "Copywrong 2019 © The Three Stool Pigeons";
	Pixbuf logoPixbuf;
	string pixbufFilename = "images/logo.png";
	Window parentWindow;
	AboutDialog aboutDialog;

You could probably leave most of these strings empty, especially if you don't work with a team, but I filled all these in for demonstration purposes.

But as I breezed through that list of classes that hadn’t changed, there actually was one change worth mentioning…

#### Passing Down the Window

Because the `AboutDialog` (or any other dialog) needs to know who its mommy is, we gotta give it an ersatz family tree, passing down the `Window` pointer so when the `Dialog` goes up, it can go `MODAL` if it needs to. If you take a quick look through the code, you'll see this is done very much the same way we passed along the `AccelGroup` in Blog Post #32 - [Adding Accelerator Keys to MenuItems](http://gtkdcoding.com/2019/05/03/0032-accelerator_keys.html).

*Note: if you want your `Dialog` to be `MODAL`, use `DialogFlags.MODAL` which can be found in `generated/gtkd/gtk/c/types.d`.*

### Hooking up the MenuItem

In the constructor, we do this:

	this(Window extParentWindow)
	{
		super(itemLabel);
		addOnActivate(&doSomething);
		parentWindow = extParentWindow;
		
	} // this()

Like any other `MenuItem`, we instantiate and hook up the callback, but then we have one more step. We assign the local pointer to the parent Window so we can use it in the callback.

The callback is quite busy:

	void doSomething(MenuItem mi)
	{
		int responseID;
		
		writeln("Bringing up dialog...");
		
		logoPixbuf = new Pixbuf(pixbufFilename);
		
		// Although it seems we should do all this config stuff in this()
		// it has to be done here.
		AboutDialog aboutDialog = new AboutDialog();
		aboutDialog.setAuthors(people);
		aboutDialog.setArtists(artists);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setCopyright(protection);
		aboutDialog.setArtists(artists);
		aboutDialog.setComments(comments);
		aboutDialog.setLicense(license);
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setTransientFor(parentWindow);
		
		aboutDialog.run();
		aboutDialog.destroy();
		
	} // doSomething()

We need a `responseID` for any dialog, even if we ignore it like we do here. As we move deeper into dialogs, we'll come back to this variable and look at it more closely.

And there's the `Pixbuf` I mentioned. Here, it's used to show off the gtkDcoding logo.
 
Then we instantiate the dialog:

	AboutDialog aboutDialog = new AboutDialog();

Fill in all the fields:

		aboutDialog.setArtists(artists);
		aboutDialog.setAuthors(people);
		aboutDialog.setComments(comments);
		aboutDialog.setCopyright(protection);
		aboutDialog.setDocumenters(documenters);
		aboutDialog.setLicense(license);
		aboutDialog.setLicenseType(licenseType);
		aboutDialog.addCreditSection(sectionName, people); // shows when the Credits button is clicked
		aboutDialog.setProgramName(programName);
		aboutDialog.setLogo(logoPixbuf);
		aboutDialog.setLogoIconName(logoIconName);
		aboutDialog.setVersion(productVersion);
		aboutDialog.setWebsite(website);
		aboutDialog.setWebsiteLabel(websiteLabel);
		aboutDialog.setTransientFor(parentWindow);

*Note: There may be a bug in* GTK *that (apparently) stops the website link from working with some operating systems.* Mac *was mentioned as one that falls victim to this, but it does work with Windows (it does, however, spit out a warning). I haven't tried it with* Linux.

And finally, we open it:

	aboutDialog.run();

And the last statement doesn’t get called until the dialog closes and program control comes back to this object (the `AboutMenuItem` object):

	aboutDialog.destroy();

All this does is destroy everything we built. And if the `Dialog` gets opened again? The entire dialog is rebuilt from scratch.

## Conclusion

And that was a quick look at a simple `Dialog`. As we go along, things could get complicated, especially when we dig into rolling our own dialog from scratch. Now, that will be an adventure.

Until next time… bye.
