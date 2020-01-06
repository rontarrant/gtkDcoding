// This source code is in the public domain.

// an implementation of the observer class in D
import std.stdio;

void main()
{
	// initialize objects
	Subject subject = new Subject();
	Observer observer1 = new Observer("First Observer...", subject);
	Observer observer2 = new Observer("Second Observer..", subject);
	
	// change state
	for(int i; i < 4; i++)
	{
		writeln("\nChanging state of Subject...");
		subject.change();
		observer1.reportState();
		observer2.reportState();
	}
	
} // main()


class Observer
{
	string idString;
	bool subjectState;
	
	this(string id, Subject subject)
	{
		idString = id;
		subjectState = subject.addObserver(this);
		
	} // this()
	
	
	void updateSubjectState(bool newState)
	{
		subjectState = newState;
		
	} // updateSubjectState()
	
	
	void reportState()
	{
		writeln("Viewing from ", idString, ". The subject's state is now: ", subjectState);

	} // reportState()
	
} // class Observer


class Subject
{
	bool switcherState;
	Observer[] observers;
	
	this()
	{
		switcherState = false;
		
	} // this()


	bool addObserver(Observer observer)
	{
		observers ~= observer;
		
		return(switcherState);
		
	} // addObserver()
	
	
	void updateAll()
	{
		foreach(observer; observers)
		{
			observer.updateSubjectState(switcherState);
			
		}
		
	} // updateAll()
	
	
	void change()
	{
		if(switcherState == true)
		{
			switcherState = false;
		}
		else
		{
			switcherState = true;
		}
		
		updateAll();
		
	} // change()

} // class Subject
