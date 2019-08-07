---
title: "0049: MVC Part II – the ComboBoxText - a Few Simple Examples"
topic: mvc
layout: post
description: A few basic examples of how to use the GTK ComboBoxText.
author: Ron Tarrant

---

# 0049: MVC Part II – the ComboBoxText<br> - a Few Simple Examples

Continuing from last time…

Of the two **Model**s used in *GTK*, the `TreeStore` and the `ListStore`, the latter is the least complex because it adheres to a flat data **Model**, so we’ll begin with that. As mentioned last time, *GTK* widgets that use a `ListStore` are:

- `ComboBox`,
- `ComboBoxText`, and
- `TreeView`.

Let’s start with the simplest of the bunch…

## The ComboBoxText (without Entry)

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_01.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_01_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_01_comboboxtext.d" target="_blank">here</a>.
	</div>
</div>

You might think the `ComboBox` would be the simpler of the two, but `ComboBoxText` is specialized for use with text only while `ComboBox` can be used with text, numbers of various types, and also images. This means we can take advantage of all the text-related assumptions made by the `ComboBoxText`'s functionality and get away with less work and less code. We won’t have to deal with `CellRenderer`s or even the `ListStore` itself, not directly.

As usual, our first example of a `ComboBoxText` is instantiated inside an `AppBox` which, in turn, is instantiated inside a `TestRigWindow`, so we don't need to look at those. The class we’re looking at first is this:

{% highlight d %}
	class DayComboBoxText : ComboBoxText
	{
		private:
		string[] days = ["yesterday", "today", "tomorrow"];
		bool entryOn = false;
		
		public:
		this()
		{
			super(entryOn);
			
			foreach(day; days)
			{
				appendText(day);
			}
	
			addOnChanged(&doSomething);
			
		} // this()
		
		
		void doSomething(ComboBoxText cbt)
		{
			writeln(getActiveText());
			
		} // doSomething()
	
	} // class DayComboBoxText
{% endhighlight %}

Not a lot to look at here… Call the super-class constructor, `appendText()` a bunch of strings, and we’ve got a working widget.

Also as usual, the `doSomething()` function is just a stubby little thing that shows how the widget signal `addOnChanged()` is harnessed. We’ll look more closely at that signal in a bit because it does have its foibles, but right now I want to draw your attention to the initialization section where we find…

### The entryOn Variable

By default, the `ComboBox` and the `ComboBoxText` both assume you want an `Entry` attached to your drop-down list. But I wanted to start with the simplest form of this widget, so here it’s turned off. It's extra code, but we end up with extra simplicity.

## The ComboBoxText with a Preselected Item

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/017_mvc/mvc_017_02.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/017_mvc/mvc_017_02_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_02_comboboxtext_preselect.d" target="_blank">here</a>.
	</div>
</div>

The difference between example #1 and example #2, a `ComboBoxText` with a pre-selected item, is minimal. We just add a single line of code to the constructor:

{% highlight d %}
	setActive(0);
{% endhighlight %}

And that’s all it takes to have one of our list items selected and showing on start-up. Just so you know, `0` is an index into the list of items, so we could also have set it to `1` or `2`.

