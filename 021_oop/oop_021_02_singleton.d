// This source code is in the public domain.

// An example of a Singleton written in the D language

import std.stdio;

void main()
{
	DSingleton singleton, singleton2, singleton3;
	
	writeln("\nInstantiating...\n");
	
	singleton = singleton.get();
	writeln("First singleton instantiated.\n");
	singleton2 = singleton.get();
	writeln("Second singleton instantiated.\n");
	singleton3 = singleton.get();
	writeln("Third singleton instantiated.\n\n");
			
	writeln("All instantiation is now done and we have:");
	
	write("The 1st singleton pointer is stored at: ", &singleton, " and points to ");
	singleton.getInstance();
	write("The 2nd singleton pointer is stored at: ", &singleton2, " and points to ");
	singleton.getInstance();
	write("The 3rd singleton pointer is stored at: ", &singleton3, " and points to ");
	singleton.getInstance();
	
} // main()


class DSingleton
{
	private:
	// Cache instantiation flag in thread-local bool
	static bool instantiated_;

	// Thread global
	__gshared DSingleton instance_;

	this() {}
	
	public:
	
	static DSingleton get()
	{
		if(!instantiated_)
		{
			synchronized(DSingleton.classinfo)
			{
				if(!instance_)
				{
					instance_ = new DSingleton();
					write("Creating the singleton and");
				}

				instantiated_ = true;
			}
		}
		else
		{
			write("Singleton already exists, so just");
		}

		writeln(" returning an instance.");
		
		return(instance_);
		
	} // get()


	DSingleton* getInstance()
	{
		writeln("the Singleton instance at ", &instance_);
		return(&instance_);
		
	} // getInstance()
	
} // class DSingleton
