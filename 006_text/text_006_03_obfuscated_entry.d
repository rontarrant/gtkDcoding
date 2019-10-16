// This source code is in the public domain.

// non-readable Entry

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Button;
import gtk.Widget;
import gtk.Box;
import gtk.CheckButton;
import gtk.ToggleButton;                // *** NOTE *** needed for toggle signal

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "Entry Obfuscated";
	LoginBox loginBox;
		
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		loginBox = new LoginBox();
		add(loginBox);
		
		showAll();
		
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("Your password is: ", loginBox.passwordEntry.getText());
		
	} // endProgram()
	
} // class TestRigWindow


class LoginBox : Box
{
	int globalPadding = 5;

	Entry usernameEntry, passwordEntry;
	CheckButton checkButton;
	string checkText = "Visibility";
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);

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
			messageEnd = " I can shoulder-surf your password.";
		}
		else
		{
			messageEnd = " I canNOT shoulder-surf your password.";
		}
		
		passwordEntry.setVisibility(button.getActive());
		writeln("With ", button.getLabel(), " set to ", button.getActive(), messageEnd);
		
	} // passwordVisibility()

} // class LoginBox
