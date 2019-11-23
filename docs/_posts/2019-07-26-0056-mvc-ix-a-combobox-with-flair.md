---
title: "0056: MVC IX – A Fancy ComboBox"
layout: post
topic: mvc
description: GTK Tutorial - customize a ComboBox with images and text.
author: Ron Tarrant

---

# 0056: MVC IX – A Fancy ComboBox

<div class="screenshot-frame">
	<div class="frame-header">
		Results of this example:
	</div>
	<div class="frame-screenshot">
		<figure>
			<img id="img0" src="/images/screenshots/017_mvc/mvc_017_13.png" alt="Current example output">		<!-- img# -->
			
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
			<img id="img1" src="/images/screenshots/017_mvc/mvc_017_13_term.png" alt="Current example terminal output">		<!-- img#, filename -->

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
		The code file for this example is available <a href="https://github.com/rontarrant/gtkDcoding/blob/master/017_mvc/mvc_017_13_combobox_weather.d" target="_blank">here</a>.
	</div>
</div>

And here's a link to [the companion files]( https://github.com/rontarrant/gtkDcoding/blob/master/downloads/weather_combobox.zip).

Everything presented today is something we’ve looked at before. What’s different is how it’s all put together to make the *Weather ComboBox* example. So, we'll skim through to see those changes before checking out how this whole thing is put together.

First, there's this import:

```d
import singleton.S_DetectedOS;
```

It's there because we need to know which OS we're working with, but we'll talk more about that in a moment.

And then there's...

## The AppBox

This is where we instantiate:

- `weatherListStore`, and
- `weatherComboBox`.

But, that's nothing unusual, so moving right along...

## The WeatherListStore Class

Right at the top of the preamble (which could also be referred to as the instantiation section, the list of class-level properties) we’ve got:

```d
S_DetectedOS s_detectedOS;
```

Because fonts aren't all the same on every OS, this declares a singleton we use to discover which operating system we’re running on. Once we know that, we can look for fonts that fit the design we have in mind.

```d
string[] _textItems = ["Sunny", "Partly Cloudy", "Cloudy", "Rainy", "Thunderstorm", "Snowy"];
string[] _fontNames;
int[] _fontSizes = [12, 13, 14, 15, 16, 17];

float[][] _fgColors = [[.027, .067, .855, 1.0], [.02, .043, .576, 1.0], [.012, .031, .404, 1.0], 
								 [.741, .757, .816, 1.0], [.894, 1.0, 0.0, 1.0], [0.0, .933, 1.0, 1.0]];
								 
float[][] _bgColors = [[.592, .957, 1.0, 1.0], [.522, .847, .882, 1.0], [.365, .596, .62, 1.0], 
								 [.259, .42, .435, 1.0], [.18, .29, .302, 1.0], [1.0, 1.0, 1.0, 1.0]];

string[] _images = ["_images/sun_50x.png", "_images/partly_cloudy_50x.png", "_images/cloudy_50x.png",
							 "_images/rainy_50x.png", "_images/thunder_50x.png", "_images/snowy_50x.png"];
```

After that comes:

- a list of text arrays,
- font names and sizes,
- background and foreground colors—which can be set for each individual item in a `ComboBox`’s list—and
- finishing up with a list of image file names we’ll load in the constructor.

Next are declarations for a `PgFontDescription` and a `TreeIter`, followed by an auto-numbered `Column` enum, all of which we used last time. Notice that the `enum` is in the `public` section of our class so it can be accessed directly from inside other classes. *(Note: `public` and `private` will only take on their true meanings if we move this class into its own module.)*

```d
PgFontDescription fontDesc;
TreeIter _treeIter;
	
public:
enum Column
{
	TEXT = 0,
	FONT,
	COLOR_ON,
	FG_COLOR,
	BG_COLOR,
	IMAGE
	
} // enum Column
```

## The WeatherListStore Constructor

There’s a lot going on here, so let’s break it down a bit...

