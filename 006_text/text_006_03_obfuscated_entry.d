// Entry widget
// Notes:
//   may need an observer - rethink, rewrite

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Button;
import gtk.Widget;
import gtk.Box;
import gtk.CheckButton;
import gtk.ToggleButton;                                                        // *** NOTE *** needed for toggle signal

void main(string[] args)
{
	Main.init(args);

	testRigWindow testRig = new testRigWindow();
	
	Main.run();
	
} // main()


class testRigWindow : MainWindow
{
	string titleText = "Entry Obfuscated";
	
	LoginBox entryBox;
		
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entryBox = new LoginBox();
		add(entryBox);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("Your password is: ", entryBox.passwordEntry.getText());
		
	} // endProgram()
	
} // class testRigWindow


class LoginBox : Box
{
	int padding = 5;

	Entry usernameEntry, passwordEntry;
	CheckButton checkButton;
	string checkText = "Visibility";
	
	this()
	{
		super(Orientation.VERTICAL, padding);

		usernameEntry = new Entry();
		passwordEntry = new Entry();
		passwordEntry.setVisibility(false);
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&passwordVisibility);
		checkButton.setActive(false);
		
		add(usernameEntry);
		add(passwordEntry);
		add(checkButton);
		
	} // this()
	
	
	void passwordVisibility(ToggleButton button)
	{
		string messageEnd;
		
		bool answer = button.getActive();
		
		if(button.getActive() == true)
		{
			messageEnd = " I can shoulder surf your password.";
		}
		else
		{
			messageEnd = " I canNOT shoulder surf your password.";
		}
		
		passwordEntry.setVisibility(button.getActive());
		writeln("With ", button.getLabel(), " set to ", button.getActive(), messageEnd);
		
	} // passwordVisibility()

} // class LoginBox
