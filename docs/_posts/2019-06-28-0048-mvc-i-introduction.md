---
title: "0048: MVC Part I - Introduction to the Model-View-Controller"
topic: mvc
layout: post
description: An introduction to GTK's Model-View-Controller architectural pattern.
author: Ron Tarrant

---

# 0048: MVC Part I - Introduction to the Model-View-Controller

Before we start...

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/017_mvc/mvc_017_01_mvc_and_the_user.png" alt="Figure 1: Model/View/Controller and the User" style="width: 500px; height: 314px;">
		<figcaption>
			Figure 1: Model/View/Controller and the User
		</figcaption>
	</figure>
</div>

There won’t be any code examples today, just lots of theory. Yeah, it'll be a lot to take in, but you might consider it a reference to use over the next four weeks as we wade through all this stuff. So, without further ado...

Today begins an exploration of a bunch of *GTK* widgets that use the **Model-View-Controller** (**MVC**) architectural pattern. In case you don’t know, in an **MVC** system, the user is presented with a UI to **Control** data in a **Model** which then updates the **View** (the UI). It’s a circular and flexible system wherein the **View** shows either some or all of the data stored in the **Model**. Also, a single behind-the-scenes **Model** can have its data displayed in more than one **View**, either simultaneously or by switching out one **View** for another.

Let’s look at these pieces one at a time starting with...

## The Model

<div class="inpage-frame">
	<figure class="right">
		<img src="/images/diagrams/017_mvc/mvc_017_01_model_table.png" alt="Firgure 2: The TreeModel is a table" style="width: 400px; height: 316px;">
		<figcaption>
			Firgure 2: The TreeModel is a table
		</figcaption>
	</figure>
</div>

‘**Model**’ is just another way of saying, “a system for storing data.” At its simplest, a `Model` is a single column—say, the days of the week. But if we add more columns showing a T-shirt color for each day, the number of words written per day, or whatever other data you may need to track, the `Model` now has columns and rows which constitutes a table. So in short, a `Model` is a table for storing data.

In *GTK* parlance, a **Model** is referred to as a `TreeModel` but, we rarely deal with the `TreeModel` directly unless we’re getting down-n-dirty. Instead, we instantiate one of the two storage objects derived from it...

## The ListStore and TreeStore

<div class="inpage-frame">
	<figure class="left">
		<img src="/images/diagrams/017_mvc/mvc_017_01_hierarchical_tree_model.png" alt="Figure 3: The TreeView is Hierarchical" style="width: 500px; height: 250px;">
		<figcaption>
			Figure 3: The TreeView is Hierarchical
		</figcaption>
	</figure>
</div>

In a nutshell, these two classes are expressions of the `TreeModel` with the following individual characteristics:

- the `ListStore` is a flat `TreeModel` with no hierarchy—a plain table as is shown in *Figure 2* above, in other words, and
- the `TreeStore` is a hierarchical `TreeModel` and its rows may contain descendant rows (see *Figure 3* below).

If it helps... the `TreeStore` is like a file browser in that any level can contain files and directories and those directories may contain other files and directories, etc., etc., ad infinitum.

## The Controller – Data Access Widgets

Because `TreeModel`s have rows and columns, we access the data as... well, rows or columns. To access columns, we have one widget, the `TreeViewColumn`, but for accessing rows, we have two:  

- the `TreeIter`, and
- the `TreePath`.

And there's a subtle, but important, difference between the two...

### The TreeIter

The `TreeIter` is a direct reference to a specified row in a `ListStore`. It's used for stuffing data into or retrieving data from a `ListStore`, one row at a time. The functions most often used for these operations are `setValue()` and `getValue()` respectively.

However, because it's a *direct* reference, a `TreeIter` may only be valid for a short time depending on whether or not the `ListStore` (or `TreeStore`) has had rows added or deleted. Also, it can only be used with the **Model** (`ListStore` or `TreeStore`) and not the **View**.