### Initialization

```d
string textItem, fontName, imageName;
float fgRed, bgRed, fgGreen, fgAlpha, bgGreen, fgBlue, bgBlue, bgAlpha;
int fontSize;
		
super([GType.STRING, PgFontDescription.getType(), GType.INT, RGBA.getType(), RGBA.getType(), Pixbuf.getType()]);

assignFonts();
```

Notice that the colors are broken down into red, green, and blue components and they’re all floating point. We’ll talk more about that in a moment.

And our array of `GType`s shows several examples of how to grab a `GType` from a *GTK* or *GDK* class using the `getType()` function.

Lastly, we make a call to the `assignFonts()` function which we’ll talk about later.

### Building the Store

We build the store with this code where we grab a text description of the weather, a font name, and a size:

```d
for(int i; i < _textItems.length; i++)
{
	textItem = _textItems[i];
	fontName = _fontNames[i];
	fontSize = _fontSizes[i];
```

Then put together the R, G, B, and alpha components of the colors:

```d
fgRed = _fgColors[i][0];
fgGreen = _fgColors[i][1];
fgBlue = _fgColors[i][2];
fgAlpha = _fgColors[i][3];
		
bgRed = _bgColors[i][0];
bgGreen = _bgColors[i][1];
bgBlue = _bgColors[i][2];
bgAlpha = _bgColors[i][3];
```

Look back at the instantiation section of the `WeatherListStore` and note that the numbers for the colors range between 0.0 and 1.0. If you work out your color palette in *Photoshop* or using online web-related resources, you’ll likely end up with R, G, and B values ranging from 0 to 255, but to convert them is easy and could even be done right here in the constructor like this:

```d
fgRed = _fgColors[i][0] / 255;
bgGreen = _bgColors[i][1] / 255;
bgBlue = _bgColors[i][2] / 255;
bgAlpha = _bgColors[i][3];
```

But I opted to do the conversions off-screen, so to speak. Still, do the conversion for each component and you're done.

*Note: The alpha value is between 0.0 and 1.0, even for* CSS/HTML *so no conversion needed.*

*Note 2: In* Photoshop, *if you switch to 32-bit color values* (Image *menu >* Mode *>* 32-bits/Channel) *component values are between 0.0 and 1.0, so you won't have to convert.*

Next, we grab an image name:

```d
imageName = _images[i];
```

Instantiate the `TreeIter` and `PgFontDescription` objects:

```d
_treeIter = createIter();
fontDesc = new PgFontDescription(fontName, fontSize);
```

And set all the values. Notice that we’re dealing with six columns here, most of which will be used for setting attributes when we get to building the `ComboBox`.

```d
	setValue(_treeIter, Column.TEXT, textItem);
	setValue(_treeIter, Column.FONT, fontDesc);
	setValue(_treeIter, Column.COLOR_ON, true);
	setValue(_treeIter, Column.FG_COLOR, new RGBA(fgRed, fgGreen, fgBlue, fgAlpha));
	setValue(_treeIter, Column.BG_COLOR, new RGBA(bgRed, bgGreen, bgBlue, bgAlpha));
	setValue(_treeIter, Column.IMAGE, new Pixbuf(imageName));
}
```

### Assigning Fonts

This function is where we find out which OS we’re running on and make sure the fonts are ones we’re likely to find on that platform. Here’s the code:

```d
void assignFonts()
{
	s_detectedOS = s_detectedOS.get();
		
	switch(s_detectedOS.getOS())
	{
		case "Windows":
			writeln("Windows found");
			_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
		break;
			
		case "OSX":
			_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
		break;				
		
		case "Posix":
			writeln("Linux found");
			_fontNames = ["FreeSerif", "Garuda", "Century Schoolbook L", "Kalimati", "Purisa", "FreeMono"];
		break;

		default:
			writeln("No known OS found");
			_fontNames = ["Times New Roman", "Arial", "Georgia", "Verdana", "Comic Sans MS", "Courier New"];
		break;
	} // switch
	
} // assignFonts()
```

