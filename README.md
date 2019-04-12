# gtkDcoding README
GtkD is GTK+ for the D programming language. And what is GTK+? It's a GUI building toolkit for desktop applications and works on a number of POSIX operating systems (UNIX, UNIX-like, and OSX) as well as Windows. Together with D, GtkD can be used to build cross-platform desktop applications in a write-once-compile-for-many process.

This repository is where I keep all the example code I've written for GtkD. Each example is written to demonstrate just one technique. For instance, in the buttons section, there are examples for each of the button types as well as how each of the available signals are handled. Each is written with the least amount of clutter and with comments intended to maximize clarity.

I've only been working with D and GtkD for a couple of months, so the Dlang and GtkD forums have been invaluable to furthering my understanding. Thanks are very much in order.

In the spirit of the community, and with a tip of the hat to Richard Stallman, all code contained in this blog is public domain. If it helps you better understand GtkD or helps you remember how a particular technique is done, then it's served its purpose.

## Versions
Most of the examples I've found online up until now (January 2019) are for earlier versions of GTK or GtkD. Most of that code is still valid, but they also use a fair number of deprecated library calls. For instance, the gtk Table is deprecated, so I've used gtk Grid in its place to get similar results. 

Time marches on and updates for all these things keep on a-coming down the pike. I've written this cautionary note in case you find some ten years down the road that these examples either use deprecated routines or just don't compile/run at all.

Here are the versions of the various software and libraries I've used:

- dmd reference compiler: 2.082.1 
- GtkD library wrapper: 3.8.4
- gtk runtime (Windows 10): 3.22.24-1 (64-bit) 

If and when any of these are updated, I'll mention it as a PS here in this readme.md file.

-Ron Tarrant
(January 17, 2019)

[Read the blog](http://gtkDcoding.com)

2019-02-22: I've switched from Windows to Linux Mint 19.1 (xfce) as my main platform for development and blog contributions. I'll be doing a *howto do this on Linux* write-up soon.

2019-04-12: I've switched back to Windows. Linux has come a long way, but I'm so used to how things are done on Windows. Like, for instance, starting an application and having the window open in the same place I last used it. Dialogs, too. Having windows open in the same default position every single time is fine for a single-monitor set-up, but with three, I'm getting a kink in my neck trying to find stuff. Also, I much prefer PSPad as an editor over anything I've found so far on Linux. Maybe I'm just set in my ways, but most other editors just feel wrong by comparison.

I also forgot to mention a few weeks back when I switched from GtkD 3.8.4 to GtkD 3.8.5. I do apologize. On the other hand, I haven't noticed (or heard of) anything breaking, so perhaps it's not a big deal.