### The TreePath

The `TreePath` is not a direct, but rather a *logical* reference to a row number and the same `TreePath` is valid for both the **Model** and **View**.  

## The View: TreeView

This is the last of the acronym letters and it’s the visible widget that presents data to the user. Data is laid out in—yeah, that's right—columns.

And that leads us to the visible mechanisms that give the user control over the data. They are:

- the `TreeViewColumn`, and
- the `TreeSelection`.

## The TreeViewColumn

This object can be used to access column properties such as:

- the column header (which includes:),
	- the column’s name,
	- whether or not the header acts as a button for sorting,
- how the cells in a column are rendered (font, color, etc.),
- any and all `CellRenderer`s used to dress up column data. They can be:
	- `CellRendererCombo`,
	- `CellRendererPixbuf`,
	- `CellRendererProgress`,
	- `CellRendererSpin`,
	- `CellRendererSpinner`,
	- `CellRendererText`, and
	- `CellRendererToggle`.

As you may guess from this list, we have a lot of choice as to what can be be crammed into a column, either as primary data, companion data, or even functionality.

Something to note is that numbers are displayed as text, but despite that, because the **View** and **Model** are separate entities, numbers are stored as integers, floating point, or what-have-you. It's only when they're displayed in the **View** that they're treated as strings.

Multiple `CellRender`s can be stuffed into a single `TreeViewColumn` making it possible (if you wanna go so far) to decorate each row within the column in its own way or mix decoration and functionality in a single column.

*Note: `CellRenderer`s are not exclusively for use by `TreeViewColumn`s or, indeed, the `TreeView`. We’ll see them again later when we dig into* Cairo, GTK*’s vector-based graphics library.*

## The TreeSelection

This mechanism tracks such things as:

- which row or rows are selected, and
- which `SelectionMode` is set:
	- `NONE`,
	- `SINGLE`,
	- `BROWSE`, or
	- `MULTIPLE`.

The `SelectionMode` enum is defined in `generated/gtkd/gtk/c/types.d`.

## And Finally, the MVC Widgets

Here’s a list of the widgets that make full use of the **MVC** architectural pattern. We have:

-	the `TreeView`.

Only one? Well, yes, but there are two others that have very similar features and they are:

-	the `ComboBox`, and
-	the `ComboBoxText`.

But the difference is:

-	the `TreeView` uses the `TreeViewColumn` directly, whereas
-	the `ComboBox` and `ComboBoxText` implement the `CellLayout` interface which in turn uses the `TreeViewColumn`.

This difference between these two uses of the `TreeViewColumn` is minimal, but it allows us to take on this collection of widgets one at a time and get used to each separately before tackling them all in one example.

Other classes that implement the `CellLayout` interface are:

-	`CellView` (which works in conjunction with `CellArea` and `CellAreaContext`),
-	`IconView` (an alternative view of data using icons and labels, similar to a file browser with all details hidden), and
-	`EntryCompletion`.

But those are more of a **Model-View** (**MV**) implementation. And finally, there’s one other class that implements **MVC** and that’s:

-	`FontSelection`, which is used in the `FontSelectionDialog`.

We'll get into all this eventually, but for now, you have a more-or-less comprehensive list of all **GTK** `Widget`s that implement **MVC** in one way or another.

## Conclusion

And that’s the lowdown on *GTK*’s version of the **Model-View-Controller** architectural pattern. Next time, we’ll start off with the simplest of the widgets that follow this paradigm, The `ComboBoxText`. See you then.

<div class="blog-nav">
	<div style="float: left;">
		<a href="/2019/06/25/0047-scalebutton-and-volumebutton.html">Previous: ScaleButton & VolumeButton</a>
	</div>
	<div style="float: right;">
		<a href="/2019/07/02/0049-mvc-ii-comboboxtext.html">Next: ComboBoxText</a>
	</div>
</div>
