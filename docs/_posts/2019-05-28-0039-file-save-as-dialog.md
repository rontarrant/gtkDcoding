---
topic: dialog
layout: post
description: How to save an existing file under a new name using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

## 0039 – Dialogs V - Adding SaveAs and Filename Reflection in the Titlebar

Since we covered [a lot of this stuff last time](http://gtkdcoding.com/2019/05/24/0038-file-save-dialog.html) when we talked about adding a `Save` `MenuItem`, I’ll just cover the differences…

### FileSaveAsItem

This being the biggest change, let’s cover it first. [You can find the code here](https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_05_file_save_as.d).

Of course, when you compare the `FileSaveItem` to the `FileSaveAsItem`, most of the differences consist of adding “as…” or “As” to function names, the class name, and the string used to name the `MenuItem`.

But there is one bigger change in the callback:

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

In the `FileSaveItem`, there’s a long `if`/`else` block which doesn’t show up here. Nothing in the else block is needed, so it’s just gone, but everything that was in the `if` block is now executed unconditionally. The only real differences are in the statements. As mentioned, `saveFile()` is now `saveAsFile()`, etc.

Except for this line:

	_parentWindow.setTitle(filename);

And that brings us to our second topic…

### Filename Reflection in the Titlebar

To examine this thoroughly, let’s start back at the `TestRigWindow` class. In the initialization section this:

	string title = “Save Dialog Example”;

is now:

	string title = “”;

And that’s because the initial window title is now set elsewhere, in the `TextEntry` class:

	class TextEntry : Entry
	{
		private:
		string defaultFilename = "Untitled";
		Window _parentWindow;

As before, the `defaultFilename` is set to `“Untitled”`, but since we have that reference to the window (`_parentWindow`), we use it in the `TextEntry`'s constructor:

		public:
		this(Window parentWindow)
		{
			super(defaultFilename);
			addOnActivate(&changeFilename);
			
			_parentWindow = parentWindow;
			_parentWindow.setTitle(defaultFilename);
			
		} // this()

So if you decide to change the default file name, it’s set in both the `TextEntry` and the titlebar with this one string.

We do refer to it once more, though, in `changeFilename()`:

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

And thus we keep the titlebar in sync with the `TextEntry`.

### The Rest of It

The other changes between this and the previous example show up in the `FileMenu` class:

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

And those changes are simply declaring and instantiating the `FileSaveAsItem` and then appending it to `FileMenu`.

### Conclusion

And there you have it. Over the last three blog posts, we’ve covered the basics of:

- opening a single file,
- opening multiple files,
- saving a file, and
- saving an already-named file under a new name.

Until next time, make the gods of coding smile upon you and your work.


<BR>
<div style="float: left;">
	<a href="https://gtkdcoding.com/2019/05/24/0038-file-save-dialog.html">Previous: Saving a File</a>
</div>
<div style="float: right;">
	<a href="https://gtkdcoding.com/2019/05/31/0040-messagedialog.html">Next: MessageDialog</a>
</div>
<BR>
