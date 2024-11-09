---
title: "0027: Menus II - Mnemonics (Shortcut Keys)"
topic: menu
tag: menu
layout: post
description: How to do set up keyboard shortcuts for GTK MenuItems - a D language tutorial.
author: Ron Tarrant

---

# 0027: Menus II - Mnemonics (Shortcut Keys)

Today, we’ll cover two quick subjects, adding keyboard shortcuts to `MenuItem`s and separating menus into two areas. Let’s get at it.

## Mnemonic Shortcut Keys

There are two ways to set up a keyboard shortcut for a `MenuItem`. Both start with the call to `MenuItem`’s constructor, but one passes three arguments while the other passes only two. In the following example, both are illustrated.

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_07.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_07_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_07_mnemonic.d" target="_blank">here</a>.
	</div>
</div>

### The Two-step Process

The code for creating the NewFileItem with its shortcut key uses the two-step process for hooking up the mnemonic and looks like this:

```d
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
```

There are two things here that are different from our earlier examples:

- our constructor passes along an extra Boolean argument, and
- the `newFileLabel` text has an underscore in front of the ‘N.’

The extra argument (`true`) tells the super-class constructor to turn on the mnemonic for this `MenuItem`.

The underscore (`_`) decides which key, combined with ***Alt***, will activate the `MenuItem`.

And from there, it’s business as usual. Except that...

The `FileMenuHeader` also has a mnemonic. Have a peek:

```d
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
```

If you want a mnemonic on a `MenuItem`, you need a mnemonic on the `Menu`, too. It won’t show when your application is running (more’s the pity) and you don’t need to turn it on by passing a Boolean to the `MenuItem` that acts as a menu header, but the underscore does have to be there.

### The One-step Process

With this method, a pointer to the callback is passed to the super-class along with the mnemonic label text and the Boolean switch:

```d
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
```

Notice also that the underscore isn’t under the first letter in the Label text, indicating that any one of the letters in the text `Label` can be used as the shortcut key.

## Separators

This is just about the easiest thing to do in *GtkD*. Pick the spot for the separator and:

```d
SeparatorMenuItem separator = new SeparatorMenuItem();
append(separator);
```

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/012_menus/menu_08.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal2" class="modal">																<!-- modal# -->
				<span class="close2">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img22">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal2");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img2");														// img#
			var modalImg = document.getElementById("img22");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close2")[0];										// close#
			
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
			<img id="img3" src="/images/screenshots/012_menus/menu_08_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal3" class="modal">																			<!-- modal# -->
				<span class="close3">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img33">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal3");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img3");																	// img#
			var modalImg = document.getElementById("img33");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close3")[0];													// close#
			
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

	<div class="frame-footer">																							<!--------- filename (below) ------------>
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_08_separator.d" target="_blank">here</a>.
	</div>
</div>

No muss, fuss, or foaming at the mouth.

## Conclusion

Well, that’s that. Mnemonic shortcut keys and separators... Yup.

Bye, now.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/12/0026-menu-basics.html">Previous: Menu Basics</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/19/0028-checkmenuitems.html">Next: CheckMenuItem</a>
	</div>
</div>
