---
title: "0037: Dialogs III - Opening Multiple Files"
topic: dialog
layout: post
description: How to retrieve multiple file names using a GTK FileChooserDialog - a D-language tutorial.
author: Ron Tarrant

---

## 0037 – Dialogs III - Opening Multiple Files

This is a companion to the previous post, [File Dialog - Open a Single File](http://gtkdcoding.com/2019/05/17/0036-file-open-dialogs.html). If you have yet to read the other post, it may clarify things that won't make sense otherwise. 

Whereas last time we used a dialog to open a single file, this time we’ll do [the multi-select version](https://github.com/rontarrant/gtkDcoding/blob/master/013_dialogs/dialog_013_03_file_open_multiple.d). But again, this isn’t a production-ready example, so we’ll just be spitting the file names out to the terminal like last time.

### Imports

On top of the extra imports we did with the version for opening a single file, we’ve got two more this time:

	import sdt.conv;
	import glib.ListSG;

You’ll see when we get there, but for now just know that these are needed for converting the singly-linked list of `ListSG` nodes to an array of strings… which will end up being our list of file names.

Now, let’s skip to where the differences are between this example and the last…

### The Callback

Nothing changes until after we define the dialog, then we have this line:

	dialog.setSelectMultiple(true);

It’s sandwiched between the line that defines the dialog and the one that opens it. *And* it's is the line that tells the dialog to expect multiple-selection of file names while it’s open.

The next difference is inside the `if` statement block:

	if(response == ResponseType.OK)
	{
		ListSG list = dialog.getFilenames();
			
		if(list.next is null)
		{
			openFile(to!string(cast(char*)list.data));
		}
		else
		{
			fileList = list.toArray!string();
				
			foreach(string filename; fileList)
			{
				openFile(filename);
			}
		}
	}

The `if` still does the same test. Do we have an `OK` response? But from there, it veers off to call a different dialog function with a different return value:

	ListSG list = dialog.getFilenames();

The list is the singly-linked list we talked about a moment ago.

The next step is to deal with the possibility that the user only selected one file even though multi-select is available:

	if(list.next is null)

If only one file name is selected and we don't do this test, things could get ugly when we ask `list.toArray()` to chew on our list of files.

Carrying on, if `list.next` isn’t `null`, then we have a true list which we process in the `else` part of the block:

	fileList = list.toArray!string();

This statement is why we imported `std.conv`. It converts the `ListSG`’s `char*` to an array of strings, each element of which will be a full-path file name. (Compile and run the example, then watch terminal output to see this in action.) 

Once we have the array of file names (`fileList`) the rest is easy. A `foreach()` steps through the list and each one is handed to `openFile()` for processing.

And as usual, once we’re done with the dialog, we blow it up and move on.

Next time, we'll tackle a `Dialog` for saving files. Until then...


<BR>
<div style="float: left;">
	<a href="/2019/05/17/0036-file-open-dialogs.html">Previous: Open File Dialog</a>
</div>
<div style="float: right;">
	<a href="/2019/05/24/0038-file-save-dialog.html">Next: Save File Dialog</a>
</div>
<BR>
