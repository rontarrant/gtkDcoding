---
title: "0040: Dialogs VI - The MessageDialog"
topic: dialog
tag: dialog
layout: post
description: Using a standard GTK MessageDialog; we also cover enum flag locations and inherited functions - a D-language tutorial.
author: Ron Tarrant

---

# 0040: Dialogs VI - The MessageDialog

<div class="screenshot-frame">
   <div class="frame-header">
      Results of this example:
   </div>
   <div class="frame-screenshot">
      <figure>
         <img id="img0" src="/images/screenshots/013_dialogs/dialog_06.png" alt="Current example output">      <!-- img# -->
         
			<!-- Modal for screenshot -->
			<div id="modal0" class="modal">																	<!-- modal# -->
				<span class="close0">&times;</span>															<!-- close# -->
				<img class="modal-content" id="img00">															<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal0");														// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img0");															// img#
			var modalImg = document.getElementById("img00");													// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close0")[0];											// close#
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_06_term.png" alt="Current example terminal output">		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal1" class="modal">																				<!-- modal# -->
				<span class="close1">&times;</span>																		<!-- close# -->
				<img class="modal-content" id="img11">																		<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal1");																	// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img1");																		// img#
			var modalImg = document.getElementById("img11");																// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close1")[0];														// close#
			
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

	<div class="frame-footer">																								<!-- ------------- filename (below) --------- -->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_06_message.d" target="_blank">here</a>.
	</div>
</div>

As usual, take a gander at the import statements to see what’s changed there.

Most of the code in the example files, lately, has been support code, stuff needed so we can get at the topic of the day. Like this time, except for the `ClicheMessageDialog` (derived from `MessageDialog`) we’ve seen all this before, so let’s get right to the different bit:

```d
class ClicheMessageDialog : MessageDialog
{
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	ButtonsType buttonType = ButtonsType.OK;
	int responseID;
	string messageText = "It was a cliché love triangle,\nIt was heaven on Earth, but with hell to pay.\nA cliché love triangle,\nThey're as common as dirt, or so they say,\nA cliché love triangle,\nHe went off half-cocked and got blown away.";
```
	
## Initializations

I’m going to do things a little out of order here. We’ll talk about those flags in a moment, but the rest of this section is straightforward. We’ve got a `responseID` which a `Dialog` always needs and the fairly long message to stuff into the `MessageDialog`.

## The Constructor

```d
this(Window _parentWindow)
{
	super(_parentWindow, flags, messageType, buttonType, messageText);
	setTitle("Alert the User:");
	setSizeRequest(200, 150);
	addOnResponse(&doSomething);
	run();
	destroy();
	
} // this()
```

Unlike the other `Dialog`s we’ve worked with so far, we’ve derived a new class and so the constructor passes the list of arguments to the super-class. I did it this way to cut back on cumbersome function calls to the `MessageDialog`. If we did this without the derived class, instead of `setTitle()`, `setSizeRequest()`, etc. we’d be calling `myMessageDialog.setTitle()`, yada-yada-yada.

The point is, because of the derivation, we can do all this stuff in the constructor.

## The Callback

```d
	void doSomething(int response, Dialog d)
	{
		writeln("Dialog closed.");
		
	} // doSomething()
	
} // class ClicheMessageDialog
```

Nothing really worth talking about here. We’ve been here, done that, and (I don’t know about you, but I’ve) got the T-shirt.

But now let’s backtrack and talk about...

## enum Constants as Variables

I just wanna take a moment to explain this flag business. More and more in our examples, there are flags used to control various features of a widget. In today’s example, we’ve got:

- `GtkDialogFlags.MODAL`, and
- `MessageType.INFO`.

## Where to Find Flags

