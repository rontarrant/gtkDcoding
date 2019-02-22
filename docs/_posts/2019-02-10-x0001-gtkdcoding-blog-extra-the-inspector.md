# gtkDcoding Blog Extra #0001

It being Sunday, I went looking for something fun and interesting to do, code-wise, and ran across the GTK+ Inspector. I had no idea it would work on Windows 10, but it does.

If you have the GTK+ runtime installed, you’ve got access. All you need to do is open a Command Prompt (or shell) and type:

	gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true

Now you can open any GtkD application and `Ctrl-Shift-D` (how appropriate for us) to bring up the Inspector.

## What It Does

Click on any entity listed and the Inspector flashes that entity in your running application so you can make a visual association with the code.

Any Inspector entity with a right-facing arrow can be expanded to show its children and again, click on any child widget and it’ll flash, too… to a point. If you’re drilling down through a menu, for instance, it’ll just keep flashing the top-level menu and once you get to the item level, it just ignore you.

But if you’re exploring the hierarchy of widgets that remain on screen, it’ll keep on flashing the displayed entities all the way down to the bottom-most level.

And that’s just if you’re exploring in the *Object* tab. There are several others of interest: *Resources* show how much RAM each object takes up, the *CSS* tab lets you change the appearance of your widgets, *Visual* lets you try out a whatever GTK themes you have installed, and *General* tells gives you some details of the hardware, OS, and the GTK+ version you’re running.

At some point in the future, I want to explore CSS as it applies to GTK+ applications, so keep an eye out.

What more can you do with the Inspector? Rather than reproduce a perfectly good explanation that already exists, [I’ll just share the link with you]( https://blog.gtk.org/2017/04/05/the-gtk-inspector/).

And that’s it for this *gtkDcoding Blog Extra*. See you on Tuesday, February 12 for our regularly-scheduled post wherein we'll discuss Box widgets. Until then...
