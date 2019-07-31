---
title: "0051: MVC IV – A ComboBox with Text"
topic: mvc
layout: post
description: A tutorial on reproducing the GTK ComboBoxText using a ComboBox and a ListStore.
author: Ron Tarrant

---

# 0051 – MVC IV – The ComboBox with Text

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_06.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_06_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_06_combobox_liststore.d" target="_blank">here</a>.
	</div>
</div>

Today starts a mini-series within our **MVC** series in which we look at a simple `ComboBox` example to reproduce what we’ve already done with the `ComboBoxText`.

So… unlike the `ComboBoxText`—which you more or less just throw strings at—the `ComboBox` needs an actual `Model` (ListStore or `TreeStore`) to draw text strings from. This is a little more work than it was with the `ComboBoxText`, so let’s dig in…

## The Model

We start with a `ListStore` class:

{% highlight d %}
	class SignListStore : ListStore
	{
		string[] items = ["bike", "bump", "cow", "deer", "crumbling cliff", "man with a stop sign", "skidding vehicle"];
		TreeIter treeIter;
		
		this()
		{
			super([GType.STRING]);
			
			for(int i; i < items.length; i++)
			{
				string message = items[i];
				treeIter = createIter();
				setValue(treeIter, 0, message);
			}
	
		} // this()
	
	} // class SignListStore
{% endhighlight %}

Now, there are similarities. We still have a string array, but how we handle it is quite different.

### The Model Constructor

The `ListStore` constructor takes an array of `GTypes` and these define the data types each column in the `ListStore` will hold. The `GType enum`, found in `generated/gtkd/gobject/c/types.d`, defines all the built-in types we can use here. Later, when we look at more complex examples, we’ll go over how to deal with more complex types, but for now, these will do.

You'll note that the call to `super()` still gets an array for an argument, even though we're only using one data type. And, of course, because there's only one element in the array, there will be only one column.

The `for()` loop steps through the array, picks one from the `items` array, instantiates a `TreeIter`, and then sets the value in the `ListStore` row.

The `setValue()` arguments are:

- `treeIter` – a pointer to the `ListStore` row where we’ll store the current data,
- `0` – the column number (in this case the only column we have) within the `ListStore` where the data will end up, and
- `message` – the string data we’re storing.

## The View/Control

The `ComboBox` acts as both **View** and **Control**. Keep in mind that it’s based on the `CellLayout` interface and so it a non-standard implementation of the **MVC** paradigm. But, no matter. The results are so similar, they make no real difference, so let’s carry on.

Let’s look at the `SignComboBox` a bit at a time starting with…

### The Initialization Chunk

{% highlight d %}
	class SignComboBox : ComboBox
	{
		private:
		bool entryOn = false;
		SignListStore _signListStore;
		CellRendererText cellRendererText;
		int visibleColumn = 0;
		int activeItem = 0;
{% endhighlight %}

Here’s what these are:

- `entryOn` we’ve used before and with it being false, it stops the `ComboBox` from including an `Entry` widget,
- `_signListStore` is just a convenient (and local) place to keep a pointer to the `ListStore`,
- `cellRendererText` tells the `ComboBox` that we’ll be working with and displaying text items,
- `visibleColumn` is the `ListStore` column number from which we’ll draw data, and
- `activeItem` is the `ListStore` row number (index) that’ll be selected by default.

We’ll talk more about the `visibleColumn` variable and `CellRenderer`s of various types when we look at other examples later in this mini-series.

### The Constructor

{% highlight d %}
	public:
	this(SignListStore signListStore)
	{
		super(entryOn);
		
		// set up the ComboBox's column to render text
		cellRendererText = new CellRendererText();
		packStart(cellRendererText, false);
		addAttribute(cellRendererText, "text", visibleColumn);
		
		// set up and bring in the store
		_signListStore = signListStore;
		setModel(_signListStore);
		setActive(activeItem);
		
		addOnChanged(&doSomething);
		
	} // this()
{% endhighlight %}

After the instantiation of the super-class, we have three stages to this constructor:

- setting up and packing the `CellRenderer`,
- initializing the `ListStore` (**Model**), and
- hooking up the signal.

#### Stage 1: CellRendererText

In the introduction to this series, I mentioned that one or more `CellRenderer`s are packed into a `TreeViewColumn` so it knows how to display its contents. With a `ComboBox`, we don’t have a `TreeViewColumn`. Instead, as I said earlier, the `ComboBox` is an implementation of the `CellLayout` interface. This interface is also implemented by the `TreeViewColumn` which means the `ComboBox` acts as its own `TreeViewColumn` of a sort. All this means is that you can treat the ComboBox as if it has a TreeViewColumn... more or less. Later on, we’ll see how flexible this can be.

For now, though, this is what happens in the first stage of the constructor:

- the `CellRenderer` is instantiated,
- its packed into the `ComboBox`, and
- we use `addAttribute()` to tell the `ComboBox`:
	- what its single column will display,
	- which `CellRenderer` to use, and
	- which column will be visible (in this case, the only column we have).

#### Stage 2: Initializing the Model

Not a big deal, we just:

- assign a local pointer to the `ListStore`,
- use `setModel()` to tell the `ComboBox` where to look for its data, and
- pre-select one of the items, using `setActive()`, so the `ComboBox` shows a default value.

Moving on…

### Stage 3: The Callback

And the last line of the constructor hooks up the callback signal, but that's straightforward, so let's look at the callback code itself:

{% highlight d %}
	void doSomething(ComboBox cb)
	{
		string data;
		TreeIter treeIter;

		write("index of selection: ", getActive(), ", ");
		
		if(getActiveIter(treeIter) == true)
		{
			data = getModel().getValueString(treeIter, 0);
			writeln("data: ", data);
		}

	} // doSomething()
{% endhighlight %}

Again, we define a `TreeIter` which we’ll go over in a moment.

The first action we take is to get the index of the currently-selected item. This is here purely for completeness sake. It really has nothing to do with the next step…

which is where we use the `TreeIter`, not to stuff data into the `ListStore`, but to retrieve it. The `getActiveIter()` function returns a Boolean to indicate success or failure, so we can predicate further action on whether or not the `TreeIter` gets initialized here. And yes, it’s one of those *D*-language situations where the function definition looks like this:

	public bool getActiveIter(out TreeIter iter)

And if you don’t yet know, that’s *D*’s way of asking a function to assign value to an argument. And to make things easy for this worker function, *D* has the ability to hand it the argument using the `out` qualifier.

Anyway, if the `TreeIter` gets instantiated by `getActiveIter()`, we then:
- use `getModel()` to grab the `ListStore`'s `TreeModel` so we can
- use its `getValueString()` function to grab the data stored in the first (`0`th) column of the **Model**.

It looks and sounds far more complex than it actually is. We could have done the same thing like this:

{% highlight d %}
       model = getModel();
       data = model.getValueString(treeIter, 0);
{% endhighlight %}

But, whatever. From there, we can do whatever we want with the fetched data. In this case, we just echo it to the terminal.

## Conclusion

Okay, so there we have a reproduction of the `ComboBoxText` using a `ComboBox` and—who’d-a thunk it—some text. Sure, it’s more work, but as we’ll see in the rest of this mini-series within a series, when we turn to non-string data, we need to know this stuff.

See you next time when we tackle a `ComboBox` with integers.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/05/0050-mvc-iii-comboboxtext-add-remove.html">Previous: MVC - ComboBoxText - Add & Remove</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/12/0052-mvc-v-int-combobox.html">Next: ComboBox with Integers</a>
	</div>
</div>
