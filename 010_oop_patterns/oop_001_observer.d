// an implementation of the observer class in D
import std.stdio;

void main()
{
	Observed observed = new Observed();
	
	writeln("observer1...");
	Observer observer1 = new Observer(observed);
	
	writeln("observer2...");
	Observer observer2 = new Observer(observed);

	writeln("Switching via observer2");
	observer2.makeSwitch();

	writeln("as seen from observer1, switch is now...", observer1.observed.switcher);
	writeln("as seen from observer2, switch is now...", observer2.observed.switcher);

	writeln("Switching via observer1");
	observer1.makeSwitch();

	writeln("as seen from observer1, switch is now...", observer1.observed.switcher);
	writeln("as seen from observer2, switch is now...", observer2.observed.switcher);
	
} // main()


class Observer
{
	Observed observed;
	
	this(Observed myObserved)
	{
		observed = myObserved;
		writeln("Observed = ", observed.switcher, ".");
		
	} // this()
	
	
	void makeSwitch()
	{
		observed.change();
		
	} // makeSwitch()
	
} // class Observer


class Observed
{
	private:
	bool switcher;
	
	this()
	{
		switcher = false;
		
	} // this()
	
	// end private
	
	public:
	
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
