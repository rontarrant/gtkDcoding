---
title: "0050: MVC Part III – ComboBoxText - Adding and Removing Items"
layout: post
topic: mvc
description: A demonstration of how to add and remove items from the GTK ComboBoxText.
author: Ron Tarrant

---

# 0050: MVC Part III – ComboBoxText - Adding and Removing Items

Last time we got stuck into `ComboBoxText` widgets and this time we carry on by adding and deleting items that show up in the drop-down list.

In this first example, we’ll look at…

## Adding an Item to a ComboBoxText

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_04_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_04_comboboxtext_add.d" target="_blank">here</a>.
	</div>
</div>

For this functionality, we need to put an extra `Button` in our UI and, of course, that’s done in the `AppBox` class:

```d
class AppBox : Box
{
	DayComboBoxText dayComboBoxText;
	AddToComboButton addToComboButton;
	
	this()
	{
		super(Orientation.HORIZONTAL, 10);
		
		dayComboBoxText = new DayComboBoxText();
		packStart(dayComboBoxText, false, false, 0);
		
		addToComboButton = new AddToComboButton(dayComboBoxText);
		packEnd(addToComboButton, false, false, 0);
		
		writeln("Type something into the Entry, then hit the Add button.");
		writeln("You can also hit Enter to echo the contents of the Entry to the terminal, but this action doesn't add the contents to the list.");

	} // this()

} // class AppBox
```

I’ll draw your attention to these lines:

```d
addToComboButton = new AddToComboButton(dayComboBoxText);
packEnd(addToComboButton, false, false, 0);
```

The only unusual thing is passing in the `dayComboBoxText` object so the *Add* `Button` has access to its data. No worries, right? We’ve done this kind of thing a few times by now.

I used `writeln()` to echo a couple of lines to the terminal so you know what’s being demonstrated.

Now let’s look at…

## The Add Button Class

Which looks like this:

```d
class AddToComboButton : Button
{
	private:
	ComboBoxText _comboBoxText;
	Entry _entry;
	string _entryText, buttonText = "Add";
	
	public:
	this(ComboBoxText comboBoxText)
	{
		super(buttonText);
		
		_comboBoxText = comboBoxText;
		_entry = cast(Entry)_comboBoxText.getChild();

		addOnReleased(&doSomething);		
		
	} // this()
	
	
	void doSomething(Button b)
	{
		_entryText = _entry.getText();
		
		if(_comboBoxText.getIndex(_entryText) is -1)
		{
			_comboBoxText.appendText(_entryText);
			writeln(_entryText, " is now on the list.");
		}
		else
		{
			writeln(_entryText, " is already on the list.");
		}
		

	} // doSomething()
	
} // class AddToComboButton
```

Because we need to grab the text from the `Entry`, as mentioned before, we need access and we get that in the constructor by assigning `_comboBoxText` and `_entry`. The first assignment (`_comboBoxText`) isn’t strictly necessary, but it lends clarity to the `cast()` call. And maybe we’ll think of some other reason we need this sometime down the road.

In the `doSomething()` function, we take up the task of grabbing the text from the `Entry` and `appendText()` adds it to the list.

A quick note: There are three ways we can add items to the list:

- `appendText()` sticks it at the end of the list,
- `prependText()` sticks it at the beginning, and
- `insertText()` takes a second argument so you can put it wherever you want.

## Remove an Item

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/017_mvc/mvc_017_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/017_mvc/mvc_017_05_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_05_comboboxtext_add_remove.d" target="_blank">here</a>.
	</div>
</div>

This example looks pretty much the same as the last except it’s got a *Remove* `Button` that looks like this:

```d
class RemoveFromComboButton : Button
{
	private:
	ComboBoxText _comboBoxText;
	Entry _entry;
	string _entryText, buttonText = "Delete";
	
	public:
	this(ComboBoxText comboBoxText)
	{
		super(buttonText);
		
		_comboBoxText = comboBoxText;
		_entry = cast(Entry) _comboBoxText.getChild();

		addOnReleased(&doSomething);		
		
	} // this()
	
	
	void doSomething(Button b)
	{
		int activeTextIndex;
		
		_entryText = _entry.getText();
		activeTextIndex = _comboBoxText.getIndex(_entryText);
		
		if(activeTextIndex !is -1)
		{
			_comboBoxText.remove(activeTextIndex);
			writeln(_entryText, " has been removed.");
			_comboBoxText.setActive(0);
		}
		else
		{
			writeln("Cannot complete operation. '", _entryText, "' isn't on the list.");
		}
		

	} // doSomething()
	
} // class RemoveFromComboButton
```

Removing, as can be seen in the `if()` statement inside the `doSomthing()` function, is a two-stage process:

- check to make sure the item is actually on the list, and
- call `remove()` to remove it.

There is a third line of code that’s just as important, though:

```d
_comboBoxText.setActive(0);
```

Why? Because if we don’t reset the active item, the just-deleted text is still sitting in the `Entry`. Depending on circumstances, you may want to comment this line out so the text is left there to serve as a quick-n-dirty ‘undo’ function. All the user would have to do is hit the *Add* `Button` and the item goes right back on the list.

## Conclusion

Next time, we’ll take a look at the `ComboBox` and look at populating it with various data types starting with text, then moving on to things like numbers, images, or whatever else fits into a `TreeModel`.

Until then…

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/02/0049-mvc-ii-comboboxtext.html">Previous: ComboBoxText</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/09/0051-mvc-iv-combobox-text.html">Next: ComboBox with Text</a>
	</div>
</div>
