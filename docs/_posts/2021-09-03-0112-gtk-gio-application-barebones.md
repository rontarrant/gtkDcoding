---
title: "0112: GTK GIO Applications - Introduction"
layout: post
topic: button
description: This GTK Tutorial covers a D-specific implementation of Scale Widget controlling placement of a graphic element.
author: Ron Tarrant

---

# 0112: GTK GIO Applications - Introduction

Up ‘til now, every example has been built up from a `MainWindow` widget and a `Main` struct, both of which are instantiated in the standard entry point function, `main()`. (*Note: `TestRigWindow`—the actual object we've been instantiating in our examples—inherits from `MainWindow`, so it amounts to the same thing.*) But today, we’re looking at an alternative way of building applications, this time using the *GTK/GIO* `Application` class modules.

I’d like to point out that I didn’t stutter in that last sentence. There are two `Application` modules... the *GIO* `Application` is the parent class and the *GTK* class is derived from it. This can be a bit confusing when it comes time to write code because both modules need to be imported if we want to handle *GIO* signals. But, there’s a simple way to keep them straight, so let’s just dive in.

## Why Application?

The `Application` is a more flexible framework for writing software. It doesn’t just give us the tools for building classic GUI-based software, it makes several other project types possible:

-	a GUI front-end for a background service,
-	the background service itself,
-	remote applications controlled locally,
-	local applications controlled remotely, and
-	a GUI-less command line application (the kind intended to be run from a terminal).

On top of that, a *GIO* `Application` has a signal/callback system that gives us all kinds of flexibility in how we start up our application.

Finally, it also gives us a system of flags we can use for all kinds of stuff including:

1. designating the application as a service,
2. passing in parameters to modify the behaviour of the running software, or
3. react to the existence of environment variables on the computer where the application is running.

## Old Method vs. New

The biggest difference between the `MainWindow` approach and this one is this...

In the `Application` paradigm, signals are used to associate callbacks with such things as `activate`, `startup`, and `shutdown`. In the paradigm we've been using 'til now, `Main.init()`, `Main.run()`, and `Main.quit()` (respectively) take care of these things. Nothing new is going on here, but responsibility for application-level stuff has shifted from a *C*-style struct (`Main`) to a *D*-style object (`Application`). 

### MainWindow vs. ApplicationWindow

In the classical construction method, `MainWindow` acts as a top-level container for our program, but the *GTK/GIO* `Application` instead uses the `ApplicationWindow` as its primary UI container. They both inherit from `Window`, so we still get pretty much the same functionality. But the *GTK/GIO* `Application` construction method adds such things as window `ID`s, a pop-up help window for keyboard shortcuts, and a mechanism to handle how and when a `Menu` or `Menubar` is displayed. More on these as we go along, but for now, let’s dig into a barebones example...

## Working with GIO/GTK Applications

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/020_app/app_020_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/020_app/app_020_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_01_barebones.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

Right up front, naturally, we need to do some imports to get all this working. But because the *GTK* and *GIO* modules are both named `Application`, we need to put some extra effort into keeping them straight. That’s done with *D*’s aliasing feature:

```d
import gio.Application : GioApplication = Application;
import gtk.Application : GtkApplication = Application;
import gtk.ApplicationWindow;
```

Alias names are up to you, of course, but for this demonstration, I’m emphasizing clarity of function.

### How main() Differs

In the classical construction method, our `main()` function had to do a few things before handing control over to the `Main` `struct`... I’m pointing this out because, as it turns out, `Main` is a `struct`, not a `class`. It’s the reason we don’t sub-class it into `MyMain` or some-such in order to move its definition outside of the `main()` function.

With the *GTK/GIO* `Application` construction method, however, we don’t have this restriction, so `main()` only has to do one thing, instantiate the *GTK* `Application` object:

```d
void main(string[] args)
{
	MyApplication thisApp = new MyApplication(args);
	
} // main()
```

Note that it passes any command-line arguments along to the `MyApplication` constructor, another change from the old way of doing things in which we passed them to `Main.init()`. And keep in mind, `MyApplication` is derived from the *GTK* `Application` object, not its *GIO* namesake.

Speaking of which, let’s have a look at this sub-class...

### MyApplication, a GTK Application Lovechild

The preamble looks like this:

```d
class MyApplication : GtkApplication
{
	ApplicationFlags flags = ApplicationFlags.FLAGS_NONE;
	string id = null; // if application uniqueness isn't important
```

In order to call the super-class constructor, we need two things:

- one or more flags to set up the `Application`’s type and abilities, and
- an `ID` in the form of a string.

Now, you’ll note that this particular example has `id` set to `null`. That's because, if we really don't care about `Application` uniqueness, we don't have to supply an `ID`. In the next example, we’ll talk more about this, but for now, let’s move on to...

### The MyApplication Constructor

This is where we set up the `Application` and get things going:

```d
this(string[] args)
{
	super(id, flags);
	addOnActivate(&onActivate);
	run(args);
		
} // this()
```

The first line isn’t all that different from what we’re used to. We call the super-class constructor, passing it the `id` and `flags` variables. In this example, because `id` is `null` and our `flags` variable is `NONE`, we aren’t asking anything of the super-class constructor except to start the application.

The next line, however, is a departure from the old method we’ve been using. I’m sure you recognize the function naming convention even if you don’t know the `addOnActivate()` function itself. It’s a signal hook-up, as you’ve likely already guessed. Why it’s there is because (and you might wanna make an extra-large mental note of this):

*Application actions are processed via signals and callbacks.*

This means the *GIO/GTK* `Application` construction approach brings external operations directly under the control of a single, high-level entity, the `Application` object. I’m talking about things like window and accelerator management... or OS-related tasks such as handling command-line arguments, starting up, shutting down... In other words, because the uppercase-A `Application` handles all things external, the lowercase-a application doesn’t need to be aware of them. There’s no mixing of internal and external operations and therefore better separation of code.

Looking at the last line, we find another way this new application construction method differs from the old. The command-line arguments—instead of being passed to an `init()` function—are passed to the `run()` function.

What’s the difference? Not much, actually. Both `Main.init()` and `Gio.Application.run()` count the number of command-line arguments and build a string array with one element per argument. The biggest difference here is that `Main` is a *C* struct whereas `Gio.Application` is a proper class and is more consistent with the *OOP* paradigm we’ve been using in every example posted on this blog.

### The onActivate Callback

This is the only place, in a simple application, where we need to reference the `Gio.Application` module:

```d
void onActivate(GioApplication app) // non-advanced syntax
{
        AppWindow appWindow = new AppWindow(this);
		
} // onActivate()
```

This is because the `addOnActivate()` function lives in that module. There are other signal hook-up functions in `Gtk.Application` and, of course, `Gtk.Application` inherits from `Gio.Application`, but when hooking up signals—just as we’ve seen elsewhere—we need to declare the arguments to be exactly what they are in the wrapper file.

We have one last class to look at...

### The AppWindow Class

This class, as mentioned above, inherits from `ApplicationWindow` which in turn inherits from *GTK* `Window` which means for the most part, it’s just another `Window`. It does have a few features not found in the generic *GTK* `Window`, however, things like:

- `ID`s to make window management easier,
- help overlays (more on these in a moment), and
- hideable menubars.

The first—`ID`s—is more or less self-explanatory. The `Application` uses `ApplicationWindow` `ID`s for window management. `Window`s can be added, removed... you get the idea.

Help overlays, however, aren’t something we’ll find in the old construction method. These are inspired by mobile apps where the help screen slides in over top of the `ApplicationWindow` and slides back out when we’re done with it.

Hideable `Menubars` are also inspired by mobile apps, although they’re becoming more prevalent on desktops as well.

Anyway, that’s all nice theory, but how about a look at the code:

```d
class AppWindow : ApplicationWindow
{
	int width = 400, height = 200;
	string title = "Barebones Application";
	
	this(MyApplication myApp)
	{
		super(myApp);
		setSizeRequest(width, height);
		setTitle(title);
		showAll();
		
	} // this()
	
} // class AppWindow
```

As with run-of-the-mill `Window`s or `MainWindow`s, we set up dimensions and a title in the preamble, then in the constructor we call the super-class constructor, set the size, the title, and then call `showAll()`. The only thing here that departs from the old construction method is setting up an `Application` pointer which we pass to the super-class constructor, so let’s talk about that for a moment...

All that’s really going on here is we’re setting up an association between the `ApplicationWindow` and the *GIO/GTK* `Application` so the `Application` can manage the `ApplicationWindow`. Makes sense, right?

## Conclusion

Anyway, that’s all for today. This should give you a basic understanding of what’s going on behind the curtain when you use this new application construction method.

Next time, we’ll dig a little deeper. See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2020/05/28/0111-graphic-position-scale-button.html">Previous: Control Graphic Position with Scale Button</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2020/06/19/0113-gtk-gio-application-id.html">Next: GTK/GIO Application II - Application ID</a>
	</div>
-->
</div>

