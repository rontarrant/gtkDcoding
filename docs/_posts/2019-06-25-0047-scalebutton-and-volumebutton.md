---
title: "0047: The ScaleButton and VolumeButton"
topic: button
layout: post
description: How to use the GTK VolumeButton and the ScaleButton.
author: Ron Tarrant

---

# 0047 – The ScaleButton and VolumeButton

Because the `ScaleButton` is the more involved of these two, I’m going to start with...

## The VolumeButton

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/010_more_buttons/button_010_10.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/010_more_buttons/button_010_10_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_10_volume.d" target="_blank">here</a>.
	</div>
</div>

As with our previous example of the `SpinButton`, nothing really changes at the top of the file except a couple of import statements:

{% highlight d %}
	import gtk.VolumeButton;
	import gtk.ScaleButton;
	import gtk.Adjustment;
{% endhighlight %}

and the class derived from the `VolumeButton`:

{% highlight d %}
	class MyVolumeButton : VolumeButton
	{
		double minimum = 0;
		double maximum = 10;
		double step = 1;
	
		Adjustment adjustment;
		double initialValue = 7;
		double pageIncrement = 1;
		double pageSize = 1;
		
		this()
		{
			double compensateForWinBug = initialValue + 1;
			super();
			
			adjustment = new Adjustment(compensateForWinBug, minimum, maximum, step, pageIncrement, pageSize);
			setAdjustment(adjustment);
			setValue(initialValue);
			addOnValueChanged(&valueChanged);
			
		} // this()
		
		
		void valueChanged(double value, ScaleButton sb)
		{
			writeln(getValue());
			
		} // valueChanged()
	
	
	} // class MyVolumeButton
{% endhighlight %}

As before, we have to set up an `Adjustment` object in the constructor, but you’ll notice there’s an extra step.

When we instantiate the `Adjustment`, the initial value is set to `compensateForWinBug` which is evaluated as `initialValue + 1` and later, it’s set again:

{% highlight d %}
      setValue(initialValue);
{% endhighlight %}

This is because the *Windows* version of *GTK* has a bug that—at runtime—causes the wrong icon to be shown initially when using the `ScaleButton` or its child, the `VolumeButton`. And the workaround is to set the `Adjustment`’s initial value and then change it right away before the user sees it.

Also, because the value of `compensateForWinBug` depends on the value of another variable, we have to set it inside a function because the compiler won't know the value of that other variable at compile time. 

Anyway, so much for the `VolumeButton`. Let’s look at its parent…

## The ScaleButton

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/010_more_buttons/button_010_09.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/010_more_buttons/button_010_09_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_09_scale.d" target="_blank">here</a>.
	</div>
</div>

I’m presenting this example second because the ScaleButton needs a set of icons passed in when it’s instantiated. Rather than being a big pain, however, it means we can play around with the icons displayed on the button when various values are set.

*Note: You can use the ScaleButton with an empty icon array, but it ain't pretty.*

The obvious set of icons to use is the same one found on the `VolumeButton`, but after a few minutes of digging in the icon folders, I found some that better suited the purposes of this demonstration. But before we go there

**`<Reminder Mode: ON>`**

### Icons

Two things to remember...

First, you’ll wanna know where they are. On *Windows*:

	C:\Program Files\GTK3-Runtime Win64\share\icons

or here:

	C:\Program Files\GTK3-Runtime\share\icons

On Linux:

	/usr/share/icons

Second, the icons used for buttons are the 16x16 set.

**`<Reminder Mode OFF>`**

### The ScaleButton Class

As before, only one segment of this code file is different (and, truth be told, not all that different):

{% highlight d %}
	class MyScaleButton : ScaleButton
	{
		double minimum = 0;
		double maximum = 10;
		double step = 1;
	
		Adjustment adjustment;
		double initialValue = 5;
	
		double pageIncrement = 1;
		double pageSize = 0;
		
	//	string[] icons = ["audio-volume-muted", "audio-volume-high", "audio-volume-low", "audio-volume-medium"];
		string[] icons = ["face-crying", "face-laugh", "face-embarrassed", "face-sad", "face-plain", "face-smirk", "face-smile"];
	//	string[] icons = ["face-crying", "face-laugh", "face-plain"];
	//	string[] icons = ["face-crying", "face-laugh"];
	//	string[] icons = ["face-plain"];
		
		this()
		{
			double compensateForWinBug = initialValue + 1;

			super(IconSize.BUTTON, minimum, maximum, step, icons);
			
			adjustment = new Adjustment(compensateForWinBug, minimum, maximum, step, pageIncrement, pageSize);
			setAdjustment(adjustment);
			setValue(initialValue);
	//		addOnValueChanged(&valueChanged);
			
		} // this()
		
		
		void valueChanged(ScaleButton sb)
		{
			writeln(getValue());
			
		} // valueChanged()
	
	
	} // class MyScaleButton
{% endhighlight %}

As with the `VolumeButton`, we have to set and then reset the initial value so the proper icon is displayed on start-up, but now let's talk about this icon stuff…

### Defining an Icon Set

There are two ways to go about this:

- with a set (read: array) of just two icons:
	- the first is used for the lower end of the scale, and
	- the second is used for the high end, but
- with three icons:
	- the first is used for the minimum setting only,
	- the second is used for the maximum setting only,
	- and the third is used for everything in between, but-but...
- with four or more icons,
	- the first and second are used for minimum and maximum, and
	- the rest are spread evenly across the rest of the range.

I left a bunch of different icon sets commented out in the code file so you have something to experiment with.

## Conclusion

And there you go, the `ScaleButton` and the `VolumeButton` in party hats. Stay happy, keep coding, and see you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/06/21/0046-the-spinbutton.html">Previous: SpinButton</a>
	</div>
	<div style="float: right;">
		<a href="/2019/06/28/0048-mvc-i-introduction.html">Next: Introduction to the Model-View-Controller</a>
	</div>
</div>
