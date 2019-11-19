---
title: "0038: Dialogs IV - Saving a File"
topic: dialog
layout: post
description: How to save a single filename using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

# 0038: Dialogs IV - Saving a File

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/013_dialogs/dialog_013_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/013_dialogs/dialog_013_04_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_04_file_save.d" target="_blank">here</a>.
	</div>
</div>

## Introduction

Today's dialog example illustrating *File > Save* is very much like [the one we looked at earlier for *File > Open*](https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_02_file_open_single.d). Making the change naturally means that *‘Open’* becomes *‘Save’* and *‘open’* becomes *‘save.’* But there’s a bit more to it than a bit of search-n-replace.

### Extra Widgets: Entry

To the top-level window, I added a `TextEntry` class derived from the `Entry` widget so the file name can be seen and changes easily tracked. Let’s look at it a bit at a time. Here’s the first part:

```d
class TextEntry : Entry
{
	private:
	string _defaultFilename = "Untitled";
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(_defaultFilename);
		addOnActivate(&changeFilename);
		
		_parentWindow = parentWindow;
		
	} // this()
```

You’ll note that, in preparation for breaking these classes out into their own modules, variable names are private. They each have a leading underscore, a convention that sets up an association between local and incoming variables that hold the same values or pointers.

The public section starts with the constructor which does nothing we haven’t seen before, although I will call your attention to the `addOnActivate()` call. This sets up a signal so that any time the `TextEntry` has focus and the user hits the Enter key, the callback is triggered. Speaking of which, here’s the callback:

```d
	void changeFilename(Entry e)
	{
		if(getText() == null)
		{
			writeln("The file name is an empty string. Resetting to default: Untitled.");
			setText(_defaultFilename);
		}
		else
		{
			writeln("Filename has changed to: ", getText());
		}
		
	} // changeFilename()

} // class TextEntry
```

The callback first ensures that the file name isn't empty (the `if` statement) and if that's the case, echoes it to the terminal (the `else`), but that's all. The rest we take care of in the `FileSaveItem` object... which we’ll talk about now.

### The FileSaveItem

This class is a bit long, so we’ll look at it in chunks, starting with the initialization section:

```d
class FileSaveItem : MenuItem
{
	private:
	string itemLabel = "Save";
	FileChooserDialog fileChooserDialog;
	Window _parentWindow;
	string filename;
	TextEntry _filenameEntry;
```

Same as with the `FileOpenItem`, we’ve got:

- the label, `itemLabel`,
- a definition for the dialog, `fileChooserDialog`, and
- a pointer to the parent window (`_parentWindow`) so we can make the dialog modal.

But then we also have:

- `filename`, and
- `_filenameEntry`.

Strictly speaking, we don’t need the `filename` variable, but it’s more convenient than typing `filenameEntry.getText()` each time we need to refer to the current file name.

And, of course, `_filenameEntry` will be dealt with here in a second, so let’s move on to...

### The FileSaveItem Constructor

```d
public:
this(Window parentWindow, TextEntry filenameEntry)
{
	super(itemLabel);
	addOnActivate(&doSomething);
	_parentWindow = parentWindow;
	_filenameEntry = filenameEntry;
	
} // this()
```

Nothing unexpected here. We bring in the parent window and the `TextEntry` pointer and, after calling the super-class constructor and adding a signal, we assign these local copies of these variables.

### The FileSaveItem Callback

But here in the callback is where changes are more apparent, starting with:

```d
private:
void doSomething(MenuItem mi)
{
	int response;
	FileChooserAction action = FileChooserAction.SAVE;
	filename = _filenameEntry.getText();
```

The big change here (as expected) is in the `action` variable which is now set to `FileChooserAction.SAVE` instead of `FileChooserAction.OPEN`. We also need that reference to the `TextEntry` object (`_filenameEntry`) so we can `getText()` and `setText()` from here.

Now the next chunk:

```d
if(filename == "Untitled")
{
	FileChooserDialog dialog = new FileChooserDialog("Save a File", _parentWindow, action, null, null);

	dialog.setCurrentName(_filenameEntry.getText());
	response = dialog.run();
	
	if(response == ResponseType.OK)
	{
		filename = dialog.getFilename();
		saveFile();
	}
	else
	{
		writeln("cancelled.");
	}

	dialog.destroy();		
}
```

Earlier, when we were looking at the `TextEntry` class, I mentioned that the `filename` string, unless empty, is set and reset here in the `FileSaveItem` class. This `if` block is where that’s done. If `filename` is `“Untitled”`, we instantiate and open the dialog, get the response, and then test it the same way we did with the `FileOpenItem` before destroying the dialog.

Now the `else` block:

```d
	else
	{
		saveFile();
	}

	_filenameEntry.setText(filename);
			
} // doSomething()
```

This compliment to the above `if` block mock-saves the file with whatever text is found in the `TextEntry`. In a real application, we'd make sure we're working with a fully-qualified file and path for the OS we're running before the actual save. Among other things, we'd make sure the file extension (if any) was in there and matched the file contents.

We could also separate the file name from the path so the path can be preserved in a settings file for next time the application runs. This would be my approach because it's just handy as all git-out when an application remembers where I was working from one session to the next. But all that's for another blog post sometime down the road. For now, this illustrates the basics of the process.

And at the very end of the callback, we make sure the file name in the `TextEntry` is in sync. 

*Note: If you type in and compile this code, you can conduct tests by typing arbitrary text or deleting all text in the `TextEntry` (don’t forget to hit* **Enter**) *and then selecting the `Save` `MenuItem` under various circumstances to see how these mechanisms play out.*

### The AppBox

Just one thing I'd like to point out here... the `filenameEntry` pointer is passed to the menuBar, the object at the top of the menu hierarchy, so it can be passed down from object to object until it reaches the `FileSaveItem`.

```d
class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	TextEntry filenameEntry;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, padding);

		filenameEntry = new TextEntry(parentWindow);
		menuBar = new MyMenuBar(parentWindow, filenameEntry);

		packStart(menuBar, false, false, 0);
		packStart(filenameEntry, false, false, 0);		
		
	} // this()
	
} // class AppBox
```

## Conclusion

And that’s how a simple `Save` item can be coded. Next time, we’ll add in `Save as...` and do something else that’s often done in applications, display the file name in the `Window` header and keep it current.

Until then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/05/21/0037-file-open-multiple.html">Previous: Dialog - Open Multiple Files</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/28/0039-file-save-as-dialog.html">Next: SaveAs Dialog</a>
	</div>
</div>
