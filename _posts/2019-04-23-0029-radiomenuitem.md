---
title: "0029: Menus IV - The RadioMenuItem"
topic: menu
tag: menu
layout: post
description: How to use a GTK RadioMenuItem - a D language tutorial.
author: Ron Tarrant

---

# 0029: Menus IV - The RadioMenuItem

Today we start on `RadioMenuItem`s with a simple example. Next time, we’ll carry on with a second example, but with a more practical bent.

I said in an earlier post that `RadioButton`s are more complex than other *GTK* widgets. Well, `RadioMeniItem`s are too, but in different ways. Those differences start with inheritance.

Whereas the `RadioButton` inheritance chain looks like this:

- `Button` (great-grandparent),
	- `ToggleButton` (grandparent), and
		- `CheckButton` (parent),

the `RadioMenuItem` inheritance chain is shorter:

- `MenuItem` (grandparent), and
	- `CheckMenuItem` (parent).

But this simply means that, like with `RadioButton`s, we have to manage mutual exclusion or we could end up with the whole set of radio items turned on (or off) at the same time. If that's the functionality we need, we'd be better off with `CheckMenuItem`s. If you follow the methods laid out in the examples we look at this time and next, that won’t be a problem.

One to the first example...

## A Simple RadioMenuItem

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_11.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_11_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_11_simple_radiomenuitems.d" target="_blank">here</a>.
	</div>
</div>

If we look at the `MyRadioMenuItem` class, right off the bat we can see some differences in how the constructors are set up compared to the `CheckMenuItem`:

```d
class MyRadioMenuItem : RadioMenuItem
{
	string message = "The setting state is: ";
	
	this(ListSG group, string radioLabel)
	{
		super(group, radioLabel);
		addOnActivate(&choose);
		
	} // this()
	
	
	void choose(MenuItem mi)
	{
		bool radioMenuItemState;
		
		radioMenuItemState = getActive();
		
		if(radioMenuItemState == true)
		{
			writeln(getLabel(), " : active");
			workingCallback();
		}
		else
		{
			writeln(getLabel(), " : inactive. ");
		}
	}

	void workingCallback()
	{
		writeln("Callback called from ", getLabel());
		
	} // workingCallback()
	

} // class MyRadioMenuItem
```

Firstly, this constructor is designed to build a generic `RadioMenuItem`  (as opposed to one with a function different from others in the same set) and to that end, it takes two arguments:

- a `ListSG group`, and
- a string of label text.

We'll talk more about the group argument when we get to the `FileMenu` class.

And as for the callback, we’re looking at a different approach to signal handling. In the `RadioButton` example, all we had to do was react to the signal and our work was done. But with `RadioMenuItem`, we have to:

- react to the signal,
- go find the state of the `RadioMenuItem`, and finally
- take action (or not) based on that state.

## RadioMenuItem with a Different Signal

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/012_menus/menu_13.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/012_menus/menu_13_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/012_menus/menu_13_simple_radiomenuitems_toggle.d" target="_blank">here</a>.
	</div>
</div>

Note: The `onToggle` signal also works as can be seen in this bonus example which differs only in which signal is used.

Now let’s look at the `FileMenu` class...

### FileMenu Class

Here’s what it looks like:

```d
class FileMenu : Menu
{
	MyRadioMenuItem radioItem01, radioItem02, radioItem03;
	ListSG group;
	
	this()
	{
		super();
		
		radioItem01 = new MyRadioMenuItem(group, "Radio 01");

		radioItem02 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 02");
		radioItem03 = new MyRadioMenuItem(radioItem01.getGroup(), "Radio 03");
		
		append(radioItem01);
		append(radioItem02);
		append(radioItem03);
		
	} // this()
	
} // class FileMenu
```

We’ve worked with the `ListSG group` before, but perhaps without realizing it. If you look back at [the example code for a RadioButton](https://github.com/rontarrant/gtkd_demos/blob/master/002_button/button_13_radiobutton.d), you’ll see that the group is not named up front like it is here. Instead, it's declared and defined somewhere in the inner workings of the first `RadioButton`'s constructor and we only see it as a member of the `radioItem01` object.

But, in the current case, a non-instantiated `ListSG group` is declared in the `FileMenu` object (which is coming up next in this discussion) and passed along to the super-class's constructor. Internally, as far as the super-class is concerned, nothing's all that different. It still does the heavy lifting and it still stores `group` as a member variable in `radioItem01`. The only thing that changed was how the `group` variable started out. In the earlier example, it was created by the super-class. This time, it starts as a local variable here in the `FileMenu` object.

And is there a difference? Not really. It's just another option. In fact, you may think you can pass `group` as an argument to `radioItem02` and `radioItem03`, but if you do, their constructors assume it's undefined and overwrite it. The result is that you end up with each `RadioMenuItem` in its own private group instead of being part of a set.

*Aside: This process of passing an undefined group to the first `RadioMenuItem` also works with `RadioButton` as can be seen in [this bonus code example](https://github.com/rontarrant/gtkd_demos/blob/master/002_button/button_17_pregroup_radiobuttons.d). Look in these areas to see the changes:*

- the import statements for `import glib.ListSG`,
- the `RadioBox` class, and
- the `MyRadioButton` class.

And that’s it for this time, but we’ll be back with the practical example on Tuesday. See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/19/0028-checkmenuitems.html">Previous: CheckMenuItem</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/26/0030-radiomenuitem-practical.html">Next: Practical RadioMenuItem</a>
	</div>
</div>