If you need the names and values of these flags, you can find them in the generated wrapper code files spit out by the *GtkD* build script on *Windows* (following the local configuration guide in [Blog Post #0000 – Introduction to gtkDcoding](/2019/01/11/0000-introduction-to-gtkDcoding.html)) which is in a folder named `generated\gtkd`. Where these folders reside may depend on where you downloaded the *GtkD* package or where you unzipped it and ran the `Build.d` script.

On *Linux*,  if you followed the guide in [Blog Post #X0002 - GtkD Linux Development Environment](/2019/03/31/x0002-gtkd-in-a-linux-environment.html) you can find them in `/usr/include/dmd/gtkd3/gtk/c/types.d`.

That's where the files will be found. More specifically, the flags are defined as enums in files (mostly) named types.d although some can be found in other wrapper code files named `XxxxXxxxT.d` or `XxxxxXxxxxIF.d` where `XxxxxXxxxx` is the camel-case name of a widget template or interface.

## How to Initialize an enum Value as a Variable

If you’ve never done this before, it could be a bit of a head-scratcher, but once you know the technique, it ain’t no big deal.

My first thought was that an `enum` is an `int` type variable and ultimately, that may be so, but you don’t initialize them that way. Instead, you declare them using the name of the `enum`, like this:

```d
GtkDialogFlags flags = GtkDialogFlags.MODAL;
MessageType messageType = MessageType.INFO;
```

From there, you can use the `flags` and `messageType` variables the same way you use any other.

But another thing you may have noticed is that one of these `enum` types has a `Gtk` prefix while the other doesn’t. Turns out that every `enum` in every `types.d` file is defined as `GtkXxxxx`, or `GdkXxxxxx`, or `GioXxxxxx`, etc., but is also aliased to simply `Xxxxx`.

So in the above example where you see `GtkDialogFlags`, you could also use `DialogFlags` and get the same results.

And a note of caution: `GtkDialogFlags` and `GioDialogFlags` are both aliased to `DialogFlags`. If you find yourself in a situation where you need to use both within the same module, I’d suggest using their long forms instead of the aliases. Even if these are designed not to clash, it’ll help you keep them straight.

## Inherited Functions

Another thing I’ve been meaning to talk about for a while is function inheritance. When a class is derived from another, it naturally inherits all the functions of the parent class. If you take another look at the constructor, you’ll see several examples:

```d
this(Window _parentWindow)
{
	super(_parentWindow, flags, messageType, buttonType, messageText);
	setTitle("Alert the User:");
	setSizeRequest(200, 150);
	addOnResponse(&doSomething);
	run();
	destroy();
	
} // this()
```

- `setTitle()` is inherited from the `Window` class,
- `setSizeRequest()` – also from `Window`,
- `addOnResponse()` comes from `Dialog`,
- `run()` – also from `Dialog`, and
- `destroy()` – again, from `Dialog`.

Keep that in mind when you wanna do some extra little thing with a widget. Take a look at its inheritance and check out all the functions and signals available to the parent class. And if that doesn’t give you what you need, take a look at the parent’s inheritance and so on all the way back to `ObjectG`, the great-great-grandparent of them all.

## Finding a Widget’s Family Tree

We talked earlier about a folder named `generated` and it’s sub-folder `gtkd` (or on *Linux*: `/usr/include/dmd/gtkd3/`) If you look at any of the wrapper modules found there, you’ll see something like (this is from `generated\gtkd\gtk\MessageDialog.d`):

```d
class MessageDialog : Dialog
```

`MessageDialog` inherits from `Dialog`. Now if you look at `Dialog.d`, you’ll see:

```d
class Dialog : Window
```

And in `Window.d`:

```d
class Window : Bin
```

And `Bin` inherits from `Container`, etc., etc. Thus you can trace your way back to `Widget` and you’ll then know all the most useful functions inherited from, and therefore usable as you write your code.

## Conclusion

And that’s it for yet another episode of *gtkDcoding*. Tune in next time when we’ll get into something I’m sure will wow you just as much as everything we covered today.

Bye, now.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/28/0039-file-save-as-dialog.html">Previous: SaveAs Dialog</a>
	</div>
	<div style="float: right;">
		<a href="/2019/06/04/0041-colorchooserdialog.html">Next: ColorChooserDialog</a>
	</div>
</div>
