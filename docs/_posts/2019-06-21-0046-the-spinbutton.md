---
title: 0046 - SpinButton
topic: button
layout: post
description: How to use the GTK SpinButton.
author: Ron Tarrant

---

## 0047 – SpinButton

This one’s both easy and tricky. Let me explain…

Have a gander at [the first code file over here](https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_06_spinbutton.d) and you’ll see that the only new-ish bit is this:

	class MySpinButton : SpinButton
	{
		double minimum = -50;
		double maximum = 50;
		double step = 2;
	
		Adjustment adjustment;
		double initialValue = 4;
		double pageIncrement = 8;
		double pageSize = 0;
		
		this()
		{
			super(minimum, maximum, step);
			
			adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
			setAdjustment(adjustment);
			addOnValueChanged(&valueChanged);
			
		} // this()
		
		
		void valueChanged(SpinButton sb)
		{
			writeln(getValue());
			
		} // valueChanged()
	
	
	} // class MySpinButton

One thing to notice here is that the `SpinButton` doesn’t work alone. It needs…

### The Adjustment

Technically, the `Adjustment` isn’t a `Widget` because it’s derived directly from `ObjectG`. This means that it doesn’t have a visual presence, but it does give you control over the range and behaviour of the `SpinButton`.

*Note: The `Adjustment` also helps out a bunch of other `Widget`s including (but not limited to):*

- *the `Container` and its offspring:*
	- *the `Layout`,*
- *the `ScaleButton`, and its child…*
	- *the `VolumeButton`,*
- *the `ScrolledWindow`, and*
- *the `Viewport`.*

In short, anything that needs adjusting. And the `Adjustment` is also the most complicated part of setting up and using a `SpinButton`.

At the top of the `MySpinButton` class definition, there’s a bunch of stuff initialized for use when instantiating the `Adjustment`, and as long as you keep these values sane, you’ll have very little trouble. These values are:

- `minimum` and `maximum` – straightforward, these are the upper and lower limits of the spinner,
- `step` – the increment added to or subtracted from the current value each time the spinner buttons are clicked… or—while the `SpinButton` has focus—each time the up and down arrow keys are pressed,
- `initialValue` – again straightforward, and then there’s…
- `pageIncrement` – how much is added to or subtracted from the spinner's current value when you hit the *Page-up* or *Page-down* keys, and
- `pageSize`… Now, this is an odd one…

### Oddity of the pageSize Argument

With a `SpinButton`, the `Adjustment`'s `pageSize` is best set to ‘0.’

## Variations on a `SpinButton` – Floating Point Values

[In our second example code file](https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_07_multiple_spinbuttons.d), you’ll find (among others) the `FloatSpinButton` class:

	class FloatSpinButton : SpinButton
	{
		float minimum = -1.0;
		float maximum = 1.0;
		double step = .1;
	
		Adjustment adjustment;
		float initialValue = 0.0;
		float pageIncrement = 0.5;
		float pageSize = 0.0;
		
		this()
		{
			super(minimum, maximum, step);
			adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
			setAdjustment(adjustment);
			setWrap(true);
			
			addOnValueChanged(&valueChanged);
	//		addOnOutput(&outputValue);
			
		} // this()
	
		void valueChanged(SpinButton sb)
		{
			writeln("Float Standard", getValue());
			
		} // valueChanged()
	
		
		bool outputValue(SpinButton sb)
		{
			writeln("Float Standard: ", getValue());
			
			return(false);
			
		} // outputValue()
		
	} // class FloatSpinButton

The objective here is to use and show floating point values. But, notice that all the initialized parameters for the `Adjustment` are floats except for `step`. This is because of an oddity in the `Adjustment` object that seems to take two different forms, but rather than bore you with a long explanation, I’ll just give you the short version and jump right to the workaround for the current use-case…

The `SpinButton` has two signals you can hook up to:

- `onValueChanged`, and
- `onOutput`.

And there are a bunch of sane variable types you can use for the values:

- `double`,
- `float`,
- `int`,
- `byte`, and
- you can even fake a *Boolean* by limiting the callback to checking for 0 or 1 only.

For some reason, when combining certain variable types with a certain one or the other of the signals, clicking on the adjustment buttons will cause the signal to fire twice.

*Note: This will also happen if you change the current value by typing into the in-built `Entry` and hitting* Enter. *It won’t double-fire* then, *but it will next time you click on one of the adjustment buttons. At present, I know of no way to avoid this, so if this behaviour will be noticable by your users, you may want to let them know so you don't field a whole raft of bug reports on it.*

#### Troubleshooting a `SpinButton`

So, rule of thumb for using the `SpinButton` or any other widget using the `Adjustment`:

1. If you’re getting double signal firings with the `onValueChanged` signal, switch to the `onOutput` signal… and vice versa.
2. If switching signals doesn't help, try a different variable type (`int`, `byte`, `double`, `float`, etc.)

## Precision

Now have a look at the first chunk of the `PrecisionSpinButton` class:

	class PrecisionSpinButton : SpinButton
	{
		double minimum = -1.0;
		double maximum = 1.0;
		double step = .001;
		uint precision = 3;
	
		Adjustment adjustment;
		double initialValue = 0.0;
		double pageIncrement = 0.01;
		double pageSize = 0.0;
		
		this()
		{
			super(minimum, maximum, step);
			adjustment = new Adjustment(initialValue, minimum, maximum, step, pageIncrement, pageSize);
			setAdjustment(adjustment);
			setDigits(precision);
	
			addOnValueChanged(&valueChanged); // NO double-fire
	//		addOnOutput(&outputValue); // double-fire
			
		} // this()

In the initialization section, we’ve got another variable: `precision`.

It’s used in the constructor with `setDigits()` to set the number of decimal places to show in the spinner.

## Wrapping Up

Now you know how to tame the `SpinButton` and `Adjustment` beasts.

And just for fun, I’ve included [a third code file](https://github.com/rontarrant/gtkDcoding/blob/master/010_more_buttons/button_010_08_spinbutton_experiments.d) with `Double-`, `Float-`, `Precision-`, `Int-`, `Byte-`, and that fake `BoolSpinButtons` I mentioned earlier, just to show how versatile this widget can be.

*Note: The FloatSpinButton example in this file falls victim to GTK's rounding error and so my recommendation is: don't use the SpinButton for floating point values unless you're prepared to deal with the rounding error yourself.*

That’s it for this time around. Have a great day.

<BR>
<div style="float: left;">
	<a href="https://gtkdcoding.com/2019/06/18/0045-split-a-window-into-panes.html">Previous: Split a Window into Panes</a>
</div>
<BR>
