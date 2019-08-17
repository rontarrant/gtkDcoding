---
title: "0039: Dialogs V - Adding SaveAs, Filename in the Titlebar"
topic: dialog
layout: post
description: How to save an existing file under a new name using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

# 0039: Dialogs V - Adding SaveAs, Filename in the Titlebar

Since we covered [a lot of this stuff last time](/2019/05/24/0038-file-save-dialog.html) when we talked about adding a `Save` `MenuItem`, I’ll just cover the differences…

## Dialog for a FileSaveAs Item

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_05_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_05_file_save_as.d" target="_blank">here</a>.
	</div>
</div>

Of course, when you compare the `FileSaveItem` to the `FileSaveAsItem`, most of the differences consist of adding “as…” or “As” to function names, the class name, and the string used to name the `MenuItem`.

But there is one bigger change in the callback:

```d
void doSomething(MenuItem mi)
	{
		int response;
		FileChooserAction action = FileChooserAction.SAVE;

		filename = _filenameEntry.getText();

		FileChooserDialog dialog = new FileChooserDialog("Save a File", _parentWindow, action, null, null);
		dialog.setCurrentName(_filenameEntry.getText());
		response = dialog.run();

		if(response == ResponseType.OK)
		{
			filename = dialog.getFilename();
			saveAsFile();
		}
		else
		{
			writeln("cancelled.");
		}

		dialog.destroy();		

		_filenameEntry.setText(filename);
		_parentWindow.setTitle(filename);

	} // doSomething()
```

In the `FileSaveItem`, there’s a long `if`/`else` block which doesn’t show up here. Nothing in the else block is needed, so it’s just gone, but everything that was in the `if` block is now executed unconditionally. The only real differences are in the statements. As mentioned, `saveFile()` is now `saveAsFile()`, etc.

Except for this line:

```d
_parentWindow.setTitle(filename);
```

And that brings us to our second topic…

## Filename Reflection in the Titlebar

To examine this thoroughly, let’s start back at the `TestRigWindow` class. In the initialization section this:

```d
string title = “Save Dialog Example”;
```

is now:

```d
string title = “”;
```

And that’s because the initial window title is now set elsewhere, in the `TextEntry` class:

```d
class TextEntry : Entry
{
	private:
	string defaultFilename = "Untitled";
	Window _parentWindow;
```

As before, the `defaultFilename` is set to `“Untitled”`, but since we have that reference to the window (`_parentWindow`), we use it in the `TextEntry`'s constructor:

```d
public:
this(Window parentWindow)
{
	super(defaultFilename);
	addOnActivate(&changeFilename);
	
	_parentWindow = parentWindow;
	_parentWindow.setTitle(defaultFilename);
	
} // this()
```

So if you decide to change the default file name, it’s set in both the `TextEntry` and the titlebar with this one string.

We do refer to it once more, though, in `changeFilename()`:

```d
	void changeFilename(Entry e)
	{
		if(getText() == null)
		{
			writeln("The filename is an empty string. Resetting to default: Untitled.");
			setText(defaultFilename);
		}
		else
		{
			writeln("Filename has changed to: ", getText());
		}

		_parentWindow.setTitle(getText());

	} // changeFilename()

} // class TextEntry
```

And thus we keep the titlebar in sync with the `TextEntry`.

## The Rest of It

The other changes between this and the previous example show up in the `FileMenu` class:

```d
class FileMenu : Menu
{
	FileSaveItem fileSaveItem;
	FileSaveAsItem fileSaveAsItem;
	
	// arg: an array of items
	this(Window parentWindow, TextEntry filenameEntry)
	{
		super();
		
		fileSaveItem = new FileSaveItem(parentWindow, filenameEntry);
		append(fileSaveItem);

		fileSaveAsItem = new FileSaveAsItem(parentWindow, filenameEntry);
		append(fileSaveAsItem);
		
	} // this()
	
} // class FileMenu
```

And those changes are simply declaring and instantiating the `FileSaveAsItem` and then appending it to `FileMenu`.

## Conclusion

And there you have it. Over the last three blog posts, we’ve covered the basics of:

- opening a single file,
- opening multiple files,
- saving a file, and
- saving an already-named file under a new name.

Until next time, make the gods of coding smile upon you and your work.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/24/0038-file-save-dialog.html">Previous: Saving a File</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/31/0040-messagedialog.html">Next: MessageDialog</a>
	</div>
</div>
