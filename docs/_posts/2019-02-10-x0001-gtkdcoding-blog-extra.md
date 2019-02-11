# gtkDcoding Blog Extra #0001

It being Sunday, I went looking for something fun and interesting to do, code-wise, and ran across the GTK+ Inspector. I had no idea it would work on Windows 10, but it does.

If you have the GTK+ runtime installed, you’ve got access. All you need to do is open a Command Prompt (or shell) and type:

	gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true

Now you can open any GtkD application and `Ctrl-Shift-D` (how appropriate for us) to bring up the Inspector.

## What It Does

Click on any widget in the list and the Inspector flashes that part of the application's GUI so you can make a visual association with the code.

Any widget listed in the Inspector that has a right-facing arrow can be expanded to show its children, so you can drill down through a menu, or from a GTK Window to a Box, then a Button and then its Label.

And that’s just if you’re exploring in the *Object* tab. There are several others of interest: *Resources* show how much RAM each object takes up, the *CSS* tab lets you change the appearance of your widgets, *Visual* lets you try out whatever GTK themes you have installed, and *General* gives you some details of the hardware, OS, and the GTK+ version you’re running.

At some point in the future, I want to explore CSS as it applies to GTK+ applications, so keep an eye out.

What more can you do with the Inspector? Rather than reproduce a perfectly good explanation that already exists, [I’ll just share the link with you]( https://blog.gtk.org/2017/04/05/the-gtk-inspector/).

And that’s it for this *gtkDcoding Blog Extra*. See you on Tuesday, February 12 for our regularly-scheduled post wherein we'll discuss Box widgets. Until then...
