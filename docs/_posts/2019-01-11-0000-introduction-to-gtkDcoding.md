---
title: "0000: Introduction to GtkDcoding"
layout: post
topic: window
description: An introduction to GTK 3 and how it can be used to create Graphical User Interfaces (GUI) for applications - a D language tutorial.
author: Ron Tarrant
---

# 0000: Introduction to GtkDcoding

*Where All This is Coming From...*

Ever since the heyday of 8-bit computers and *Microsoft BASIC* — which was available on almost every one of them — programmers  have been pursuing the goal of cross-platform development... write once, compile for m/any. These days, there’s *Java* and *Electron* if you’re so inclined, but I prefer something that compiles to a native executable using a single programming language. When I found *D*, I realized I might just have found what I was looking for.

*GtkD* is a wrapper for *GTK+*, a GUI toolkit originally from the world of Linux, an almost-POSIX-compliant OS, but now available across a number of operating systems. That pretty much makes it perfect for my intentions. By learning how to use a single language compiler (*dmd2*) I can build and run applications on *Windows*, *Linux*, *Mac*, and *FreeBSD*. With *GTK+* thrown in, we’re looking at a single-code-base solution to cross-platform development.

I’ve been writing code in more than a dozen languages since 1985 and I’ve also worked with *GTK+* in some of those languages, but I’m coming into this as a *D* rookie. This blog is my exploration of *D* and *GtkD* as I work out how to code various widgets and build a thorough understanding of it all.

## Why D?

The third language I learned back in the day was *C* and I fell in love with its power and elegance. Along the way, I also grew fond of curly braces—although I can't say why. *D*, being a descendant of *C*, drives right up my street and since *D* incorporates a handful of paradigms, it's even more appealing:

- imperative,
- OOP,
- meta-programming,
- functional,
- parallel, and
- concurrent, but...

I’m a sucker for object-oriented program development, so I'll be concentrating on that for the most part. I’ll start with a few imperative examples, but then it’ll be OOP all the way.

## Why OOP?

*D* and *GtkD* both lend themselves well to an object-oriented approach to coding. The imperative examples will get you heading in that direction if it’s where you want to go, but I much prefer a full-on OOP approach.

## Blog Conventions

**Widgets:** For the sake of clarity, each example will demonstrate just one widget unless it’s something that needs extra widgets to work.

**Format:**

All code is formatted in this way:

- import statements are at the top of the file,
- all curly braces, opening and closing, have their own line,
	- except where delegates are defined,
- lots of white space to make things easy to read, 
- variables are declared at the tops of functions or classes, and
- comments point out code not covered in previous examples.

## What You’ll Need

