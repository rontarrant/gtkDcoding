---
title: "0071: Statusbar Part II - Expanding on the Statusbar"
layout: post
topic: bar
tag: bar
description: GTK Tutorial that covers adding more status reports to a Statusbar.
author: Ron Tarrant

---

# 0071: Statusbar Part II - Expanding on the Statusbar

Something about the `Statusbar` widget that isn’t apparent at first glance is that it’s a type of *GTK* `Container`, a `Box` to be exact. And what magic gives it the ability to display strings? It contains a `Label` and the `push()` function is wired straight into it.

But even more interesting is that you can stuff other things into the `Box`.

## Multiple Context IDs

<!-- 0, 1 -->
<!-- first occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/bar_04.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/bar_04_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/bar_04_statusbar_multi_contextid.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for first (1st) occurrence of application and terminal screen shots on a single page -->

So, I whipped up an example with a second message. All it took was a `Separator` and a second Label which changed the `MyStatusbar` class to this:

```d
class MyStatusbar : Statusbar
{
	Separator separatorV1;
	Label directionLabel;
	uint contextIDUp, contextIDDown;
	string contextDescriptionUp = "UP", contextDescriptionDown = "DOWN";
	uint padding = 0;
	int labelWidth = 50, labelHeight = 20;
	int marginWidth = 10;
	
	this()
	{
		separatorV1 = new Separator(Orientation.VERTICAL);
		packStart(separatorV1, false, false, padding);
		separatorV1.setMarginLeft(marginWidth);
		separatorV1.setMarginRight(marginWidth);

		directionLabel = new Label("READY");
		directionLabel.setSizeRequest(labelWidth, labelHeight);
		packStart(directionLabel, false, false, padding);

		contextIDUp = getContextId(contextDescriptionUp);
		contextIDDown = getContextId(contextDescriptionDown);
		
	} // this()

} // class MyStatusBar
```

Thing to keep in mind when stuffing extra widgets into the `Statusbar`:

- for visual appeal, make sure to `setMargin()` to the left and right of the `Separator` so the status report strings have ‘breathing’ room (as is done here in this example), and
- use `setSizeRequest()` for the Label—giving it a bit more space than you'll actually need—so the report strings don’t appear to jump back and forth if their lengths change over time, and finally
- setting the text of the first `Label` is still done with `push()`, but
- setting the text in additional `Label`s has to be done by calling each `Label`’s `setText()` function.

The last two points are illustrated by the `onMotion()` callback in `MyDrawingArea`:

```d
public bool onMotion(Event event, Widget widget)
{
	// make sure we're not reacting to the wrong event
	if(event.type == EventType.MOTION_NOTIFY)
	{
		if(event.motion.y < currentY)
		{
			_myStatusbar.push(_myStatusbar.contextIDUp, "Mouse position: " ~ format("%s, %s", event.motion.x, event.motion.y));

       myStatusbar.directionLabel.setText(_myStatusbar.contextDescriptionUp);
		}
		else
		{
			_myStatusbar.push(_myStatusbar.contextIDDown, "Mouse position: " ~ format("%s, %s", event.motion.x, event.motion.y));
			_myStatusbar.directionLabel.setText(_myStatusbar.contextDescriptionDown);
		}

		currentY = event.motion.y;
	}

	return(true);
		
} // onMotion()
```

Notice that because the `Statusbar` is monitoring and reporting on `Event`s in the `DrawingArea`, both of these `Label`s have to be updated by this callback.

Now, we have one more example to look at...

## The Statusbar’s Signal

<!-- 2, 3 -->
<!-- second occurrence of application and terminal screen shots on a single page -->
<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img2" src="/images/screenshots/bar_05.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img3" src="/images/screenshots/bar_05_term.png" alt="Current example terminal output"> 		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/bar_05_statusbar_signal.d" target="_blank">here</a>.
	</div>
</div>
<!-- end of snippet for second (2nd) occurrence of application and terminal screen shots on a single page -->

The `Statusbar` signal, unless we import information from other application objects, only allows access to whatever the `Statusbar` itself contains. The most obvious bit of data to bring in to illustrate a third report is the `contextID`, so we add a second `Separator` and a third `Label` to the `MyStatusbar` constructor and then hook up the signal:

```d
addOnTextPushed(&doSomething);
```

Then we can write a callback to handle the data we glean from the `Statusbar`:

```d
void doSomething(uint contextID, string statusMessage, Statusbar statusbar)
{
	string message = format("Context ID: %d", contextID); 
	contextLabel.setText(message);
	directionLabel.setText(contextDescriptionDown);

} // doSomething()
```

Now the `Statusbar` as three sections:

- mouse coordinates,
- mouse direction, and
- context ID.

## Conclusion

And that’s just about everything I can think of to do with the lowly `Statusbar`. They’re being phased out of most applications these days, but they haven’t been deprecated, so they may very well make a comeback, so we might as well be ready.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/09/13/0070-statusbar.html">Previous: Statusbar Basics</a>
	</div>
<!--
	<div style="float: right;">
		<a href="/2019/09/20/0072-frame-part-i.html">Next: Frames, Part I</a>
	</div>
-->
</div>
