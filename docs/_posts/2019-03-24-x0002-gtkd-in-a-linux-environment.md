# GtkD Linux Development Environment

Okay, hold onto your hat, because we’re gonna install and test a D language development environment on Linux.

Disclaimer:
I’ve been away from Linux for a donkey’s age, so at this moment, I’ve only done this with Linux Mint 19.1. If you have another distro, you’ll find installation instructions here: https://dlang.org/download.html

## Installation On Linux (the Apt Approach)

Note: You can just copy and paste these commands into a shell to avoid mistyping stuff, or go it the hard way. Up to you.

First, let's establish access to the repository:

    sudo wget https://netcologne.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list

Second, the following command will either install the packages if you don't have them, or update them if you do:

    sudo apt-get update --allow-insecure-repositories && sudo apt-get -y --allow-unauthenticated install --reinstall d-apt-keyring && sudo apt-get update

Thirdly, one command that installs the two final packages, dmd-bin and dmd-tools:

	sudo apt install dmd-bin

## One Way to Build

Now you should be ready to compile some code. Open a shell and navigate to a directory containing one of the GtkD code files. You have two choices, the first of which is:

    dmd -de -w -m64 `pkg-config --cflags --libs gtkd-3` <code-filename>.d -of<executable-filename>

## Another Way

The more familiar way, the way we’ve been working in Windows until now, will necessitate finding where all things D got placed during installation.

A quick:

    ls -la

tells us there’s a hidden directory in /home/[username]/:

    .dub

and that’s where it all ended up. Update your *locate* database if you haven't already:

    sudo updatedb

and you’ll be able to find the runtime library as well as the wrapper files (GtkD is built from a collection of D language wrappers that call library stubs with C-oriented names):

.dub/packages/gtk-d-3.8.5/gtk-d/generated/gtkd (wrapper)

.dub/packages/gtk-d-3.8.5/gtk-d/libgtkd-3.a (runtime)

Knowing that, we can now issue a compile command like this:

    dmd -de -w -m64 -I=/home/ron/.dub/packages/gtk-d-3.8.5/gtk-d/generated/gtkd -L/home/ron/.dub/packages/gtk-d-3.8.5/gtk-d/libgtkd-3.a <file>.d

But, hey, that’s a lot of typing. This being Linux, however, there are mucho-many ways to get around that by pulling a Bash trick or three.

## Simplifying Compiler Directives

The two ways that come to mind are:

- aliases, and
- environment variables.

But if we use environment variables (assigned in $HOME/.bashrc) to point at the locations of the wrapper code and the runtime library:

	# set up environment for GtkD development
	if [ -d "$HOME/.dub" ] ; then
	    gtkd_wrapper="$HOME/.dub/packages/gtk-d-3.8.5/gtk-d/generated/gtkd"
	    export gtkd_wrapper
	    gtkd_runtime="$HOME/.dub/packages/gtk-d-3.8.5/gtk-d/libgtkd-3.a"
	    export gtkd_runtime
	fi

we’ll still want to pull them together into a short-n-sweet alias (in $HOME/.bash_aliases) that keeps typing down to a minimum:

	alias dbuild="dmd -de -w -m64 -I=$gtkd_wrapper -L$gtkd_runtime <code-file>.d"

This would work, but there's really no benefit to fiddling with both .bashrc and .bash_aliases when we could just create an alias and be done with it. It's not like we'll ever want one of those paths without the other... will we?

### Aliasing

A default installation of Linux Mint 19.1 XFCE doesn't have a .bash_aliases, but creating one is not big deal:

	touch ~/.bash_aliases

Will do it for you. And default permissions are fine, so no need to mess with chmod. Then all you need to do is fire up an editor and add one of these (we'll do both, but you can pick just one if you prefer):

    # for the first D compiler command line directive example
    alias dbuild="dmd -de -w -m64 `pkg-config --cflags --libs gtkd-3`"

    # for the second:
    alias dbuild2="dmd -de -w -m64 -L$HOME/.dub/packages/gtk-d-3.8.5/gtk-d/libgtkd-3.a -I=$HOME/.dub/packages/gtk-d-3.8.5/gtk-d/generated/gtkd"

After saving `.bash_aliases`, open a new shell (any shell opened before these aliases are added won’t have access) and type either:

	dbuild <code_filename>.d

or

	dbuild2 <code_filename>.d

And if you want the executable filename to be different from the code filename, just add this to the end of either of the above:

	-of<executable_filename>

## Conclusion

And there you have it, installation instructions plus two different approaches to compiling D source from a Linux shell as well as two ways to alias away extra typing so you can save your fingers for other things.

I hope you enjoyed this Blog eXtra. Next one will be about using dub for compiling and will cover both Windows and Linux, maybe even FreeBSD, if I figure out this triple-boot thing.

Until then...