First, a *D* compiler. I’m using *dmd*, the official reference compiler, throughout. You can find it on the [Downloads page of the dlang.org web site](https://dlang.org/download.html).

Second, you’ll want the latest *GTK+* runtime. This as well as the [GtkD.zip](https://gtkd.org/Downloads/sources/GtkD-3.9.0.zip) file can be downloaded from [the official GtkD website (maintained by Mike Wey)](https://gtkd.org/download.html).

For now, I’m working on *Windows* and that’ll be reflected herein as well, although I’ve done a bit of preliminary work with *FreeBSD*, so I suspect all these examples will compile without trouble on any OS where *D*, *GtkD*, and a *GTK+* runtime are available. Once I’m reoriented to the POSIX world, I’ll make sure everything works there, too. If you find any situation where you can’t compile and run these examples, please let me know.

### Installation of the Development Environment

Install the reference compiler and the *GTK+* runtime. Best to accept the default locations:

- The *GTK+* runtime will install in `C:\Program Files\gtk-runtime`, and
- The *D* compiler will install in `C:\D` although most of the action will be in `C:\D\dmd2`.

So go ahead and get those installed and I’ll wait here...

### Local Configuration

There are two more things we need to do before we can get down to it. Open the directory (folder, in Windows speak) where the `dmd` binary lives. If you accepted the defaults, it’ll be in:

```
C:\D\dmd2\windows\bin\
```

Find the file:

```
sc.ini
```

and open it in a text editor.

Look for the `[Environment]` section’s `DFLAGS` variable and:

- type a space at the end of the line,
- copy and paste (or type) this after the space, including the quotes:

```
"-I%@P%\..\..\src\gtkd"
```

Now you need to copy the *GtkD* wrapper files to where the compiler can find them:

- unzip [GtkD-3.9.zip](https://gtkd.org/Downloads/sources/GtkD-3.9.0.zip) (the version numbers may differ by the time you read this, but that’s fine),
- from the `gtkd-3.9\generated` directory, copy the `gtkd` directory to:

```
C:\D\dmd2\src\
```

Thirdly, you’ll build and install the *GtkD* library...

Open a command prompt and make your way to where you unzipped `GtkD-3.9` (you’re in the right place if typing `dir` shows you a file named `Build.d`), and build the library with the command:

```
rdmd –m64 Build.d
```

unless you’re on a 32-bit OS, then use:

```
rdmd Build.d
```

without the 64-bit flag,

Two .lib files will appear right there in the top level directory. Copy them to:

```
C:\D\dmd2\windows\lib64\
```

for a 32-bit OS, it’ll be:

```
C:\D\dmd2\windows\lib\
```

### Troubleshooting Build.d

If you get a message saying that `msvcr100.dll` cannot be found, you'll have to do a little extra. This usually happens when, during the installation of *DMD*, you opt for *Visual Studio* support, but you don't actually install (or already have installed) *Visual Studio*.

Anyway, if this error appears, go to the [Visual Studio Redistribute Package download page](https://www.microsoft.com/en-us/download/confirmation.aspx?id=14632), download the appropriate version, and install it. Then you should be good to go.

And that should be that. You should be ready to dance the D-dance.

## Base Test Rig

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/001_window/window_001_01.png" alt="Current example output">	<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal0" class="modal">																								<!-- modal# -->
				<span class="close0">&times;</span>																					<!-- close# -->
				<img class="modal-content" id="img00">																					<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal0");																			// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img0");																				// img#
			var modalImg = document.getElementById("img00");																		// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close0")[0];															// close#
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function()
			{ 
				modal.style.display = "none";
			}
			</script>
			<figcaption>
			Current example output
			</figcaption>
		</figure>
	</div>

	<div class="frame-terminal">
		<figure class="right">
			<img id="img1" src="/images/screenshots/001_window/window_001_01_term.png" alt="Current example terminal output"> <!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal1" class="modal">																												<!-- modal# -->
				<span class="close1">&times;</span>																										<!-- close# -->
				<img class="modal-content" id="img11">																									<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal1");																							// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img1");																								// img#
			var modalImg = document.getElementById("img11");																						// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close1")[0];																				// close#
			
			// When the user clicks on <span> (x), close the modal
			span.onclick = function()
			{ 
				modal.style.display = "none";
			}
			</script>

			<figcaption>
				Current example terminal output (click for enlarged view)
			</figcaption>
		</figure>
	</div>

	<div class="frame-footer">																																<!-- filename (below)-->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_01_base.d" target="_blank">here</a>.
	</div>
</div>

For now, you can copy this code (I highly suggest you type it out unless you’ve got an eidetic memory) and look for the compile instructions below:

```d
import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	MainWindow testRigWindow = new MainWindow("Test Rig");
	testRigWindow.addOnDestroy(delegate void(Widget w) { quitApp(); } );
	
	writeln("Hello GtkD Imperative");

	// Show the window and its contents...
	testRigWindow.showAll();
		
	// give control over to the gtkD .
	Main.run();
	
} // main()


void quitApp()
{
	// This exists in case we want to do anything
	// before exiting such as warn the user to
	// save work.
	writeln("Bye.");
	Main.quit();
	
} // quitApp()
```

Save this as `test_rig_imperative.d` (or whatever you want, really) and compile it thusly:

```
dmd –de –w –m64 –Lgtkd.lib test_rig_imperative.d
```

After correcting typos so the compiler finishes, type the name without an extension (or you can include the .exe extension if you’re on Windows) to run it. If you're on Linux or any other POSIX-compliant OS, don't forget to prepend `./` to the file name (`./test_rig_imperative`) or type out the full path.

And that’s it for now. Next time, we’ll break down the test rig code so you know what’s going on in there. Then I’ll show you the same functionality in an OOP version of the test rig.

Until then, happy D-coding and may the widgets be with you.

<div class="blog-nav">
	<div style="float: right;">
		<a href="/2019/01/15/0001-imperative-test-rig.html">Next: Introduction to the Test Rig</a>
	</div>
</div>