We start by instantiating a singleton for the detected OS, then use a switch statement to pick fonts based on which OS we find.

Now let’s get to...

## The WeatherComboBox Class

This is where everything comes together. We start off by declaring all the stuff we need:

```d
class WeatherComboBox : ComboBox
{
	private:
	bool entryOn = false;
	WeatherListStore _weatherListStore;
	CellRendererText cellRendererText;
	CellRendererPixbuf cellRendererPixbuf;
	int activeItem = 0;
```

Note we’ve got the `Entry` flag turned off and the active item will be the first one in the `ListStore`. 

And then the constructor:

```d
public:
this(WeatherListStore weatherListStore)
{
	super(entryOn);
```

where we set up and bring in the store:

```d
_weatherListStore = weatherListStore;
setModel(_weatherListStore);
setActive(activeItem);
```

then hook up the callback signal:

```d
addOnChanged(&doSomething);
```

set up the `ComboBox`'s column to render text:

```d
cellRendererText = new CellRendererText();
packStart(cellRendererText, false);
addAttribute(cellRendererText, "text", _weatherListStore.Column.TEXT);
```

and grab attributes from the `ListStore`’s extra columns which are used to set the font, the text color, and background color:

```d
addAttribute(cellRendererText, "font-desc", _weatherListStore.Column.FONT);
addAttribute(cellRendererText, "foreground-rgba", _weatherListStore.Column.FG_COLOR);
addAttribute(cellRendererText, "foreground-set", _weatherListStore.Column.COLOR_ON);
addAttribute(cellRendererText, "background-rgba", _weatherListStore.Column.BG_COLOR);
addAttribute(cellRendererText, "background-set", _weatherListStore.Column.COLOR_ON);		
```

And we finish off by stuffing in a second `CellRenderer` for the images:

```d
	cellRendererPixbuf = new CellRendererPixbuf();
	packStart(cellRendererPixbuf, false);
	addAttribute(cellRendererPixbuf, "pixbuf", _weatherListStore.Column.IMAGE);
	
} // this()
```

And just for completeness sake, here’s the OS detection module which you'll find in the companion zip file (We linked to it at the top, but [here it is again]( https://github.com/rontarrant/gtkDcoding/blob/master/downloads/weather_combobox.zip)). Because we’ve seen these a couple of times already, I won’t go into detail, but it’s patterned after the same [thread-safe singleton found here]( https://wiki.dlang.org/Low-Lock_Singleton_Pattern). And here it is, the `S_DetectedOS.d` module:

```d
module DetectedOS;

import std.stdio;

class S_DetectedOS
{
	private:
	string _os_type;
	static bool instantiated_;
	__gshared S_DetectedOS instance_;

	this()
	{
		version(Windows)
		{
			_os_type = "Windows";
		}
		else version(OSX)
		{
			_os_type = "OSX";
		}
		else version(Posix)
		{
			_os_type = "Posix";
		}

	} // this()


	public:
	static S_DetectedOS get()
	{
		if(!instantiated_)
		{
			synchronized(S_DetectedOS.classinfo)
			{
				if(!instance_)
				{
					instance_ = new S_DetectedOS();
				}

				instantiated_ = true;
			}
		}
		
		return(instance_);
		
	} // DetectedOS()
	
	
	string getOS()
	{
		writeln("returning: ", _os_type);
		return(_os_type);
		
	} // getOS()

} // class S_DetectedOS
```

And that’s it.

## Conclusion

It came as a surprise to me when I discovered all this. Who’d’a thunk you could get so fancy with a `ComboBox`.

Until next time, happy computing.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/07/23/0055-mvc-viii-dynamically-loading-a-treeview.html">Previous: TreeView - Dynamic Population</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/30/0057-cairo-i-the-basics.html">Next: Introduction to Cairo Drawing</a>
	</div>
</div>