## The ComboBoxText with Entry

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img4" src="/images/screenshots/017_mvc/mvc_017_03.png" alt="Current example output">		<!-- img# -->
			
			<!-- Modal for screenshot -->
			<div id="modal4" class="modal">																<!-- modal# -->
				<span class="close4">&times;</span>														<!-- close# -->
				<img class="modal-content" id="img44">														<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal4");													// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img4");														// img#
			var modalImg = document.getElementById("img44");												// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close4")[0];										// close#
			
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
			<img id="img5" src="/images/screenshots/017_mvc/mvc_017_03_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

			<!-- Modal for terminal shot -->
			<div id="modal5" class="modal">																			<!-- modal# -->
				<span class="close5">&times;</span>																	<!-- close# -->
				<img class="modal-content" id="img55">																	<!-- img## -->
				<div id="caption"></div>
			</div>
			
			<script>
			// Get the modal
			var modal = document.getElementById("modal5");																// modal#
			
			// Get the image and insert it inside the modal - use its "alt" text as a caption
			var img = document.getElementById("img5");																	// img#
			var modalImg = document.getElementById("img55");															// img##
			var captionText = document.getElementById("caption");

			img.onclick = function()
			{
			  modal.style.display = "block";
			  modalImg.src = this.src;
			  captionText.innerHTML = this.alt;
			}
			
			// Get the <span> element that closes the modal
			var span = document.getElementsByClassName("close5")[0];													// close#
			
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

	<div class="frame-footer">																							<!---------- filename (below) ---------->
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_03_comboboxtext_entry.d" target="_blank">here</a>.
	</div>
</div>

Now we get to the `Entry`fied version with example #3, a `ComboBoxText` with an `Entry`. These examples are all really the same code with a few changes, so we’ll skip right to them. For starters, here’s the initialization section:

{% highlight d %}
	string[] days = ["yesterday", "today", "tomorrow"];
	bool entryOn = true;
{% endhighlight %}

The `entryOn` variable is, of course, now true which makes the `Entry` appear.

In the constructor, there’s a new line of code hooking up a second signal/callback:

{% highlight d %}
	addOnKeyRelease(&onKeyRelease);
{% endhighlight %}

And we’ll talk about that in a moment. For now, I wanna talk about…

### The Foible of the onChanged Signal

 Now we run headlong into that foible I mentioned earlier… The `onChanged` signal doesn’t distinguish between these two actions:

- typing in the `Entry`, and
- selecting an item from the drop-down list.

If we don’t help it distinguish between these two actions, the callback will be triggered whenever the user hits a key. It's messy and it might lead to unseen complications somewhere down the road, so here's the plan:

When the `onChanged` signal’s callback is triggered, the first thing we'll do is check which item is active:

{% highlight d %}
	void onChanged(ComboBoxText cbt)
	{
		if(getIndex(getActiveText()) !is -1)
		{
			writeln("this is a list item: ", getActiveText());
		}
	
	} // onChanged()
{% endhighlight %}

If the index is any number from `0` and up, that tells us the text currently in the `Entry` is an item from the drop-down. But, if we get an index of `-1`, the text only exists in the `Entry` which that tells us the `onChanged` signal is reacting to the user typing.

If for some reason you want to do something with every incoming keystroke, now's your chance. Just follow the `if` with an `else` and you’re good to go.

### Running the Example

Once you’ve compiled the code, the following actions will be demonstrated:

- selecting from the list will result  in the selection being echoed to the terminal, 
- text typed into the `Entry` will not show up in the terminal until you hit the *Enter* key. That’s where the second signal, `onKeyRelease`, is triggered.

And speaking of which, let’s look at the `onKeyRelease` callback:

{% highlight d %}
	bool onKeyRelease(Event event, Widget w)
	{
		bool stopHereFlag = true;
		
		if(event.type == EventType.KEY_RELEASE)
		{
			GdkEventKey* keyEvent = event.key;
			
			if(keyEvent.keyval == GdkKeysyms.GDK_Return)
			{
				writeln("onKeyRelease: ", getActiveText());			
			}
		}

		return(stopHereFlag);
		
	} // onKeyRelease()
{% endhighlight %}

As mentioned, it’s triggered when the user hits the *Enter* key. In actuality, it goes off every time a key is pressed, but we use the `if()` statement to ignore everything except *Enter*.

## Conclusion

And that’s all for this time. Next time, we’ll continue this discussion while looking at how to add and remove items from the `ComboBoxText`’s list.

See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/06/28/0048-mvc-i-introduction.html">Previous: MVC - Introduction</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/05/0050-mvc-iii-comboboxtext-add-remove.html">Next: ComboBoxText - Add & Remove</a>
	</div>
</div>
