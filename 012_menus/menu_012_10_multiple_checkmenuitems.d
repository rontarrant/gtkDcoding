/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			ExtraLargeCheckMenuItem
 			FancyCheckMenuItem
 			FortifiedCheckMenuItem
 			Soft&FluffyCheckMenuItem
 			Exit
 */

import std.stdio;

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.CheckMenuItem;
import gtk.Widget;
import gdk.Event;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "CheckMenuItem Example";
	ObservedFeaturesList observedList;

	this()
	{
		super(title);
		setDefaultSize(640, 480);
		addOnDestroy(&quitApp);

		observedList = new ObservedFeaturesList();
		
		AppBox appBox = new AppBox(observedList);
		add(appBox);
		
		showAll();
		
	} // this()
	
	
	void quitApp(Widget w)
	{
		observedList.listFeatures();
		
		Main.quit();
		
	} // quitApp()
	
} // TestRigWindow


class AppBox : Box
{
	int padding = 10;
	MyMenuBar menuBar;
	
	this(ObservedFeaturesList extObservedList)
	{
		super(Orientation.VERTICAL, padding);
		
		menuBar = new MyMenuBar(extObservedList);
    	packStart(menuBar, false, false, 0);		
		
	} // this()
	
} // class AppBox


class MyMenuBar : MenuBar
{
	FileMenuHeader fileMenuHeader;
	
	this(ObservedFeaturesList extObservedList)
	{
		super();
		
		fileMenuHeader = new FileMenuHeader(extObservedList);
		append(fileMenuHeader);		
		
	} // this()

	
} // class MyMenuBar


class FileMenuHeader : MenuItem
{
	string headerTitle = "File";
	FileMenu fileMenu;
	
	this(ObservedFeaturesList extObservedList)
	{
		super(headerTitle);
		
		fileMenu = new FileMenu(extObservedList);
		setSubmenu(fileMenu);
		
		
	} // this()
	
} // class FileMenu


class FileMenu : Menu
{
	FeatureCheckMenuItem[] featureItemArray;
	FeatureCheckMenuItem featureItem;
	ExitItem exitItem;
	
	this(ObservedFeaturesList extObservedList)
	{
		super();
		
		foreach(itemKey, itemValue; extObservedList.features)
		{
			featureItem = new FeatureCheckMenuItem(extObservedList, itemKey);
			featureItemArray ~= featureItem;
			append(featureItem);
		}
		
		exitItem = new ExitItem(extObservedList);
		append(exitItem);
		
	} // this()

} // class FileMenu


class FeatureCheckMenuItem : CheckMenuItem
{
	string labelText;
	ObservedFeaturesList observedList;
   
	this(ObservedFeaturesList extObservedList, string extLabelText)
	{
		labelText = extLabelText;
		super(labelText);

		observedList = extObservedList;
		addOnToggled(&toggleFeature);
		setActive(observedList.getFeature(labelText));
		
	} // this()
	
	
	void toggleFeature(CheckMenuItem mi)
	{
		if(getActive() == true)
		{
			observedList.setFeature(labelText, true);
		}
		else
		{
			observedList.setFeature(labelText, false);
		}
		
	} // toggleFeature()
	
} // class FeatureCheckMenuItem


class ExitItem : MenuItem
{
	string exitLabel = "Exit";
	ObservedFeaturesList observedList;
   
	this(ObservedFeaturesList extObservedList)
	{
		super(exitLabel);
		addOnActivate(&exit);
		observedList = extObservedList;
		
	} // this()
	
	
	void exit(MenuItem mi)
	{
		observedList.listFeatures();
		
		Main.quit();
		
	} // exit()
	
} // class FileMenuItem


class ObservedFeaturesList
{
	bool[string] features;

	this()
	{
		features = ["Fancy" : true, "Fortified" : false, "Extra Large" : false, "Soft & Fluffy" : true];
		
	} // this()
	
	
	void setFeature(string featureName, bool state)
	{
		features[featureName] = state;
		
	} // setFeature()
	
	
	bool getFeature(string featureName)
	{
		return(features[featureName]);
		
	} // getFeature()
	
	
	void listFeatures()
	{
		foreach(name, feature; features)
		{
			writeln(name, " = ", feature);
		}
		
	} // listFeatures()
	
} // class ObservedFeaturesList
