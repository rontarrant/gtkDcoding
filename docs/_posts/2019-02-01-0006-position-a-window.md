---
title: 0006 - Position a Window
layout: post
description: How to position a GTK window.
author: Ron Tarrant
keywords:
- GtkD
- GTK+ 3
- dlang
- D language
- Graphical User Interface
- GTK Window
---

## 0006 - Position a Window

Sometimes you need a window to land in a specific spot on the screen. As a user, I like windows and dialogs to open in the last position I used and closed them. This is pretty much mandatory behaviour with a three-monitor set-up so I don't waste time scanning all that screen real estate to figure out where my application or dialog just opened.

For [this example](https://github.com/rontarrant/gtkDcoding/blob/master/001_window/window_001_05_positioned.d), I used two buttons, one to move the window up and to the left, the other to move it down to the right. And because of that, I had to use a Box object because (if you remember) we can’t put more than one object into a window, but we can if we use a Box and put the Box in the window.

### Something New

The other thing I introduce here is D language’s interface which is used to sketch out a plan for classes which will be similar enough to share functions and data, but not so similar that the functions will all do exactly the same things in the same way. In our case, we want one button to move the window to the left, the other to the right. That similar enough in that the window’s moving somewhere, but the destinations are different.

The interface could also be said to lay down the rules for Buttons that change the position of the window. By reading through the interface’s code, we can see that it:

- returns on value,
- has a meaningful name (PositionButton),
- it has one function that all derived buttons must also have (moveWindow), and
- it takes a GTK MainWindow as an argument.

### Inheritance in D

LeftButton and RightButton are the derived Buttons. They inherit from both our interface as well as the top-level Button class.

The rules regarding inheritance in D are:

- an interface can inherit only from another interface,
- a class can inherit from one other class, but
- a class can also inherit from an many interfaces as you need it to, and
- when listing what a class inherits from, you have to list the class first, then any interfaces.

Both LeftButton and RightButton are set up with the same string of inheritances, but implementation of functions? That’s another story.

In LeftButton, the moveWindow() function gets the current window position as x and y coordinates, then subtracts 40 and 60 (respectively) from x and y, then calls the window’s move() function.

RightButton does the same thing, but adds to x and y instead of subtracting. In fact, all I did to create RightButton was copy/paste, change minus signs to plus and replace ‘Left’ with ‘Right.’

### Conclusion

Okay, a short one this time. Until next time, keep those cards and letters coming in and stay happy.

