// an implementation of the observer class in D
import std.stdio;

void main()
{
	ThingOfInterest observed = new ThingOfInterest();
	
	writeln("watcher1...");
	Watcher watcher1 = new Watcher(observed);
	
	writeln("watcher2...");
	Watcher watcher2 = new Watcher(observed);

	writeln("Switching via watcher2");
	watcher2.makeSwitch();

	writeln("as seen from Watcher #1, switch is now...", watcher1.observed.switcher);
	writeln("as seen from Watcher #2, switch is now...", watcher2.observed.switcher);

	writeln("Switching via watcher1");
	watcher1.makeSwitch();

	writeln("as seen from watcher1, switch is now...", watcher1.observed.switcher);
	writeln("as seen from watcher2, switch is now...", watcher2.observed.switcher);
	
} // main()


class Watcher
{
private:
	ThingOfInterest observed;
	
	this(ThingOfInterest myThingOfInterest)
	{
		observed = myThingOfInterest;
		writeln("ThingOfInterest = ", observed.switcher, ".");
		
	} // this()
// end of private

public:
	void makeSwitch()
	{
		observed.change();
		
	} // makeSwitch()
	
} // class Watcher


class ThingOfInterest
{
	private:
	string switcher;
	
	this()
	{
		switcher = "Off";
		
	} // this()
	
	// end private
	
	public:
	
	void change()
	{
		if(switcher == "On")
		{
			switcher = "Off";
		}
		else
		{
			switcher = "On";
		}
	}

} // class ThingOfInterest
