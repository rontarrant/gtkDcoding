---
title: "0031: Menus VI - Image on a Menu"
topic: menu
layout: post
description: How to use an image in a GTK MenuItem - a D language tutorial.
author: Ron Tarrant

---

# 0031: Menus VI - Image on a Menu

The *GTK* `ImageMenuItem` has been deprecated, but...

For crossing language barriers or giving your application visual appeal, nothing beats an image. So how can we stick one in a menu?

As it turns out (surprise, surprise) a `MenuItem` is actually a container, so adding images is rather easy. The `MenuItem` shares characteristics with the `Button` widget in that it can hold one item and only one item.

## The FakeImageMenuItem

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/012_menus/menu_012_14.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/012_menus/menu_012_14_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_14_fake_image_item.d" target="_blank">here</a>.
	</div>
</div>

Only one part of the source is significantly different, so we’ll concentrate on that. Just because the `ImageMenuItem` has been deprecated doesn’t stop us from faking it like this:

```d
class FakeImageMenuItem : MenuItem
{
	string actionMessage = "You have added one (1) apple to your cart.";
	ImageMenuBox imageMenuBox;
   
	this()
	{
		super();
		
		imageMenuBox = new ImageMenuBox();
		add(imageMenuBox);
		
		addOnActivate(&reportStuff);
		
	} // this()
	
	
	void reportStuff(MenuItem mi)
	{
		writeln(actionMessage);
		
	} // exit()
	
} // class FakeImageMenuItem
```

The defined variables at the top are pretty obvious:

- `actionMessage` : give the user feedback when the `MenuItem` is selected, and
- `ImageMenuBox` : a `Box` to stuff things into.

Then, just like a `Button`, we `add()` the `Image` and then set up a signal.

This callback is nothing unusual, so let’s look at where all that `Box` stuffing was delegated to...

### The ImageMenuBox Class

And here it is:

```d
class ImageMenuBox : Box
{
	string imageLabelText = "Buy an Apple";
	string imageFilename = "images/apples.jpg";
	Image image;
	Label label;
	
	this()
	{
		super(Orientation.HORIZONTAL, 0); // no padding
		
		image = new Image(imageFilename);
		label = new Label(imageLabelText);

		packStart(image, true, true, 0);
		packStart(label, true, true, 0);
		
	}

} // class ImageMenuBox
```

In the initialization phase, we define an `Image` and a `Label` to stuff into the `Box`. Once they’re instantiated in the constructor, we pack them in and that’s that.

*Note:* Padding *is optional. The `Image` and `Label` are spaced far enough apart to look aesthetically pleasing without it, but that can’t stop you from experimenting.*

## The FakeIconMenuItem

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/012_menus/menu_012_15.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/012_menus/menu_012_15_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/012_menus/menu_012_15_fake_icon.d" target="_blank">here</a>.
	</div>
</div>

This second example shows that using stock icons instead of images is also possible.

This is pretty much the same as using an image, code-wise, although I would like to point out where the icons are and which ones are usable under these circumstances. Let’s start with the code and go from there:

```d
class IconMenuBox : Box
{
	string menuLabelText = "Buy a _Plane";
	Image icon;
	string iconName = "airplane-mode-symbolic";
	Label label;	
	
	this()
	{
		super(Orientation.HORIZONTAL, 0); // no padding 'cause we're on a menu
		
		icon = new Image(iconName, IconSize.MENU);
		label = new Label(menuLabelText);

		packStart(icon, true, true, 0);
		packStart(label, true, true, 0);
		
	}

} // class IconMenuBox
```

See? Nothing earth-shattering or (really) all that different, so let's talk about the nitty-gritty details...
  
### Icons

Okay, there are a few things you need to know...

**First**, you’ll wanna know where the icons live so you can look at them and decide which you wanna use. On *Windows*, you’ll find them either here:

```
C:\Program Files\GTK3-Runtime Win64\share\icons
```

or here:

```
C:\Program Files\GTK3-Runtime\share\icons
```

On *Linux*, icons are part of the desktop theme system and you’ll find them here:

```
/usr/share/icons
```

You'll have to drill down into one of the theme directories to see the actual icons.

**Second**, I played around with these a bit and discovered a few things:

- when referring to the icon in your code, always drop the file extension,
- if an icon filename ends in ‘`-symbolic.symbolic.png`’ keep ‘`-symbolic`’ and drop ‘`.symbolic.png`’,
- the icon set used in menus is normally 16x16 (the size is determined by IconSize.MENU).

**Third**, you can’t make an ad hoc addition to any of these icon sets without rolling up your sleeves and diving into *Linux* theme creation. Getting them from there to *Windows* will be another whole can of worms. Both of these endeavours is beyond the scope of this blog.

## Conclusion

So my advice on this point is, if you wanna roll your own custom images for menus (or anything other part of a UI) and make them look like icons, use the `FakeImageMenuItem` approach and just make the image 16x16 pixels. Oh. And hire an experienced artist. Too many of them get asked to do stuff for no money and they're worth paying. Seriously.

And here we are at the end of another *gtkDcoding* blog post. May you never get involved in a fish-slap dance... unless you're willing to get wet. See you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/04/26/0030-radiomenuitem-practical.html">Previous: Practical RadioMenuItem</a>
	</div>
	<div style="float: right;">
		<a href="/2019/05/03/0032-accelerator-keys.html">Next: Accelerator Keys</a>
	</div>
</div>
