/*
 Diagram:
 
 MyMenuBar
 	FileMenuHeader
 		FileMenu
 			SmallRadioMenuItem
 			MediumRadioMenuItem
 			LargeRadioMenuItem
 			ExtraLargeRadioMenuItem
 			Exit
 */

import std.stdio;
import std.string; // for access to .length

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.CheckMenuItem; // onToggle() defined here
import gtk.RadioMenuItem;
import gtk.Widget;
import gdk.Event;
import glib.ListSG;

void main(string[] args)
{
    Main.init(args);

    TestRigWindow testRig = new TestRigWindow();
    
    Main.run();
    
} // main()


class TestRigWindow : MainWindow
{
	string title = "RadioMenuItems Example";
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
	FeatureRadioMenuItem[] featureItemArray;
	FeatureRadioMenuItem featureItem;
	ExitItem exitItem;
	
	ListSG group;
	
	this(ObservedFeaturesList extObservedList)
	{
		super();

		foreach(itemName; extObservedList.featureNames)
		{
			if(itemName == extObservedList.featureNames[0])
			{
				featureItem = new FeatureRadioMenuItem(group, extObservedList, itemName);
				group = featureItem.getGroup();
			}
			else
			{
				featureItem = new FeatureRadioMenuItem(group, extObservedList, itemName);
			}

			featureItemArray ~= featureItem;
			append(featureItem);
		}
		
		// this next line plus the foreach statement set the default
		extObservedList.setFeatureDefault();
		
		foreach(item; featureItemArray)
		{
			if(item.getLabel() == extObservedList.getDefaultFeature())
			{
				item.setActive(true);
			}
			else
			{
				item.setActive(false);
			}
		}

		exitItem = new ExitItem(extObservedList);
		append(exitItem);
		
	} // this()
	
} // class FileMenu


class FeatureRadioMenuItem : RadioMenuItem
{
	string labelText;
	ObservedFeaturesList observedList;
   
	this(ListSG group, ObservedFeaturesList extObservedList, string extLabelText)
	{
		labelText = extLabelText;
		super(group, labelText);

		observedList = extObservedList;
		addOnToggled(&toggleFeature);
		
	} // this()
	
	
	void toggleFeature(CheckMenuItem mi) // defined in superclass
	{
		if(getActive() == true)
		{
			observedList.setFeature(labelText);
		}
		
	} // toggleFeature()
	
} // class FeatureRadioMenuItem


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
	string[] featureNames;
	string defaultFeatureName;

	this()
	{
		defaultFeatureName = "Large";
		featureNames = ["Small", "Medium", "Large", "Extra Large"];
		
	} // this()
	
	
	void setFeatureDefault()
	{
		for(int i = 0; i < featureNames.length; i++)
		{
			string featureName = featureNames[i];
			
			if(featureName == defaultFeatureName)
			{
				features[featureName] = true;
			}
			else
			{
				features[featureName] = false;
			}
		}

	} // setFeatureDefault()
	
	
	void setFeature(string featureName)
	{
		foreach(feature, state; features)
		{
			if(feature == featureName)
			{
				features[feature] = true;
			}
			else
			{
				features[feature] = false;
			}
		}
		
	} // setFeature()


	string getDefaultFeature()
	{
		return(defaultFeatureName);
	}	
	
	
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
