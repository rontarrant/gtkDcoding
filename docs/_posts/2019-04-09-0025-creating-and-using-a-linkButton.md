---
title: "0025: Creating and Using a LinkButton"
topic: button
layout: post
description: How to use a GTK LinkButton, with and without a visible URL - a D language tutorial.
author: Ron Tarrant

---

## 0025 - Creating and Using a LinkButton

Today’s buttons are simple, a button to click to follow a link and another one with a pretty face and a link. So, what’s the difference?

### A LinkButton

[Here's the first code example](https://github.com/rontarrant/gtkDcoding/blob/master/011_odd/odd_011_01_linkbutton.d).

At its simplest, a `LinkButton` has a link that takes the user to a website. And on its face, the `LinkButton` shows the URL for that site.

And because this example is so simple, I’ve dumped it all into the `TestRigWindow` object:

	class TestRigWindow : MainWindow
	{
		string title = "LinkButton example";
		string link = "http://gtkDcoding.com";
		string message = "The text entry box holds: ";
		LinkButton linkButton;
		
		this()
		{
			super(title);
			addOnDestroy(&endProgram);
			
			linkButton = new LinkButton(link);
			add(linkButton);
			
			showAll();
			
		} // this()
		
		
		void endProgram(Widget w)
		{
			writeln(message, linkButton.getUri());
			
		} // endProgram()
		
	} // class TestRigWindow

Nothing to it, really, define the link, instantiate the `LinkButton` object, add it, and the rest is taken care of for you. You won’t have to figure out anything else because it hooks into the OS to grab the default browser and passes it the URL.

But what if you don’t want the URL to show on the button? Perhaps your URL is something long and ugly or you want to take the user to a specific page that would end up looking like:

	http://gtkdcoding.com/2019/01/11/0000-introduction-to-gtkDcoding.html

That ain’t gonna look so pretty on a button, so you might instead consider…

### A LinkButton with a Pretty Face

Not a lot changes. [Have a look at the code file](https://github.com/rontarrant/gtkDcoding/blob/master/011_odd/odd_011_02_linkbutton_labeled.d) or just look at this:

	class TestRigWindow : MainWindow
	{
		string title = "LinkButton example";
		string link = "http://gtkDcoding.com";
		string linkText = "GTK D-coding";
		string message = "The text entry box holds: ";
		LinkButton linkButton;
		
		this()
		{
			super(title);
			addOnDestroy(&endProgram);
			
			linkButton = new LinkButton(link, linkText);
			add(linkButton);
			
			showAll();
	
		} // this()
		
		
		void endProgram(Widget w)
		{
			writeln(message, linkButton.getUri());
			
		} // endProgram()
		
	} // class TestRigWindow

It’s all in the arguments sent to `LinkButton`’s constructor:

- Send it one argument, a URL, and it’s happy to slap that onto the face of the button.
- Send it two arguments, a URL and a nicely-formatted string, and that button ends up all cute and cuddly.

On the downside, the `LinkButton` spits out a warning to the *Command Prompt* window every time you use it. My research has turned up no reasonable explanation and it’s been going on since the release of *GTK 3.0*. The good news is that the message is of no consequence and it seems safe to ignore.

And that’s it for this time, a short post for a short day. Come on back again sometime.


<BR>
<div style="float: left;">
	<a href="/2019/04/05/0024-switch-and-light-switch.html">Previous: Switch</a>
</div>
<div style="float: right;">
	<a href="/2019/04/12/0026-menu-basics.html">Next: Menu Basics</a>
</div>
<BR>
