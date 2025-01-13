---
title: "0013: Scrolled Layout"
topic: container
tag: container
layout: post
description: How to scroll the contents of a GTK Layout container - a D language tutorial.
author: Ron Tarrant

---

# 0013: Scrolled Layout

This time around, we’ll be looking at how to do a...

## Scrolled Layout

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/004_layout/layout_03.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/004_layout/layout_03_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/004_layout/layout_03_scrolled.d" target="_blank">here</a>.
	</div>
</div>

It’s possible to roll your own scrolling layout by creating *Adjustment* widgets and sticking them in the layout using *setHadjustment()* and *setVadjustment()*. But maybe you don't want to go to all that trouble. It’s far quicker and less work to stuff the *Layout* into a *ScrolledWindow* widget instead. So, that’s what we’ll do for now. Sometime down the road, we’ll look into doing it the hard way because now that I’ve said it’s rare to need a Layout done that way, it’s far more likely to come up.

Because there really isn’t any need for a class derived from *ScrolledWindow*, we’ll stuff it into the *TestRigWindow* class:

```d
class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		setSizeRequest(200, 200);
		
		ScrolledWindow scrolledWindow = new ScrolledWindow();
		add(scrolledWindow);
		
		auto myLayout = new MyLayout();
		scrolledWindow.add(myLayout);

		showAll();

	} // this() CONSTRUCTOR
	
	
	void quitApp()
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class myAppWindow
```

Nothing out of the ordinary here. Create the *ScrolledWindow* object, add it to the *TestRigWindow*, then create the *Layout* and stuff it into the *ScrolledWindow*.

And everything else in this example is similar to what we've covered before. Compile and run the code to see the scrollbars. If you’re running on Windows, you may have to look closely to see the scrollbars. I haven’t yet found a way to make them bigger, but when I do, I’ll cover it in a later blog post.

And since that didn’t take much time or effort, let’s look at another example, the tooltip.

## Tooltip

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/004_layout/layout_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/004_layout/layout_04_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkd_demos/blob/master/004_layout/layout_04_tooltip.d" target="_blank">here</a>.
	</div>
</div>

In *GTK*, it used to be that tooltips took a lot of time and effort to figure out and put into practice, but by the time version 3.x came along, things had changed. Now tooltips are built right in at the generic *Widget* level, so now it's like falling off a skateboard, anyone can do it. So, let’s look at the derived *Button* class to see how it’s done:

```d
class TooltipButton : Button
{
	this()
	{
		super();

		// a rotated label
		RotatedLabel myRotatedLabel = new RotatedLabel();
		add(myRotatedLabel);

		addOnClicked(delegate void(_) { doSomething(); } );

		setHasTooltip(true);
		setTooltipText(myRotatedLabel.getText() ~ "\nClick me and see what happens.");

	} // this()


	void doSomething()
	{
		writeln("Action from a rotated button...");
		
	} // doSomething()
	
} // class TooltipButton
```

This is so easy compared to the original way. All you have to do is:

- tell the *Button* to use its built-in *Tooltip* with *setHasTooltip(true)*, and
- tell the *Tooltip* what to say with *setTooltipText("whatever string you want")*.

In the example, I opted to grab the *Button*’s *Label* text and put that in the *Tooltip* along with a message.

### There’s that Rotated Label Again

Yeah, it’s one reason which leaps to mind for actually needing a *Tooltip* on a *Button*. It's not the only reason, but if you've ever used software with sideways labels, you know it can be a literal pain the neck. Besides, for our purposes, this seems logical, so there it is.

## Conclusion

Two for the price of one, a scrolled layout and a tooltip. The coolness just amps up every step along the path here. But now it’s time, gentlefolk, please. So have a good coding experience and I’ll see you next time.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/02/22/0012-layout-containers.html">Previous: Layout Containers</a>
	</div>
	<div style="float: right;">
		<a href="/2019/03/01/0014-reacting-to-mouse-events.html">Next: Mouse Events</a>
	</div>
</div>
