---
title: "X0002: GtkD Linux Development Environment"
topic: linux
layout: post
description: How to install and use a GTK and D-language build environment on Linux Mint.
author: Ron Tarrant

---

## X0002 - GtkD Linux Development Environment

Okay, hold onto your hat, because we’re gonna install and test a D language development environment on Linux.

Disclaimer:
I’ve been away from Linux for a donkey’s age, so I’m only covering what I know so far, the installation procedure on Linux Mint 19.1, the distro I use here. I assume this will also work if you use Ubuntu or Debian, the parent and grandparent distros for Mint, but don't quote me.

However, I have it on a good authority (from Mike Wey, the sole remaining member of the GtkD dev team and keeper of the GtkD forum) that using [the install.sh script](https://dlang.org/install.html) will work for most, if not all, other distros. And for installing GtkD, you can follow the guidelines under *Installation* [at the bottom of this page](https://github.com/gtkd-developers/GtkD/wiki).

Mike also suggested that if your distro includes the D Language and/or GtkD, it's best to use your native package manager for installation. And he kindly agreed to vet this post for technical accuracy, for which I thank him.

Anyway, let's get on with it, shall we?

### Installation On Linux (an Apt Approach)

Note: You can just copy and paste these commands into a shell to avoid mistyping stuff, or go it the hard way and practice your touchtyping skills. Up to you.

First, let's establish access to the repository:

    sudo wget https://netcologne.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list

Second, set things up so apt-get won't complain about repositories that may not adhere 100% to its security protocols:

    sudo apt-get update --allow-insecure-repositories && sudo apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring && sudo apt-get update

Third, we do the actual installation (this does everything, the D language, GtkD wrappers and libraries, docs, the works):

	sudo apt-get install dmd-compiler dmd-doc libgtkd3-dev libgtkd3-doc

And one more command to install dmd-tools (which installs some coolness we'll talk about some day):

	sudo apt-get install dmd-tools
	
You should now have a working development environment for D and GtkD.

### One Way to Build

We're almost ready to compile some code, but first we need to find the wrappers and the static and/or shared gtk libraries. Open a shell and issue this command:

pkg-config --cflags --libs gtkd-3

What pkg-config does is query the list of installed software and find out which directories these things got stuffed into. But it does more than that. By including the `--cflags` directive, we get compiler flags we can copy and hand over to dmd.

So, navigate to a directory containing one of the GtkD code files and type this:

    dmd -de -w -m64  -I/usr/include/dmd/gtkd3 -L-L/usr/lib/x86_64-linux-gnu -L-L/usr/lib/i386-linux-gnu -L-l:libgtkd-3.so -L-l:libdl.so.2 -L--no-warn-search-mismatch -defaultlib=libphobos2.so <code-filename>.d -of<executable-filename>

Well, that was fun, although it's a bit much to type every time. Let's save some wear and tear on our fingers by finding...

### Another Way to Build

It turns out that if we surround that pkg-config command with back-ticks, we can use its output as arguments to dmd like this: 

	dmd -de -w -m64  `pkg-config --cflags --libs gtkd-3` <code-filename>.d -of<executable-filename>

Better, but this being Linux, we can pull a Bash trick to make it even easier.

### Alias Away the Typing

A default installation of *Linux Mint 19.1 xfce* doesn't have a `.bash_aliases` file, but creating one is not big deal:

	touch ~/.bash_aliases

Default permissions will work, so no need to mess with `chmod`. Then all you need to do is fire up an editor and add this:

    # D compiler command line alias for building with shared libraries
    alias dbuild="dmd -de -w -m64 `pkg-config --cflags --libs gtkd-3`"
    
    # D compiler command alias for building with static libraries
    alias dbuild_static="dmd `pkg-config --cflags --libs gtkd-3-static`"

After saving `.bash_aliases`, open a new shell (any shell opened before these aliases are added won’t recognize these aliases) and type either:

	dbuild <code_filename>.d

or

	dbuild_static <code_filename>.d

And if you want the executable filename to be different from the code filename, just add this to the end of either of the above:

	-of<executable_filename>

### Conclusion

And there you have it, installation instructions for *Linux Mint* plus two ways to build and link D source on Linux without typing yourself into an early grave.

I hope you enjoyed this Blog eXtra. I'll continue to spring these on you from time to time, covering such subjects as:

- using dub as a build tool,
- installing a GtkD development environment on FreeBSD, and
- various shortcuts I discover as things progress.
 
Until next time...

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/03/29/0022-grids.html">Previous: Grids</a>
	</div>
	<div style="float: right;">
		<a href="/2019/04/02/0023-radio-and-color-buttons.html">Next: Radio and Color Buttons</a>
	</div>
</div>
