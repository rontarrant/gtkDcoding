---
title: "0114: GTK GIO Application Flags and Command Line Arguments"
layout: post
topic: app
description: How GTK/GIO uses flags in the processing command line arguments.
author: Ron Tarrant
---

# 0114: GTK/GIO Application Flags and Command Line Arguments

Today we’ll dig into passing command line arguments to a *GTK*/*GIO* application and start looking at the built-in mechanism that handles them.

## The Arguments

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/020_app/app_020_04_commandline_arguments.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/020_app/app_020_04_commandline_arguments_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/020_app/app_020_04_commandline_arguments.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

As mentioned last time, command-line arguments are passed along to the *GIO* `Application`—a class object rather than the `Main` C-style struct we’ve used all along—and packed into an array. The flow of these arguments is:

- the user types the arguments,
- the class initializer method then:
	- pulls them in — `this(string[] args)`,
	- passes them to the `GtkApplication.run()` method — `run(args)`, and
- they’re stored in an `ApplicationCommandLine` object.

From there, we pull them out in our `onCommandLine()` method (which we’ll look at momentarily).

Now let’s take a gander at the initialization method in full:

```d
this(string[] args)
{
	super(id, flags);
		
	addOnActivate(&onActivate);
	addOnCommandLine(&onCommandLine);

	addOnStartup(&onStartup);
	addOnShutdown(&onShutdown);

	writeln("registration before: ", registration);
	registration = register(null);
	writeln("registration after: ", registration);

	run(args);

} // this()
```

Notice that we’re using a signal to hook up command-line processing to a method just as we do with application activation, application start-up, or—for that matter—connecting any widget to an action.

Now, before we dig in further, I want to point out one other thing we need to take care of when deriving our `MyApplication` class from `GtkApplication`…

We need to tell *GTK*/*GIO* that we’re intending to handle command-line arguments and to do this, we declare a class attribute in the preamble:

```d
ApplicationFlags flags = ApplicationFlags.HANDLES_COMMAND_LINE;
```

It’s an extra step compared to doing things the way we’re used to.

### Parsing, Parsing, Over the Bounding Command-line

Now that *GIO* has done its part, it’s up to us to pick up the command-line argument baton and finish the race. How? We write a command-line parser. It’ll be written as a method similar to the widget action methods we've looked at so often in this blog. In this case, it takes this form:

```d
int onCommandLine(ApplicationCommandLine acl, GioApplication app)
{
		int exitStatus = 0;
		string[] args = acl.getArguments();
		int[] dimensions = [0, 0];

		writeln("triggered onCommandLine...");
	
		// remove the application name from the string of args
		args = args.remove(0);

		writeln("\tcommandline args: ", args);
		writeln("\targs.length: ", args.length);
		
		if(args.length == 0)
		{
				writeln("\tno args");
				activate(null);
		}
		else
		{
			for(int i; i < args.length; i += 2)
			{
				string arg = args[i];
				
				switch(arg)
				{
					case "width":
						dimensions[0] = to!int(args[i + 1]);
					break;
					
					case "height":
						dimensions[1] = to!int(args[i + 1]);
					break;
					
					default:
						writeln("arg: ", arg);
						writeln("arg: ", to!string(args[i + 1]));
					break;
				}
			}
			
			activate(dimensions);
		}
		
		return(exitStatus);
		
	} // onCommandLine()
```

Note the method arguments:

- `ApplicationCommandLine acl`, and
- `GioApplication app`.

Earlier, we talked about the path our arguments take when they’re passed in. I didn’t mention their final destination which is—they get shoved into the `ApplicationCommandLine` class which is specifically designed for that purpose. Here in the parser method is where we retrieve them and get down to business.

In short (skipping down to the `if`/`else`), what we do here is:

- get rid of the application name (which, you’ll remember, is always retrieved along with the arguments) by `remove()`ing the zeroth element of the `args` array,
- step through the remaining args two at a time,
- check each against a pre-determined set of args we’re expecting (`“width”` and `“height”` in this case),
- do a look-ahead to the next argument to get a value, and
- calling the `activate()` method, passing in the width and height we’ve captured from the command line.

## The activate() Method

*GIO* has a default `activate()` method which gets called unless we override it. Here, that’s exactly what we’re doing.

If you run this demo without appending command line arguments, you’ll get a few bits of info dumped to the terminal, but that’s it. The demo exits. But adding even one command line argument changes that. A window opens… and if you don’t specify a `width` and `height`, each followed by a number, the window has a default size, the dimensions of which are object attributes in the preamble to the `AppWindow` class.

## Conclusion

Because of space constraints, I’ve skimmed over a few things, so if you have questions, please ask them in the comments below.

Next time, we’ll carry on in this same vein, but turn to the `HANDLES_OPEN` flag to see how a list of files can be opened using these methods.

Until then, just remember Howard’s immortal words: “There’s no place for truth on the Internet.”


<div class="blog-nav">
	<div style="float: left;">
		<a href="/2021/09/10/0113-gtk-gio-application-ids-signals.html">Previous: GTK GIO Applications - IDs and Signals</a>
	</div>
	<div style="float: right;">
		<a href="/2021/09/24/0115-gtk-gio-app-open-flag.html">Next: GTK/GIO IV - Opening Files</a>
	</div>
</div>
