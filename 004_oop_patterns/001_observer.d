// an implementation of the observer class in D
import std.stdio;

void main()
{
	Observer observer1 = new Observer();
	Observer observer2 = new Observer();
	
} // main()


class Observer
{
	Observed observed;
	
	this()
	{
		observed = new Observed();
		
	} // this()
	
} // class Observer


class Observed
{
	bool switcher;
	
	this()
	{
		switcher = false;
		
	} // this()
	
	
	void change()
	{
		if(switcher == true)
		{
			switcher = false;
		}
		else
		{
			switcher = true;
		}
	}

} // class Observed
